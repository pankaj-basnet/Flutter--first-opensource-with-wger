// lib/main.dart
// Application entry point.
// Fetches the NutritionalPlan from the Django backend (or mock JSON),
// then passes the db instance to the form via DI — no Riverpod inside the form.

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:realflutter/database/powersync/database.dart';
import 'package:realflutter/l10n/generated/app_localizations.dart';
import 'package:realflutter/models/nutrition/nutritional_plan.dart';
import 'package:realflutter/theme/theme.dart';
import 'package:realflutter/widgets/nutrition/forms.dart';

// ── Backend base URL ────────────────────────────────────────────────────────
// For Android emulator: 10.0.2.2 maps to host localhost.
// For iOS simulator:    localhost or 127.0.0.1 works directly.
// Replace with your machine's LAN IP when testing on a physical device.
const String _kBackendBase = 'http://10.0.2.2:8000';

// Hardcoded Basic-Auth credentials matching seed_mock_data.py
const String _kUsername = 'user';
const String _kPassword = 'flutteruser';

void main() {
  // ProviderScope MUST wrap runApp — this is the root of all Riverpod providers.
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// Fetches the first NutritionalPlan from Django with Basic Auth.
  /// Falls back to embedded mock JSON if the network call fails.
  Future<NutritionalPlan> _loadPlan() async {
    try {
      final credentials = base64Encode(utf8.encode('$_kUsername:$_kPassword'));
      final response = await http
          .get(
            Uri.parse('$_kBackendBase/api/nutritionalplans/'),
            headers: {'Authorization': 'Basic $credentials'},
          )
          .timeout(const Duration(seconds: 5));

      // final response = await http.get(
      //   Uri.parse('$_kBackendBase/api/v2/nutritionplan/'),
      //   headers: {'Authorization': 'Basic $credentials'},
      // );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        // DRF paginates — results is a list; take the first plan and fetch full
        final results = body['results'] as List<dynamic>;
        if (results.isNotEmpty) {
          final planId = results.first['id'];
          final fullResponse = await http.get(
            Uri.parse('$_kBackendBase/api/nutritionalplans/$planId/full/'),

            // // AFTER:
            // Uri.parse(
            //   '$_kBackendBase/api/v2/nutritionplan/$planId/nutritional_values/',
            // ),
            // // OR the full nested endpoint:
            // Uri.parse('$_kBackendBase/api/v2/nutritionplan/$planId/view/'),

            headers: {'Authorization': 'Basic $credentials'},
          );
          if (fullResponse.statusCode == 200) {
            return NutritionalPlan.fromJson(
              jsonDecode(fullResponse.body) as Map<String, dynamic>,
            );
          }
        }
      }
    } catch (_) {
      // Network unavailable or backend not running — fall through to mock data
    }
    // ── Embedded mock JSON (matches the fixture in the project brief) ──────
    return NutritionalPlan.fromJson(_mockPlanJson);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RealFlutter',
      theme: rfLightTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: FutureBuilder<NutritionalPlan>(
        future: _loadPlan(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(child: Text('Error: ${snapshot.error}')),
            );
          }
          if (snapshot.hasData) {
            // Consumer gives us a ref inside a StatelessWidget build method.
            return Consumer(
              builder: (context, ref, _) {
                final db = ref.read(driftPowerSyncDatabase);
                return getIngredientLogForm(snapshot.data!, db);
              },
            );
          }
          return const Scaffold(body: Center(child: Text('No data.')));
        },
      ),
    );
  }
}

// ── Mock plan JSON ────────────────────────────────────────────────────────────
// Used when Django is unreachable. Matches the fixture in the project brief.
const _mockPlanJson = {
  'id': 'plan-uuid-001',
  'name': 'Lean Bulk Plan',
  'meals': [
    {
      'id': 'meal-uuid-001',
      'name': 'Breakfast',
      'time': '08:00',
      'mealItems': [
        {
          'id': 'item-uuid-001',
          'ingredientId': 101,
          'amount': 100,
          'ingredient': {
            'id': 101,
            'name': 'Oatmeal',
            'energy': 389,
            'protein': 13,
            'carbohydrates': 66,
            'fat': 7,
          },
        },
      ],
    },
    {
      'id': 'meal-uuid-002',
      'name': 'Snacks',
      'time': '10:00',
      'mealItems': [
        {
          'id': 'item-uuid-002',
          'ingredientId': 104,
          'amount': 100,
          'ingredient': {
            'id': 104,
            'name': 'juice',
            'energy': 285,
            'protein': 13,
            'carbohydrates': 66,
            'fat': 7,
          },
        },
      ],
    },
  ],
  'diaryEntries': [
    {
      'planId': 'plan-uuid-001',
      'mealId': 'meal-uuid-001',
      'datetime': '2026-06-03T08:00:00Z',
      'mealItem': {
        'id': 'item-uuid-001',
        'mealId': 'meal-uuid-001',
        'ingredientId': 101,
        'amount': 100,
        'ingredient': {
          'id': 101,
          'name': 'Oatmeal (History Mock)',
          'created': '2026-06-03T12:00:00Z',
          'energy': 389,
          'carbohydrates': '66.0',
          'protein': '13.0',
          'fat': '7.0',
          'is_vegan': true,
          'is_vegetarian': true,
          'nutriscore': 'a',
          'weight_units': [],
        },
      },
    },
  ],
};
