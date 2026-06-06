import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realflutter/database/nutrition_repository.dart';
import 'package:realflutter/database/powersync/database.dart' hide Meal;
import 'package:realflutter/l10n/generated/app_localizations.dart';
import 'package:realflutter/models/nutrition/ingredient.dart';
import 'package:realflutter/models/nutrition/log.dart';
import 'package:realflutter/models/nutrition/meal.dart';
import 'package:realflutter/models/nutrition/meal_item.dart';
import 'package:realflutter/models/nutrition/nutritional_plan.dart';
import 'package:realflutter/theme/theme.dart';
import 'package:realflutter/widgets/nutrition/meal_component.dart';
import 'package:realflutter/widgets/nutrition/meal_form.dart'
    hide NutritionalPlan;
import 'package:realflutter/widgets/nutrition/nutritional_plan_detail.dart';
import 'package:realflutter/widgets/nutrition/plan_form.dart'
    hide NutritionalPlan;
import 'package:realflutter/widgets/nutrition/widgets.dart';

const _kMockIngredients = [
  _MockEntry(
    ingredient: Ingredient(
      id: 101,
      name: 'Oats',
      energy: 190,
      carbohydrates: 32.0,
      protein: 7.0,
      fat: 3.0,
    ),
    defaultAmount: 50.0,
  ),
  _MockEntry(
    ingredient: Ingredient(
      id: 102,
      name: 'Oats Premium',
      energy: 250,
      carbohydrates: 30.0,
      protein: 10.0,
      fat: 5.0,
    ),
    defaultAmount: 50.0,
  ),
  _MockEntry(
    ingredient: Ingredient(
      id: 202,
      name: 'Whey Protein',
      energy: 120,
      carbohydrates: 2.0,
      protein: 25.0,
      fat: 1.5,
    ),
    defaultAmount: 30.0,
  ),
  _MockEntry(
    ingredient: Ingredient(
      id: 303,
      name: 'Peanut Butter',
      energy: 90,
      carbohydrates: 3.0,
      protein: 4.0,
      fat: 8.0,
    ),
    defaultAmount: 15.0,
  ),
];

/// Value object pairing a mock Ingredient with its default serving size.
class _MockEntry {
  final Ingredient ingredient;
  final double defaultAmount;

  const _MockEntry({required this.ingredient, required this.defaultAmount});

  String get macroLabel =>
      '${ingredient.energy} kcal | '
      'P: ${ingredient.protein.toStringAsFixed(0)}g | '
      'C: ${ingredient.carbohydrates.toStringAsFixed(0)}g | '
      'F: ${ingredient.fat.toStringAsFixed(0)}g';
}

// ── Factory function ──────────────────────────────────────────────────────────

// Widget getIngredientLogForm(NutritionalPlan plan, DriftPowersyncDatabase db) {
//   final repo = NutritionRepository(db);
//   return IngredientLogScreen(planId: plan.id, repo: repo);
// }

Widget getIngredientLogForm(NutritionalPlan plan, dynamic? db) {
  // If db is null, pass a null or mock repository instance down safely
  final repo = db != null ? NutritionRepository(db) : null;
  // Return your root log form widget with the nullable repository reference
  return IngredientLogScreen(planId: plan.id, repo: repo!);
}

// ─── IngredientLogScreen ──────────────────────────────────────────────────────

/// Root screen for the nutrition feature. Streams the plan from Drift via
/// [NutritionRepository.watchPlan] so the UI rebuilds whenever data changes
/// in local SQLite — no Riverpod or other state management required here.
class IngredientLogScreen extends StatelessWidget {
  final String planId;
  final NutritionRepository repo;

  const IngredientLogScreen({
    super.key,
    required this.planId,
    required this.repo,
  });

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context);

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

    return Scaffold(
      appBar: AppBar(
        title: Text(i18n.logIngredient),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_note),
            tooltip: 'Edit plan',
            onPressed: () => _navigateToPlanForm(context),
          ),
        ],
      ),
      // body: StreamBuilder<NutritionalPlan?>(
      //   // watchPlan emits every time Drift detects a local SQLite write —
      //   // works fully offline via PowerSync's SQLite layer.
      //   stream: repo.watchPlan(planId),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(child: CircularProgressIndicator());
      //     }
      //     final plan = snapshot.data;
      //     if (plan == null) {
      //       return const Center(child: Text('Plan not found'));
      //     }
      //     return IngredientDetail(plan: plan, repo: repo);
      body: IngredientDetail(
        plan: NutritionalPlan.fromJson(_mockPlanJson),
        repo: repo,
      ),
    );
  }

  void _navigateToPlanForm(BuildContext context) {
    repo.watchPlan(planId).first.then((plan) {
      if (plan != null && context.mounted) {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => PlanForm(plan, repo: repo)));
      }
    });
  }
}

// ─── IngredientDetail ─────────────────────────────────────────────────────────

class IngredientDetail extends StatelessWidget {
  final NutritionalPlan plan;
  final NutritionRepository repo;

  const IngredientDetail({super.key, required this.plan, required this.repo});

  @override
  Widget build(BuildContext context) {
    final meals = plan.meals;
    return CustomScrollView(
      slivers: [
        // ── Plan header card ─────────────────────────────────────────────
        SliverToBoxAdapter(
          child: NutritionalPlanHeaderCard(
            plan: plan,
            onEdit: () => _navigateToPlanForm(context),
          ),
        ),

        // ── Meals section header ─────────────────────────────────────────
        SliverToBoxAdapter(
          child: SectionHeader(
            title: 'Meals',
            trailing: TextButton.icon(
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Add meal'),
              onPressed: () => _navigateToMealForm(context, null),
            ),
          ),
        ),

        // ── Meal cards or empty state ────────────────────────────────────
        if (meals.isEmpty)
          const SliverToBoxAdapter(
            child: EmptyStateWidget(
              icon: Icons.no_meals,
              message:
                  'No meals in this plan yet.\nTap "Add meal" to get started.',
            ),
          )
        else
          SliverList.builder(
            itemCount: meals.length,
            itemBuilder: (ctx, i) {
              final meal = meals[i];
              return MealSummarySection(
                repo: repo,
                meal: meal,
                onAddIngredient: () => _navigateToIngredientForm(ctx),
                onEditMeal: () => _navigateToMealForm(ctx, meal),
                onDeleteMeal: () async {
                  await repo.deleteMeal(meal.id);
                },
              );
            },
          ),

        // ── Quick-log card ───────────────────────────────────────────────
        SliverToBoxAdapter(child: SectionHeader(title: 'Log ingredient')),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
            child: _QuickLogCard(
              onNavigate: () => _navigateToIngredientForm(context),
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToIngredientForm(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => IngredientForm(
          plan: plan,
          recent: const [],
          withDate: true,
          onSave: (ctx, item, dt) async {
            final log = LogItem(
              id: '',
              planId: plan.id,
              ingredientId: item.ingredientId,
              amount: item.amount,
              datetime: dt ?? DateTime.now(),
            );
            await repo.insertLog(log);
            if (ctx.mounted) {
              ScaffoldMessenger.of(ctx).showSnackBar(
                SnackBar(
                  content: Text(AppLocalizations.of(ctx).ingredientLogged),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(12),
                ),
              );
              Navigator.of(ctx).pop();
            }
          },
        ),
      ),
    );
  }

  void _navigateToMealForm(BuildContext context, Meal? meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MealForm(plan.id, meal: meal, repo: repo),
      ),
    );
  }

  void _navigateToPlanForm(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => PlanForm(plan, repo: repo)));
  }
}

// ─── _QuickLogCard ────────────────────────────────────────────────────────────

/// FIX: removed `plan` and `db` fields — not needed since navigation is
/// handled by the parent IngredientDetail via the onNavigate callback.
class _QuickLogCard extends StatelessWidget {
  final VoidCallback onNavigate;

  const _QuickLogCard({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick log',
              style: RF
                  .text(context)
                  .titleSmall
                  ?.copyWith(color: kPrimaryColor, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              "Log an ingredient directly to today's diary.",
              style: RF.text(context).bodySmall,
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              label: AppLocalizations.of(context).logIngredient,
              onPressed: onNavigate,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── IngredientForm ───────────────────────────────────────────────────────────

/// Full-screen form: search ingredient → set amount → set date/time → save.
///
/// FIX: removed `db` field entirely — saving goes through the `onSave`
/// callback which calls NutritionRepository.insertLog in the parent.
class IngredientForm extends StatefulWidget {
  final NutritionalPlan plan;

  final Future<void> Function(BuildContext context, MealItem item, DateTime? dt)
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
  String _searchQuery = '';

  late MealItem _localMealItem;
  Ingredient? _selectedIngredient;

  @override
  void initState() {
    super.initState();
    _localMealItem = const MealItem(
      id: '',
      mealId: '',
      ingredientId: 0,
      amount: 0.0,
    );
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
        '${_date.year}-'
        '${_date.month.toString().padLeft(2, '0')}-'
        '${_date.day.toString().padLeft(2, '0')}';
  }

  void _synchronizeTimeDisplay() {
    _timeController.text =
        '${_time.hour.toString().padLeft(2, '0')}:'
        '${_time.minute.toString().padLeft(2, '0')}';
  }

  void updateSearchQuery(String query) => setState(() => _searchQuery = query);

  void selectIngredient(Ingredient ingredient, double? amount) {
    setState(() {
      _selectedIngredient = ingredient;
      _localMealItem = MealItem(
        id: '',
        mealId: '',
        ingredientId: ingredient.id,
        amount: amount ?? 100.0,
      );
      _ingredientController.text = ingredient.name;
      if (amount != null) {
        _amountController.text = amount.toStringAsFixed(0);
      }
    });
  }

  void unSelectIngredient() {
    setState(() {
      _selectedIngredient = null;
      _localMealItem = const MealItem(
        id: '',
        mealId: '',
        ingredientId: 0,
        amount: 0.0,
      );
    });
  }

  List<_MockEntry> get _filteredEntries {
    if (_searchQuery.isEmpty) return _kMockIngredients;
    final q = _searchQuery.toLowerCase();
    return _kMockIngredients
        .where((e) => e.ingredient.name.toLowerCase().contains(q))
        .toList();
  }

  double get _macroScale {
    final amount = double.tryParse(_amountController.text) ?? 0;
    if (amount <= 0 || _selectedIngredient == null) return 1.0;
    return amount / 100.0;
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context);
    const staticUnitLabel = 'g';
    final ingredientSelected = _localMealItem.ingredientId != 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(i18n.logIngredient),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Ingredient search field ──────────────────────────────
                TextFormField(
                  key: const Key('ingredient-text-search'),
                  controller: _ingredientController,
                  decoration: InputDecoration(
                    labelText: i18n.searchIngredient,
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHigh.withValues(alpha: 0.4),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1.5,
                      ),
                    ),
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
                  onChanged: updateSearchQuery,
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

                // ── Amount / Date / Time row ─────────────────────────────
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
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'),
                          ),
                        ],
                        decoration: InputDecoration(
                          labelText: i18n.weight,
                          suffixText: staticUnitLabel,
                          border: const OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            final parsed = double.tryParse(value);
                            if (parsed != null) {
                              _localMealItem = _localMealItem.copyWith(
                                amount: parsed,
                              );
                            }
                          });
                        },
                        validator: (value) {
                          final text = value?.trim() ?? '';
                          if (text.isEmpty) return 'Enter value';
                          final parsed = double.tryParse(text);
                          if (parsed == null) return 'Enter valid number';
                          if (parsed < 1 || parsed > 1000) {
                            return 'Value between 1 and 1000';
                          }
                          return null;
                        },
                      ),
                    ),

                    // Date + Time (only when withDate == true)
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
                            final selected = await showDatePicker(
                              context: context,
                              initialDate: _date,
                              firstDate: DateTime(DateTime.now().year - 1),
                              lastDate: DateTime.now(),
                            );
                            if (selected != null) {
                              setState(() {
                                _date = selected;
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
                            final selected = await showTimePicker(
                              context: context,
                              initialTime: _time,
                            );
                            if (selected != null) {
                              setState(() {
                                _time = selected;
                                _synchronizeTimeDisplay();
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ],
                ),

                // ── Macro preview card ───────────────────────────────────
                if (ingredientSelected &&
                    _amountController.text.isNotEmpty &&
                    _selectedIngredient != null)
                  _MacroPreviewCard(
                    ingredient: _selectedIngredient!,
                    scale: _macroScale,
                    amount: _amountController.text,
                    unit: staticUnitLabel,
                  ),

                const SizedBox(height: 15),

                // ── Save button ──────────────────────────────────────────
                PrimaryButton(
                  key: const Key('submit-ingredient-button'),
                  label: i18n.save,
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
                    } catch (e) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Save failed: $e')),
                        );
                      }
                    }
                  },
                ),

                const SizedBox(height: 20),

                // ── Suggestion list header ───────────────────────────────
                Text(
                  i18n.recentlyUsedIngredients,
                  style: RF
                      .text(context)
                      .titleSmall
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                ),
                const SizedBox(height: 10),

                // ── Suggestion list ──────────────────────────────────────
                Expanded(
                  child: _filteredEntries.isEmpty
                      ? Center(child: Text(i18n.noEntries))
                      : ListView.builder(
                          itemCount: _filteredEntries.length,
                          itemBuilder: (context, index) {
                            final entry = _filteredEntries[index];
                            final isSelected =
                                _localMealItem.ingredientId ==
                                entry.ingredient.id;

                            return _IngredientSuggestionTile(
                              entry: entry,
                              isSelected: isSelected,
                              onTap: () => selectIngredient(
                                entry.ingredient,
                                entry.defaultAmount,
                              ),
                              onInfo: () => _showIngredientDetail(
                                context,
                                entry.ingredient,
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

  void _showIngredientDetail(BuildContext context, Ingredient ingredient) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => IngredientDetailSheet(ingredient: ingredient),
    );
  }
}

// ─── _IngredientSuggestionTile ────────────────────────────────────────────────

class _IngredientSuggestionTile extends StatelessWidget {
  final _MockEntry entry;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onInfo;

  const _IngredientSuggestionTile({
    required this.entry,
    required this.isSelected,
    required this.onTap,
    required this.onInfo,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final name = entry.ingredient.name;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      color: isSelected ? scheme.primaryContainer : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: isSelected
            ? BorderSide(color: scheme.primary, width: 1.5)
            : BorderSide.none,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isSelected
              ? scheme.primary
              : scheme.secondaryContainer,
          child: Text(
            name.isNotEmpty ? name[0].toUpperCase() : '?',
            style: TextStyle(
              color: isSelected
                  ? scheme.onPrimary
                  : scheme.onSecondaryContainer,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        title: Text(
          name,
          style: RF
              .text(context)
              .bodyMedium
              ?.copyWith(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
        ),
        subtitle: Text(entry.macroLabel, style: RF.text(context).bodySmall),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected)
              Icon(Icons.check_circle, color: scheme.primary, size: 20),
            IconButton(
              icon: const Icon(Icons.info_outline),
              tooltip: 'Details',
              onPressed: onInfo,
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

// ─── _MacroPreviewCard ────────────────────────────────────────────────────────

class _MacroPreviewCard extends StatelessWidget {
  final Ingredient ingredient;
  final double scale;
  final String amount;
  final String unit;

  const _MacroPreviewCard({
    required this.ingredient,
    required this.scale,
    required this.amount,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    final kcal = ingredient.energy * scale;
    final protein = ingredient.protein * scale;
    final carbs = ingredient.carbohydrates * scale;
    final fat = ingredient.fat * scale;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kPrimaryColorLight.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kPrimaryColorLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Macro preview — $amount $unit of ${ingredient.name}',
            style: RF
                .text(context)
                .titleSmall
                ?.copyWith(color: kPrimaryColor, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          NutritionChipRow(
            kcal: kcal,
            protein: protein,
            carbs: carbs,
            fat: fat,
          ),
        ],
      ),
    );
  }
}

// ─── IngredientDetailSheet ────────────────────────────────────────────────────

class IngredientDetailSheet extends StatelessWidget {
  final Ingredient ingredient;

  const IngredientDetailSheet({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: kPrimaryColor,
                radius: 22,
                child: Text(
                  ingredient.name.isNotEmpty
                      ? ingredient.name[0].toUpperCase()
                      : '?',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ingredient.name,
                      style: RF
                          .text(context)
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Per 100 g',
                      style: RF
                          .text(context)
                          .bodySmall
                          ?.copyWith(color: RF.onSurfaceVariant(context)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          NutritionChipRow(
            kcal: ingredient.energy.toDouble(),
            protein: ingredient.protein,
            carbs: ingredient.carbohydrates,
            fat: ingredient.fat,
          ),
          const SizedBox(height: 16),
          _DetailRow(
            'Energy',
            '${ingredient.energy} kcal',
            Icons.local_fire_department_outlined,
            kPrimaryColor,
          ),
          _DetailRow(
            'Protein',
            '${ingredient.protein.toStringAsFixed(1)} g',
            Icons.fitness_center,
            kTertiaryColor,
          ),
          _DetailRow(
            'Carbohydrates',
            '${ingredient.carbohydrates.toStringAsFixed(1)} g',
            Icons.grain,
            kSecondaryColor,
          ),
          _DetailRow(
            'Fat',
            '${ingredient.fat.toStringAsFixed(1)} g',
            Icons.water_drop_outlined,
            kPrimaryButtonColor,
          ),
          if (ingredient.fiber != null)
            _DetailRow(
              'Fiber',
              '${ingredient.fiber!.toStringAsFixed(1)} g',
              Icons.eco_outlined,
              kTertiaryColor,
            ),
          if (ingredient.sodium != null)
            _DetailRow(
              'Sodium',
              '${ingredient.sodium!.toStringAsFixed(1)} mg',
              Icons.water_outlined,
              kPrimaryColorLight,
            ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _DetailRow(this.label, this.value, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 10),
          Text(label, style: RF.text(context).bodyMedium),
          const Spacer(),
          Text(
            value,
            style: RF
                .text(context)
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w600, color: color),
          ),
        ],
      ),
    );
  }
}
