import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:realflutter/database/powersync/database.dart';
import 'package:realflutter/l10n/generated/app_localizations.dart';
import 'package:realflutter/models/nutrition/nutritional_plan.dart';
import 'package:realflutter/theme/theme.dart';
import 'package:realflutter/widgets/nutrition/forms.dart';
import 'package:realflutter/database/nutrition_repository.dart';

const String _kBackendBase = 'http://10.0.2.2:8000';

// Hardcoded Basic-Auth credentials matching seed_mock_data.py
const String _kUsername = 'user';
const String _kPassword = 'flutteruser';

void main() {
  // ProviderScope is kept to satisfy root configurations without DB providers
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final Future<NutritionalPlan> _planFuture;

  @override
  void initState() {
    super.initState();
    _planFuture = _loadPlan();
  }

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

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        // DRF paginates — results is a list; take the first plan and fetch full
        final results = body['results'] as List<dynamic>;
        if (results.isNotEmpty) {
          final planId = results.first['id'];
          final fullResponse = await http.get(
            Uri.parse('$_kBackendBase/api/nutritionalplans/$planId/full/'),
            headers: {'Authorization': 'Basic $credentials'},
          );
          if (fullResponse.statusCode == 200) {
            return NutritionalPlan.fromJson(
              jsonDecode(fullResponse.body) as Map<String, dynamic>,
            );
          }
        }
        return NutritionalPlan.fromJson(_mockPlanJson);
      }
    } catch (e) {
      // Network unavailable or backend not running — fall through to mock data
      debugPrint(
        '[_loadPlan] Backend unreachable, using mock data. Reason: $e',
      );
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

      // home: getIngredientLogForm(
      //   NutritionalPlan.fromJson(_mockPlanJson),
      //   null, // Pass null to isolate the UI screens from database operations
      // ),
      // ================================
      // home: Consumer(
      //   builder: (context, ref, _) {
      //     final db = ref.read(driftPowerSyncDatabase);
      //     // return getIngredientLogForm(snapshot.data!, db);
      //     return getIngredientLogForm(
      //       NutritionalPlan.fromJson(_mockPlanJson),
      //       db,
      //     );
      //   },
      // ),
      // ================================
      home: _DriftSeedingHome(planFuture: _planFuture),
    );
  }
}

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return getIngredientLogForm(NutritionalPlan.fromJson(_mockPlanJson), null);
//   }
// }

// ── _DriftSeedingHome ─────────────────────────────────────────────────────────
//
// Responsibilities:
//   1. Wait for the plan to be loaded from REST / mock JSON
//   2. Seed it into Drift (idempotent — safe to re-run)
//   3. Hand off to IngredientLogScreen which streams from Drift
//
// Only this widget reads Riverpod (to get db). Nutrition widgets below it
// receive NutritionRepository via constructor — no Riverpod imports needed.

class _DriftSeedingHome extends ConsumerStatefulWidget {
  final Future<NutritionalPlan> planFuture;

  const _DriftSeedingHome({required this.planFuture});

  @override
  ConsumerState<_DriftSeedingHome> createState() => _DriftSeedingHomeState();
}

class _DriftSeedingHomeState extends ConsumerState<_DriftSeedingHome> {
  late Future<String> _seededPlanIdFuture;

  @override
  void initState() {
    super.initState();
    _seededPlanIdFuture = _seedAndReturnId();
  }

  Future<String> _seedAndReturnId() async {
    final db = ref.read(driftPowerSyncDatabase);
    final repo = NutritionRepository(db);
    final plan = await widget.planFuture;
    await repo.seedPlanIfAbsent(plan);
    return plan.id;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _seededPlanIdFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Startup error: ${snapshot.error}')),
          );
        }

        final planId = snapshot.data!;
        final db = ref.read(driftPowerSyncDatabase);
        // From this point on: only planId travels down.
        // The StreamBuilder in IngredientLogScreen handles reactivity.
        return getIngredientLogForm(planId, db);
      },
    );
  }
}

// - Mock plan JSON -
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
