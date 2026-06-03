import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Import domain models
import 'package:realflutter/l10n/generated/app_localizations.dart';
import 'package:realflutter/models/nutrition/ingredient.dart';
import 'package:realflutter/models/nutrition/log.dart';
import 'package:realflutter/models/nutrition/meal_item.dart';
import 'package:realflutter/models/nutrition/nutritional_plan.dart';

// Assuming an exported AppDatabase instance for Drift/PowerSync
import 'package:realflutter/database/powersync/database.dart';

/// Centralized bounds for form validation
class FormValidationBounds {
  static const double minWeight = 1.0;
  static const double maxWeight = 10000.0;
}

/// Factory function to return the configured Ingredient Form.
/// Removed Riverpod; now relies on direct AppDatabase injection/usage for offline persistence.
Widget getIngredientLogForm(NutritionalPlan plan, DriftPowersyncDatabase db) {
  return IngredientForm(
    plan: plan,
    recentLogs: plan.dedupDiaryEntries,
    onSave: (BuildContext context, MealItem mealItem, DateTime dt) async {
      // Create the offline-first domain model
      final logItem = LogItem.fromMealItem(mealItem, plan.id ?? '', null, dt);

      // Persist to local SQLite via Drift Companion.
      // PowerSync will handle the upstream sync to Django automatically.
      await db.into(db.logItemTable).insert(logItem.toCompanion());

      // Provide user feedback
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

class IngredientForm extends StatefulWidget {
  final NutritionalPlan plan;
  final List<LogItem> recentLogs;
  final bool withDate;
  final Future<void> Function(BuildContext context, MealItem meal, DateTime dt)
  onSave;

  const IngredientForm({
    super.key,
    required this.plan,
    required this.recentLogs,
    required this.onSave,
    required this.withDate,
  });

  @override
  State<IngredientForm> createState() => _IngredientFormState();
}

class _IngredientFormState extends State<IngredientForm> {
  final _formKey = GlobalKey<FormState>();

  // Explicitly instantiating controllers strictly inside the State lifecycle
  final _ingredientController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  late MealItem _localMealItem;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Initialize the domain model explicitly using the factory
    _localMealItem = MealItem.empty();

    // Post-frame callback ensures context is available for localized date/time fetching
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _synchronizeLocalizedDateDisplay();
        _synchronizeLocalizedTimeDisplay();
      }
    });
  }

  @override
  void dispose() {
    // Critical: Prevent memory leaks by disposing native resources
    _ingredientController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _synchronizeLocalizedDateDisplay() {
    final localeStr = Localizations.localeOf(context).toString();
    _dateController.text = DateFormat.yMd(localeStr).format(_selectedDate);
  }

  void _synchronizeLocalizedTimeDisplay() {
    final materializedLocalizations = MaterialLocalizations.of(context);
    _timeController.text = materializedLocalizations.formatTimeOfDay(
      _selectedTime,
      alwaysUse24HourFormat: false,
    );
  }

  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _selectIngredient(Ingredient ingredient, double? amount) {
    setState(() {
      // Use the proper model's copyWith method to maintain immutability principles
      _localMealItem = _localMealItem.copyWith(
        ingredientId: ingredient.id,
        ingredient: ingredient, // Attach the full object for macro calculations
        amount: amount ?? _localMealItem.amount,
      );

      _ingredientController.text = ingredient.name;

      if (amount != null) {
        final numberFormat = NumberFormat.decimalPattern(
          Localizations.localeOf(context).toString(),
        );
        _amountController.text = numberFormat.format(amount);
      }
    });
  }

  void _unselectIngredient() {
    setState(() {
      _localMealItem = _localMealItem.copyWith(
        ingredientId: 0,
        ingredient: null,
      );
      _ingredientController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final i18n = AppLocalizations.of(context);
    final numberFormat = NumberFormat.decimalPattern(
      Localizations.localeOf(context).toString(),
    );

    // Filter against the recent logs provided by the NutritionalPlan domain object
    final filteredLogs = widget.recentLogs.where((log) {
      final name = log.ingredient?.name.toLowerCase() ?? '';
      return name.contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(i18n.logIngredient ?? 'Log Ingredient'),
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
                // --- Search Input ---
                TextFormField(
                  key: const Key('ingredient-text-search'),
                  controller: _ingredientController,
                  decoration: InputDecoration(
                    labelText: i18n.searchIngredient ?? 'Search ingredient',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _ingredientController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              _updateSearchQuery('');
                              _unselectIngredient();
                            },
                            icon: const Icon(Icons.clear),
                          )
                        : null,
                  ),
                  onChanged: _updateSearchQuery,
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty ||
                        _localMealItem.ingredientId == 0) {
                      return i18n.enterOrSelectIngredient ??
                          'Please select an ingredient';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                // --- Amounts and Dates Row ---
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
                          labelText: i18n.weight ?? 'Weight',
                          suffixText: i18n.g ?? 'g',
                          border: const OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          final parsedVal = numberFormat.tryParse(value);
                          if (parsedVal != null) {
                            setState(() {
                              _localMealItem = _localMealItem.copyWith(
                                amount: parsedVal.toDouble(),
                              );
                            });
                          }
                        },
                        validator: (value) {
                          final text = value?.trim() ?? '';
                          if (text.isEmpty)
                            return i18n.enterValue ?? 'Enter value';

                          final parsed = numberFormat.tryParse(text);
                          if (parsed == null)
                            return i18n.enterValidNumber ?? 'Invalid number';

                          if (parsed < FormValidationBounds.minWeight ||
                              parsed > FormValidationBounds.maxWeight) {
                            return i18n.formMinMaxValues(
                              FormValidationBounds.minWeight,
                              FormValidationBounds.maxWeight,
                            );
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
                            labelText: i18n.date ?? 'Date',
                            suffixIcon: const Icon(Icons.calendar_month),
                            border: const OutlineInputBorder(),
                          ),
                          onTap: () async {
                            final now = DateTime.now();
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: _selectedDate,
                              firstDate: DateTime(now.year - 5),
                              lastDate: now,
                            );
                            if (pickedDate != null) {
                              setState(() {
                                _selectedDate = pickedDate;
                                _synchronizeLocalizedDateDisplay();
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
                            labelText: i18n.time ?? 'Time',
                            border: const OutlineInputBorder(),
                          ),
                          onTap: () async {
                            final pickedTime = await showTimePicker(
                              context: context,
                              initialTime: _selectedTime,
                            );
                            if (pickedTime != null) {
                              setState(() {
                                _selectedTime = pickedTime;
                                _synchronizeLocalizedTimeDisplay();
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ],
                ),

                // --- Live Macro Calculations ---
                if (_localMealItem.ingredient != null &&
                    _amountController.text.isNotEmpty)
                  Card(
                    color: theme.colorScheme.surfaceContainerHighest
                        .withOpacity(0.4),
                    margin: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            i18n.macrosPreview ?? 'Macros preview',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6.0),
                          Text(
                            '${i18n.description ?? 'Item'}: ${_localMealItem.ingredient!.name}',
                          ),
                          // Delegating the math to the NutritionalValues domain class!
                          Text(
                            'Calculated Calories: ${_localMealItem.nutritionalValues.energy.toStringAsFixed(1)} kcal',
                          ),
                          Text(
                            'Calculated Protein: ${_localMealItem.nutritionalValues.protein.toStringAsFixed(1)} g',
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 15),

                // --- Submission ---
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    key: const Key('submit-ingredient-button'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                    ),
                    onPressed: () async {
                      if (widget.plan.id == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Plan has not been saved yet.'),
                          ),
                        );
                        return;
                      }
                      
                      if (!_formKey.currentState!.validate()) return;

                      _formKey.currentState!.save();

                      final finalizedTimestamp = DateTime(
                        _selectedDate.year,
                        _selectedDate.month,
                        _selectedDate.day,
                        _selectedTime.hour,
                        _selectedTime.minute,
                      );

                      // Await the asynchronous database insertion
                      await widget.onSave(
                        context,
                        _localMealItem,
                        finalizedTimestamp,
                      );

                      if (mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(i18n.save ?? 'Save'),
                  ),
                ),

                const SizedBox(height: 20),

                // --- History List ---
                Text(
                  i18n.recentlyUsedIngredients ?? 'Recently Used',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: filteredLogs.isEmpty
                      ? Center(
                          child: Text(i18n.noEntries ?? 'No entries found'),
                        )
                      : ListView.builder(
                          itemCount: filteredLogs.length,
                          itemBuilder: (context, index) {
                            final logItem = filteredLogs[index];
                            final ingredient = logItem.ingredient;
                            if (ingredient == null)
                              return const SizedBox.shrink(); // Await hydration

                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 4.0),
                              child: ListTile(
                                title: Text(ingredient.name),
                                // Utilizing domain model values directly
                                subtitle: Text(
                                  '${logItem.amount}g • ${logItem.nutritionalValues.energy.toStringAsFixed(0)} kcal',
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.info_outline),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: Text(ingredient.name),
                                        content: Text(
                                          'ID: ${ingredient.id}\nBase Energy: ${ingredient.energy} kJ/100g',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(ctx),
                                            child: Text(i18n.close ?? 'Close'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                onTap: () => _selectIngredient(
                                  ingredient,
                                  logItem.amount.toDouble(),
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
      ),
    );
  }
}
