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
import 'package:realflutter/widgets/nutrition/meal_form.dart' hide NutritionalPlan;
import 'package:realflutter/widgets/nutrition/nutritional_plan_detail.dart';
import 'package:realflutter/widgets/nutrition/plan_form.dart' hide NutritionalPlan;
import 'package:realflutter/widgets/nutrition/widgets.dart';

const _kMockIngredients = [
  _MockEntry(
    ingredient: Ingredient(id: 101, name: 'Oats', energy: 190, carbohydrates: 32.0, protein: 7.0, fat: 3.0),
    defaultAmount: 50.0,
  ),
  _MockEntry(
    ingredient: Ingredient(id: 102, name: 'Oats Premium', energy: 250, carbohydrates: 30.0, protein: 10.0, fat: 5.0),
    defaultAmount: 50.0,
  ),
  _MockEntry(
    ingredient: Ingredient(id: 202, name: 'Whey Protein', energy: 120, carbohydrates: 2.0, protein: 25.0, fat: 1.5),
    defaultAmount: 30.0,
  ),
];

class _MockEntry {
  final Ingredient ingredient;
  final double defaultAmount;
  const _MockEntry({required this.ingredient, required this.defaultAmount});
  String get macroLabel => '${ingredient.energy} kcal | P: ${ingredient.protein.toStringAsFixed(0)}g | C: ${ingredient.carbohydrates.toStringAsFixed(0)}g | F: ${ingredient.fat.toStringAsFixed(0)}g';
}

Widget getIngredientLogForm(String planID, dynamic? db) {
  final repo = db != null ? NutritionRepository(db) : null;
  return IngredientLogScreen(planId: planID, repo: repo!);
}

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
      body: StreamBuilder<NutritionalPlan?>(
        stream: repo.watchPlan(planId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final plan = snapshot.data;
          if (plan == null) {
            return const Center(child: Text('Plan not found. Seeding error or ID mismatch.'));
          }
          return IngredientDetail(plan: plan, repo: repo);
        }
      ),
    );
  }

  void _navigateToPlanForm(BuildContext context) {
    repo.watchPlan(planId).first.then((plan) {
      if (plan != null && context.mounted) {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => PlanForm(plan, repo: repo)));
      }
    });
  }
}

class IngredientDetail extends StatelessWidget {
  final NutritionalPlan plan;
  final NutritionRepository repo;

  const IngredientDetail({super.key, required this.plan, required this.repo});

  @override
  Widget build(BuildContext context) {
    final meals = plan.meals;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: NutritionalPlanHeaderCard(
            plan: plan,
            onEdit: () => _navigateToPlanForm(context),
          ),
        ),
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
        if (meals.isEmpty)
          const SliverToBoxAdapter(
            child: EmptyStateWidget(
              icon: Icons.no_meals,
              message: 'No meals in this plan yet.\nTap "Add meal" to get started.',
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
                onAddIngredient: () => _navigateToAddMealItem(ctx, meal),
                onEditMeal: () => _navigateToMealForm(ctx, meal),
                onDeleteMeal: () async {
                  await repo.deleteMeal(meal.id);
                },
              );
            },
          ),
        SliverToBoxAdapter(child: SectionHeader(title: 'Log ingredient')),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
            child: _QuickLogCard(onNavigate: () => _navigateToIngredientForm(context)),
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
                SnackBar(content: Text(AppLocalizations.of(ctx).ingredientLogged)),
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
      MaterialPageRoute(builder: (_) => MealForm(planId: plan.id, meal: meal, repo: repo)),
    );
  }

  void _navigateToPlanForm(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => PlanForm(plan, repo: repo)));
  }

  void _navigateToAddMealItem(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => IngredientForm(
          plan: plan,
          recent: const [],
          withDate: false,
          onSave: (ctx, item, dt) async {
            final mealItemToSave = item.copyWith(
              id: '', 
              mealId: meal.id,
            );
            await repo.insertMealItem(mealItemToSave);
            if (ctx.mounted) {
              Navigator.of(ctx).pop();
            }
          },
        ),
      ),
    );
  }
}

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
            Text('Quick log', style: RF.text(context).titleSmall?.copyWith(color: kPrimaryColor, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text("Log an ingredient directly to today's diary.", style: RF.text(context).bodySmall),
            const SizedBox(height: 12),
            PrimaryButton(label: AppLocalizations.of(context).logIngredient, onPressed: onNavigate),
          ],
        ),
      ),
    );
  }
}

class IngredientForm extends StatefulWidget {
  final NutritionalPlan plan;
  final Future<void> Function(BuildContext context, MealItem item, DateTime? dt) onSave;
  final List<LogItem> recent;
  final bool withDate;

  const IngredientForm({
    super.key,
    required this.plan,
    required this.recent,
    required this.onSave,
    required this.withDate,
  });

  @override
  State<IngredientForm> createState() => IngredientFormState();
}

class IngredientFormState extends State<IngredientForm> {
  final _formKey = GlobalKey<FormState>();
  final _ingredientController = TextEditingController();
  final _amountController = TextEditingController();
  late MealItem _localMealItem;
  Ingredient? _selectedIngredient;

  @override
  void initState() {
    super.initState();
    _localMealItem = const MealItem(id: '', mealId: '', ingredientId: 0, amount: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Ingredient')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _ingredientController,
                  decoration: const InputDecoration(labelText: 'Search (e.g. Oats)'),
                  validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                  onChanged: (val) {
                    final match = _kMockIngredients.where((m) => m.ingredient.name.toLowerCase().contains(val.toLowerCase())).firstOrNull;
                    if (match != null) {
                      setState(() {
                        _selectedIngredient = match.ingredient;
                        _localMealItem = _localMealItem.copyWith(ingredientId: match.ingredient.id);
                      });
                    }
                  },
                ),
                TextFormField(
                  controller: _amountController,
                  decoration: const InputDecoration(labelText: 'Amount (g)'),
                  onChanged: (val) {
                    _localMealItem = _localMealItem.copyWith(amount: double.tryParse(val) ?? 0);
                  },
                ),
                const SizedBox(height: 20),
                PrimaryButton(
                  label: 'Save',
                  onPressed: () async {
                    if (_formKey.currentState!.validate() && _localMealItem.ingredientId != 0) {
                      await widget.onSave(context, _localMealItem, DateTime.now());
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}