import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realflutter/l10n/generated/app_localizations.dart';

typedef NutritionalPlan = Map<String, dynamic>;
typedef MealItem = Map<String, dynamic>;
typedef LogItem = Map<String, dynamic>;

Widget getIngredientLogForm(NutritionalPlan plan) {
  return IngredientForm(
    plan: plan,
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

/// Form to pick an ingredient (and amount) to log to a diary
class IngredientForm extends ConsumerStatefulWidget {
  final NutritionalPlan plan;
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
    this.barcode = '', // wger's ingredient barcode scanner
    this.test = false,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => IngredientFormState();
}

class IngredientFormState extends ConsumerState<IngredientForm> {
  final _form = GlobalKey<FormState>();
  final _ingredientIdController = TextEditingController();

  TextEditingController get ingredientIdController => _ingredientIdController;
  late MealItem _localMealItem;

  MealItem get mealItem => _localMealItem;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();

    _localMealItem = {
      'id': null,
      'ingredient_id': 0,
      'amount': 0.0,
      'weight_unit_id': null,
      'ingredient_name': '',
    };
  }

  @override
  Widget build(BuildContext context) {
    final planData = widget.plan;

    final i18n = AppLocalizations.of(context);
    final pcolor = Theme.of(context).colorScheme.onPrimary;

    final appBarBackground = Theme.of(context).colorScheme.primary;
    final appBarForeground = Theme.of(context).colorScheme.onPrimary;

    // Hardcoded layout properties for testing component behavior
    const String staticUnitLabel = 'g';
    final List<Map<String, dynamic>> mockSuggestions = [
      {
        'id': 101,
        'name': 'Oats',
        'amount': 50.0,
        'macros': '190 kcal | P: 7g | C: 32g | F: 3g',
      },
      {
        'id': 101,
        'name': 'Oats Premium',
        'amount': 50.0,
        'macros': '250 kcal | P: 10g | C: 30g | F: 5g',
      },
      {
        'id': 202,
        'name': 'Whey Protein',
        'amount': 30.0,
        'macros': '120 kcal | P: 25g | C: 2g | F: 1.5g',
      },
      {
        'id': 303,
        'name': 'Peanut Butter',
        'amount': 15.0,
        'macros': '90 kcal | P: 4g | C: 3g | F: 8g',
      },
    ];

    // Filter local suggestions based on user search inputs
    final filteredSuggestions = mockSuggestions.where((element) {
      final name = element['name'].toString().toLowerCase();
      return name.contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).logIngredient),
        // backgroundColor: pcolor,
        backgroundColor: appBarBackground,
        foregroundColor: appBarForeground,
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Form(
          key: _form,

          child: Column(
            children: [
              // Input field to Search ingredient
              TextFormField(
                key: const Key('ingredient-text-search'),

                decoration: InputDecoration(
                  labelText: 'Search ingredient',
                  suffixIcon: Icon(Icons.search_rounded),
                ),
                onChanged: (value) => setState(() {
                  _searchQuery = value;
                }),
              ),
              SizedBox(height: 8),
              // Weight
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      key: const Key('form-weight'),
                      decoration: InputDecoration(
                        // labelText: 'Weight',
                        labelText:  i18n.weight,
                        suffix: Text(staticUnitLabel),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        final amountVal = double.parse(value);
                        if (amountVal != null) {
                          _localMealItem['amount'] = amountVal;
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      key: Key('date'),
                      decoration: InputDecoration(
                        // label: Text('Date'),
                        label: Text(i18n.date),
                        suffix: Icon(Icons.calendar_month),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),

                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      key: Key('time'),
                      decoration: InputDecoration(
                        // label: Text('Time'),
                        label: Text(i18n.time),
                        suffix: Icon(Icons.calendar_month),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              
              Text(
                i18n.recentIngredients ,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              
              filteredSuggestions.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(i18n.noEntries) ,
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: filteredSuggestions.length,
                        itemBuilder: (context, index) {
                          final historicalItem = filteredSuggestions[index];
                          return Card(
                            child: ListTile(
                              title: Text(historicalItem['name']),
                              subtitle: Text(historicalItem['macros']),
                              trailing: const Wrap(
                                spacing: 12,
                                children: [
                                  Icon(Icons.info_outline),
                                  Icon(Icons.copy),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
