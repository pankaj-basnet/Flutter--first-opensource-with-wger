import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:realflutter/l10n/generated/app_localizations.dart';

typedef NutritionalPlan = Map<String, dynamic>;
typedef MealItem = Map<String, dynamic>;
typedef LogItem = Map<String, dynamic>;

Widget getIngredientLogForm(NutritionalPlan plan) {
  return IngredientForm(
    plan: plan, // Pass the plan to the form widget
    recent: const [],
    onSave:
        (
          BuildContext context,
          WidgetRef ref,
          Map<String, dynamic> meal,
          DateTime? dt,
        ) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(context).ingredientLogged,
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
    withDate: true,
  );
}

class IngredientForm extends ConsumerStatefulWidget {
  final NutritionalPlan plan; // Added property to hold the data
  final Function(
    BuildContext context,
    WidgetRef ref,
    MealItem meal,
    DateTime? dt,
  )
  onSave;
  final List<LogItem> recent;
  final bool withDate;
  final String barcode;
  final bool test;

  const IngredientForm({
    super.key,
    required this.plan,
    required this.recent,
    required this.onSave,
    required this.withDate,
    this.barcode = '',
    this.test = false,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IngredientFormState();
}

class _IngredientFormState extends ConsumerState<IngredientForm> {
  @override
  Widget build(BuildContext context) {
    // Accessing the plan through the widget property
    final planData = widget.plan;

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).logIngredient)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Fetched Data Keys from GitHub:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            // Loop through and show the keys/values or string format of the plan
            Expanded(
              child: ListView(
                children: [
                  Text(JsonEncoder.withIndent('  ').convert(planData)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
