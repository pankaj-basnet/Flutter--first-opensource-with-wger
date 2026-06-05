import 'package:flutter/material.dart';
import 'package:realflutter/l10n/generated/app_localizations.dart';
import 'package:realflutter/theme/theme.dart';
import 'package:realflutter/widgets/nutrition/meal_component.dart';
import 'package:realflutter/widgets/nutrition/meal_form.dart';
import 'package:realflutter/widgets/nutrition/nutritional_plan_detail.dart';
import 'package:realflutter/widgets/nutrition/plan_form.dart';
import 'package:realflutter/database/powersync/database.dart';
import 'package:realflutter/models/nutrition/ingredient.dart';
import 'package:realflutter/models/nutrition/log.dart';
import 'package:realflutter/models/nutrition/meal_item.dart';
import 'package:realflutter/models/nutrition/nutritional_plan.dart';

Widget getIngredientLogForm(NutritionalPlan plan, DriftPowersyncDatabase db) {
  return IngredientForm(
    plan: plan,
    db: db,
    recent: const [],
    onSave: (BuildContext context, MealItem meal, DateTime? dt) async {
      // Write log entry to Drift database
      await db
          .into(db.logItemTable)
          .insert(
            LogItemTableCompanion.insert(
              planId: plan.id,
              ingredientId: meal.ingredientId,
              amount: meal.amount,
              datetime: dt ?? DateTime.now(),
            ),
          );
      if (context.mounted) {
        final i18n = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(i18n.ingredientLogged, textAlign: TextAlign.center),
          ),
        );
      }
    },
    withDate: true,
  );
}

/// Form to pick an ingredient (and amount) to log to a diary
class IngredientForm extends StatefulWidget {
  final NutritionalPlan plan;
  final DriftPowersyncDatabase db;
  final Function(BuildContext context, MealItem meal, DateTime? dt) onSave;
  final List<LogItem> recent;
  final bool withDate;
  final String barcode;
  final bool test;

  const IngredientForm({
    super.key,
    required this.plan,
    required this.db,
    required this.recent,
    required this.onSave,
    required this.withDate,
    this.barcode = '',
    this.test = false,
  });

  static const List<Map<String, dynamic>> mockSuggestions = [
    {
      'id': 101,
      'name': 'Oats',
      'amount': 50.0,
      'macros': '190 kcal | P: 7g | C: 32g | F: 3g',
    },
    {
      'id': 102,
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

  @override
  State<IngredientForm> createState() => IngredientFormState();
}

class IngredientFormState extends State<IngredientForm> {
  final _formKey = GlobalKey<FormState>();

  final _ingredientController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();

  MealItem get mealItem => _localMealItem;
  String _searchQuery = '';

  late MealItem _localMealItem;
  List<Meal> get _meals =>
      (widget.plan['meals'] as List?)?.cast<Meal>() ?? [];

  @override
  void initState() {
    super.initState();

    _localMealItem = MealItem(id: '', mealId: '', ingredientId: 0, amount: 0.0);

    _synchronizeDateDisplay();
    _synchronizeTimeDisplay();
  }

  @override
  void dispose() {
    _ingredientController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _synchronizeDateDisplay() {
    _dateController.text =
        '${_date.year}-${_date.month.toString().padLeft(2, '0')}-${_date.day.toString().padLeft(2, '0')}';
  }

  void _synchronizeTimeDisplay() {
    _timeController.text =
        '${_time.hour.toString().padLeft(2, '0')}:${_time.minute.toString().padLeft(2, '0')}';
  }

  void updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void selectIngredient(Ingredient ingredient, double? amount) {
    setState(() {
      _localMealItem = MealItem(
        id: '',
        mealId: '',
        ingredientId: ingredient.id,
        amount: amount ?? 0.0,
      );
      _ingredientController.text = ingredient.name;
      if (amount != null) {
        _amountController.text = amount.toStringAsFixed(0);
      }
    });
  }

  void unSelectIngredient() {
    setState(() {
      _localMealItem = MealItem(
        id: '',
        mealId: '',
        ingredientId: 0,
        amount: 0.0,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final i18n = AppLocalizations.of(context);

    final themeText = Theme.of(context).textTheme;
    final titleMediumBoldTheme = themeText.titleMedium?.copyWith(
      fontWeight: FontWeight.bold,
    );

    // Hardcoded layout properties for testing component behavior
    const String staticUnitLabel = 'g';

    // Filter local suggestions based on user search inputs
    // error - The getter '_mockSuggestions' isn't defined for the type 'IngredientForm'.

    final filteredSuggestions = IngredientForm.mockSuggestions.where((element) {
      final name = element['name'].toString().toLowerCase();
      return name.contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(i18n.logIngredient),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  key: const Key('ingredient-text-search'),
                  controller: _ingredientController,
                  decoration: InputDecoration(
                    labelText: 'Search ingredient',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _ingredientController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              _ingredientController.clear();
                              updateSearchQuery('');
                              unSelectIngredient();
                            },
                            icon: const Icon(Icons.clear),
                          )
                        : null,
                  ),
                  onChanged: (value) {
                    updateSearchQuery(value);
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter or select an ingredient';
                    }
                    if (_localMealItem.ingredientId == 0) {
                      return 'Please select an ingredient from the list';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        key: const Key('form-weight'),
                        controller: _amountController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          labelText: i18n.weight,
                          suffixText: staticUnitLabel,
                          border: const OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            final parsedVal = double.tryParse(value);
                            if (parsedVal != null) {
                              _localMealItem = _localMealItem.copyWith(
                                amount: parsedVal,
                              );
                            }
                          });
                        },
                        validator: (value) {
                          final text = value?.trim() ?? '';
                          if (text.isEmpty) {
                            return 'Enter value';
                          }
                          final parsed = double.tryParse(text);
                          if (parsed == null) {
                            return 'Enter valid number';
                          }
                          if (parsed < 1 || parsed > 1000) {
                            return 'Value between 1 and 1000';
                          }
                          return null;
                        },
                      ),
                    ),
                    if (widget.withDate) ...[
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          key: const Key('field-date-fallback'),
                          readOnly: true,
                          controller: _dateController,
                          decoration: InputDecoration(
                            labelText: i18n.date,
                            suffixIcon: const Icon(Icons.calendar_month),
                            border: const OutlineInputBorder(),
                          ),
                          onTap: () async {
                            final selectedDate = await showDatePicker(
                              context: context,
                              initialDate: _date,
                              firstDate: DateTime(DateTime.now().year - 1),
                              lastDate: DateTime.now(),
                            );
                            if (selectedDate != null) {
                              setState(() {
                                _date = selectedDate;
                                _synchronizeDateDisplay();
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          key: const Key('field-time-fallback'),
                          readOnly: true,
                          controller: _timeController,
                          decoration: InputDecoration(
                            labelText: i18n.time,
                            border: const OutlineInputBorder(),
                          ),
                          onTap: () async {
                            final selectedTime = await showTimePicker(
                              context: context,
                              initialTime: _time,
                            );
                            if (selectedTime != null) {
                              setState(() {
                                _time = selectedTime;
                                _synchronizeTimeDisplay();
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ],
                ),
                if (_localMealItem.ingredientId != 0 &&
                    _amountController.text.isNotEmpty)
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      color: Colors.blueGrey.shade50,
                      margin: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Macros preview', style: titleMediumBoldTheme),
                            const SizedBox(height: 6.0),

                            Text(
                              'Target Mass: ${_amountController.text} $staticUnitLabel',
                            ),
                            const Text('Ingredient Detail'),
                          ],
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    key: const Key('submit-ingredient-button'),
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;
                      _formKey.currentState!.save();

                      final ts = DateTime(
                        _date.year,
                        _date.month,
                        _date.day,
                        _time.hour,
                        _time.minute,
                      );
                      try {
                        await widget.onSave(context, _localMealItem, ts);
                        if (mounted) Navigator.of(context).pop();
                      } catch (e) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Save failed: $e')),
                          );
                        }
                      }
                    },
                    child: const Text('Save'),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  i18n.recentlyUsedIngredients,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: filteredSuggestions.isEmpty
                      ? Center(child: Text(i18n.noEntries))
                      : ListView.builder(
                          itemCount: filteredSuggestions.length,
                          itemBuilder: (context, index) {
                            final historicalItem = filteredSuggestions[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 4.0),
                              child: ListTile(
                                title: Text(historicalItem['name'] ?? ''),
                                subtitle: Text(historicalItem['macros'] ?? ''),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.info_outline),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            title: Text(
                                              historicalItem['name'].toString(),
                                            ),
                                            content: Text(
                                              'Static historical data info block for ${historicalItem['name']}',
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(ctx),
                                                child: const Text('Close'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    const Icon(Icons.copy, color: Colors.grey),
                                  ],
                                ),
                                onTap: () {
                                  final ing = Ingredient(
                                    id: historicalItem['id'] as int,
                                    name: historicalItem['name'] as String,
                                    energy: 0,
                                    carbohydrates: 0,
                                    protein: 0,
                                    fat: 0,
                                  );
                                  selectIngredient(
                                    ing,
                                    historicalItem['amount'] as double?,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                ),

                // slivers: [
                //   // ── Plan summary card ──────────────────────────────────────
                //   SliverToBoxAdapter(
                //     child: NutritionalPlanHeaderCard(
                //       plan: plan,
                //       onEdit: () => _navigateToPlanForm(context),
                //     ),
                //   ),

                NutritionalPlanHeaderCard(plan: widget.plan,  onEdit: () => _navigateToPlanForm(context),),

                
          // -- Meals --
          // SliverToBoxAdapter(
            // child:
             Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
              child: Row(
                children: [
                  Text(
                    'Meals',
                    style:
                        Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Add meal'),
                    onPressed: () => _navigateToMealForm(context, null),
                  ),
                ],
              ),
            ),

          if (_meals.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.no_meals,
                          size: 48,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant),
                      const SizedBox(height: 8),
                      Text(
                        'No meals in this plan yet.\nTap "Add meal" to get started.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            SliverList.builder(
              itemCount: _meals.length,
              itemBuilder: (ctx, i) {
                final meal = _meals[i];
                return MealSummarySection(
                  meal: meal,
                  // onAddIngredient: () => _navigateToMealItemForm(ctx, meal),
                  onAddIngredient: () => {},
                  onEditMeal: () => _navigateToMealForm(ctx, meal),
                );
              },
            ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  
  // void _navigateToMealItemForm(BuildContext context, Meal meal) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(builder: (_) => getMealItemForm(meal, const [])),
  //   );
  // }

  void _navigateToPlanForm(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => PlanForm(widget.plan)),
    );
  }

  void _navigateToMealForm(BuildContext context, Meal? meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            MealForm(widget.plan['id'] as int? ?? 0, meal: meal),
      ),
    );
  }
}
