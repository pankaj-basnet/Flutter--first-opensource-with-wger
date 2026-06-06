import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  /// Macro label shown in ListTile subtitle.
  String get macroLabel =>
      '${ingredient.energy} kcal | '
      'P: ${ingredient.protein.toStringAsFixed(0)}g | '
      'C: ${ingredient.carbohydrates.toStringAsFixed(0)}g | '
      'F: ${ingredient.fat.toStringAsFixed(0)}g';
}

// -- Factory function --

Widget getIngredientLogForm(
  NutritionalPlan plan,
  // ignore: avoid_dynamic_calls
  dynamic db,
) {
  return IngredientDetail(plan: plan, db: db);
}

class IngredientDetail extends StatelessWidget {
  final NutritionalPlan plan;
  final dynamic db;

  const IngredientDetail({super.key, required this.plan, this.db});

  // const IngredientDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context);
    final meals = plan.meals;
    return CustomScrollView(
      slivers: [
        // ── Plan header card ─────────────────────────────────────────
        SliverToBoxAdapter(
          child: NutritionalPlanHeaderCard(
            plan: plan,
            // onEdit: () => _navigateToPlanForm(context),
          ),
        ),

        // ── Meals section header ─────────────────────────────────────
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

        // ── Meal cards or empty state ────────────────────────────────
        if (meals.isEmpty)
          const SliverToBoxAdapter(
            child: EmptyStateWidget(
              icon: Icons.no_meals,
              message:
                  'No meals in this plan yet.\nTap "Add meal" to get started.',
            ),
          )
        else
          // BUG FIX: SliverList.builder is valid here because we are inside
          // a CustomScrollView — previously it was inside a Column.
          SliverList.builder(
            itemCount: meals.length,
            itemBuilder: (ctx, i) {
              final meal = meals[i];
              return MealSummarySection(
                meal: meal,
                onAddIngredient: () => _navigateToIngredientForm(ctx),
                onEditMeal: () => _navigateToMealForm(ctx, meal),
              );
            },
          ),

        // ── Quick-log card ───────────────────────────────────────────
        SliverToBoxAdapter(child: SectionHeader(title: 'Log ingredient')),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
            child: _QuickLogCard(
              plan: plan,
              db: db,
              onNavigate: () => _navigateToIngredientForm(context),
            ),
          ),
        ),
      ],
    );
  }

  // ── Navigation helpers ─────────────────────────────────────────────────────

  void _navigateToIngredientForm(BuildContext context) {
    final i18n = AppLocalizations.of(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => IngredientForm(
          plan: plan,
          db: db,
          recent: const [],
          withDate: true,
          onSave: (ctx, item, dt) async {
            // recent: const [],
            // onSave: (BuildContext context, MealItem meal, DateTime? dt) async {
            // Write log entry to Drift database
            await db
                .into(db.logItemTable)
                .insert(
                  LogItemTableCompanion.insert(
                    planId: plan.id,
                    ingredientId: item.ingredientId,
                    amount: item.amount,
                    datetime: dt ?? DateTime.now(),
                  ),
                );
            // if (context.mounted) {

            if (ctx.mounted) {
              ScaffoldMessenger.of(ctx).showSnackBar(
                SnackBar(
                  content: Text(
                    i18n.ingredientLogged,
                    textAlign: TextAlign.center,
                  ),
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
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => MealForm(plan.id, meal: meal)));
  }
}

// ─── _QuickLogCard ────────────────────────────────────────────────────────────

/// Compact card with a single CTA button that opens IngredientForm.
class _QuickLogCard extends StatelessWidget {
  final NutritionalPlan plan;
  final dynamic db;
  final VoidCallback onNavigate;

  const _QuickLogCard({
    required this.plan,
    required this.db,
    required this.onNavigate,
  });

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
              'Log an ingredient directly to today\'s diary.',
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
/// Mirrors wger's IngredientForm (widgets/nutrition/forms.dart in wger repo).
class IngredientForm extends StatefulWidget {
  final NutritionalPlan plan;
  final dynamic db; // DriftPowersyncDatabase

  final Future<void> Function(BuildContext context, MealItem item, DateTime? dt)
  onSave;

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

  /// The MealItem being built. Starts empty; populated by selectIngredient().
  late MealItem _localMealItem;

  /// The Ingredient selected from the suggestion list (for macro preview).
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

  // ── Display sync helpers ───────────────────────────────────────────────────

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

  // ── Ingredient selection ───────────────────────────────────────────────────

  void updateSearchQuery(String query) => setState(() => _searchQuery = query);

  /// Select an Ingredient from the suggestion list and pre-fill the amount.
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

  // ── Filtering ──────────────────────────────────────────────────────────────

  List<_MockEntry> get _filteredEntries {
    if (_searchQuery.isEmpty) return _kMockIngredients;
    final q = _searchQuery.toLowerCase();
    return _kMockIngredients
        .where((e) => e.ingredient.name.toLowerCase().contains(q))
        .toList();
  }

  // ── Macro preview scale ────────────────────────────────────────────────────

  /// Scale factor: (entered amount) / (default serving in mock data).
  double get _macroScale {
    final amount = double.tryParse(_amountController.text) ?? 0;
    if (amount <= 0 || _selectedIngredient == null) return 1.0;
    // Ingredients store macros per 100 g in the real model.
    return amount / 100.0;
  }

  // ── Build ──────────────────────────────────────────────────────────────────

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
                    border: const OutlineInputBorder(),
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
                    // Amount
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
                // BUG FIX: the old card showed 'Ingredient ID: X' which was
                // meaningless to users. Now it shows computed macro values
                // scaled to the entered amount using the real Ingredient model.
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
                // Expanded fills the remaining space so the Column doesn't
                // overflow — same pattern as the original intern code.
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

  // ── Bottom-sheet detail ────────────────────────────────────────────────────

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

/// ListTile for a mock/recent ingredient in the search list.
/// Highlights the selected entry using the primary colour scheme.
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

/// Shows scaled macro values for the currently entered amount.
/// BUG FIX: the old version displayed 'Ingredient ID: X' and 'Ingredient
/// Detail' — meaningless placeholder text. Now uses real Ingredient fields.
class _MacroPreviewCard extends StatelessWidget {
  final Ingredient ingredient;
  final double scale; // entered_amount / 100 g
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
    // Ingredient stores nutrients per 100 g.
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

/// Modal bottom sheet showing full nutrient detail for an Ingredient.
/// Replaces the plain AlertDialog from the 25% submission.
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
          // ── Handle bar ─────────────────────────────────────────────────
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

          // ── Title row ──────────────────────────────────────────────────
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

          // ── Chip row ───────────────────────────────────────────────────
          NutritionChipRow(
            kcal: ingredient.energy.toDouble(),
            protein: ingredient.protein,
            carbs: ingredient.carbohydrates,
            fat: ingredient.fat,
          ),
          const SizedBox(height: 16),

          // ── Detail rows ────────────────────────────────────────────────
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
