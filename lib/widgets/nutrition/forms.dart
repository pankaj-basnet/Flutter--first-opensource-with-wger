import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realflutter/l10n/generated/app_localizations.dart';

typedef NutritionalPlan = Map<String, dynamic>;
typedef MealItem = Map<String, dynamic>;
typedef LogItem = Map<String, dynamic>;

Widget getIngredientLogForm({NutritionalPlan? plan}) {
  return IngredientForm(
    plan: plan!,
    // plan: const {
    //   "id": 1,
    //   "name": "Mass Gain Phase 1",
    //   "description": "High protein meal layout designed around wger ingredients specification.",
    //   "creation_date": "2026-05-29",
    //   "meals": [
    //     {
    //       "id": 101,
    //       "name": "Post-Workout Shake",
    //       "time": "08:30:00",
    //       "items": [
    //         {
    //           "ingredient_id": 412,
    //           "name": "Whey Protein Isolate",
    //           "amount": 40.0,
    //           "unit": "g",
    //         },
    //         {
    //           "ingredient_id": 718,
    //           "name": "Oat Milk",
    //           "amount": 300.0,
    //           "unit": "ml",
    //         },
    //       ],
    //     },
    //     {
    //       "id": 102,
    //       "name": "Lunch - High Carb Lean",
    //       "time": "13:00:00",
    //       "items": [
    //         {
    //           "ingredient_id": 105,
    //           "name": "Chicken Breast (Grilled)",
    //           "amount": 200.0,
    //           "unit": "g",
    //         },
    //         {
    //           "ingredient_id": 204,
    //           "name": "Basmati Rice (Cooked)",
    //           "amount": 150.0,
    //           "unit": "g",
    //         },
    //       ],
    //     },
    //   ],
    // },
    recent: const [],
    onSave: (
      BuildContext context,
      WidgetRef ref,
      Map<String, dynamic> meal,
      DateTime? dt,
    ) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            // SAFE FALLBACK: If localization fails, use 'Ingredient Logged'
            AppLocalizations.of(context)?.ingredientLogged ?? 'Ingredient Logged',
            textAlign: TextAlign.center,
          ),
        ),
      );
    },
    withDate: true,
  );
}

class IngredientForm extends ConsumerStatefulWidget {
  final NutritionalPlan plan; 
  final Function(
    BuildContext context,
    WidgetRef ref,
    MealItem meal,
    DateTime? dt,
  ) onSave;
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
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.withDate) {
      _selectedDate = DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    final planData = widget.plan;
    final planName = planData['name'] ?? 'Nutritional Plan';
    final planDescription = planData['description'] ?? '';
    final List<dynamic> meals = planData['meals'] ?? [];

    return Scaffold(
      appBar: AppBar(
        // SAFE FALLBACK: If localization fails, use 'Log Ingredient'
        title: Text(AppLocalizations.of(context)?.logIngredient ?? 'Log Ingredient'),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      planName,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      planDescription,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8),
                          ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            if (widget.withDate) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Logging Date:',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  OutlinedButton.icon(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate ?? DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (picked != null) {
                        setState(() {
                          _selectedDate = picked;
                        });
                      }
                    },
                    icon: const Icon(Icons.calendar_month),
                    label: Text(_selectedDate.toString().split(' ')[0]),
                  ),
                ],
              ),
              const Divider(height: 30),
            ],

            Text(
              'Select a Meal to Log:',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index] as Map<String, dynamic>;
                final mealName = meal['name'] ?? 'Unnamed Meal';
                final mealTime = meal['time'] ?? '--:--';
                final List<dynamic> items = meal['items'] ?? [];

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.restaurant_menu, color: Colors.deepPurple),
                                const SizedBox(width: 8),
                                Text(
                                  mealName,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                            Chip(
                              avatar: const Icon(Icons.access_time, size: 16),
                              label: Text(mealTime),
                              backgroundColor: Colors.grey.shade100,
                            ),
                          ],
                        ),
                        const Divider(),
                        
                        ...items.map<Widget>((item) {
                          final itemName = item['name'] ?? 'Unknown Ingredient';
                          final amount = item['amount'] ?? 0.0;
                          final unit = item['unit'] ?? '';
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                            child: Row(
                              children: [
                                const Icon(Icons.scale_outlined, size: 16, color: Colors.grey),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    itemName,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                                Text(
                                  '$amount $unit',
                                  style: const TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          );
                        }),
                        
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            onPressed: () {
                              widget.onSave(context, ref, meal, _selectedDate);
                            },
                            icon: const Icon(Icons.check_circle_outline),
                            label: Text('Log "$mealName"'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}