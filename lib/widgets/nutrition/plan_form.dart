import 'package:flutter/material.dart';
import 'package:realflutter/l10n/generated/app_localizations.dart';
import 'package:realflutter/theme/theme.dart';
import 'package:realflutter/widgets/nutrition/widgets.dart';

// -- Primitive type aliases --
typedef NutritionalPlan = Map<String, dynamic>;
typedef MealItem = Map<String, dynamic>;
typedef LogItem = Map<String, dynamic>;
typedef Meal = Map<String, dynamic>;

// -- Theme helpers --
class _RF {
  static Color primary(BuildContext ctx) => Theme.of(ctx).colorScheme.primary;
  static Color secondary(BuildContext ctx) =>
      Theme.of(ctx).colorScheme.secondary;
  static Color tertiary(BuildContext ctx) => Theme.of(ctx).colorScheme.tertiary;
  static Color surface(BuildContext ctx) => Theme.of(ctx).colorScheme.surface;
  static Color onPrimary(BuildContext ctx) =>
      Theme.of(ctx).colorScheme.onPrimary;
  static Color primaryContainer(BuildContext ctx) =>
      Theme.of(ctx).colorScheme.primaryContainer;
  static TextTheme text(BuildContext ctx) => Theme.of(ctx).textTheme;
}

class PlanForm extends StatefulWidget {
  final NutritionalPlan plan;

  const PlanForm(this.plan, {super.key});

  @override
  State<PlanForm> createState() => _PlanFormState();
}

class _PlanFormState extends State<PlanForm> {
  final _formKey = GlobalKey<FormState>();
  final _descController = TextEditingController();
  final _goalKcalController = TextEditingController();
  final _goalProteinController = TextEditingController();
  final _goalCarbsController = TextEditingController();
  final _goalFatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _descController.text = widget.plan['description'] as String? ?? '';
    _goalKcalController.text =
        (widget.plan['goal_energy'] as num?)?.toString() ?? '';
    _goalProteinController.text =
        (widget.plan['goal_protein'] as num?)?.toString() ?? '';
    _goalCarbsController.text =
        (widget.plan['goal_carbohydrates'] as num?)?.toString() ?? '';
    _goalFatController.text =
        (widget.plan['goal_fat'] as num?)?.toString() ?? '';
  }

  @override
  void dispose() {
    _descController.dispose();
    _goalKcalController.dispose();
    _goalProteinController.dispose();
    _goalCarbsController.dispose();
    _goalFatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('i18n.edit'),
        backgroundColor: _RF.primary(context),
        foregroundColor: _RF.onPrimary(context),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Description ────────────────────────────────────────
                TextFormField(
                  key: const Key('plan-description-field'),
                  controller: _descController,
                  decoration: InputDecoration(
                    labelText: 'i18n.description',
                    prefixIcon: const Icon(Icons.sticky_note_2_outlined),
                    border: const OutlineInputBorder(),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 24),

                // ── Goals section header ───────────────────────────────
                Text(
                  'Daily macro goals (optional)',
                  style: _RF
                      .text(context)
                      .titleSmall
                      ?.copyWith(
                        color: _RF.primary(context),
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Leave blank to track without targets.',
                  style: _RF
                      .text(context)
                      .bodySmall
                      ?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 12),

                // ── kcal goal ──────────────────────────────────────────
                MacroGoalField(
                  key: const Key('goal-energy-field'),
                  controller: _goalKcalController,
                  label: 'Energy (kcal)',
                  icon: Icons.local_fire_department_outlined,
                  accentColor: _RF.primary(context),
                ),
                const SizedBox(height: 12),

                // ── Protein / carbs / fat in a row ─────────────────────
                Row(
                  children: [
                    Expanded(
                      child: MacroGoalField(
                        key: const Key('goal-protein-field'),
                        controller: _goalProteinController,
                        label: 'Protein (g)',
                        icon: Icons.fitness_center,
                        accentColor: kTertiaryColor,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MacroGoalField(
                        key: const Key('goal-carbs-field'),
                        controller: _goalCarbsController,
                        label: 'Carbs (g)',
                        icon: Icons.grain,
                        accentColor: kSecondaryColor,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MacroGoalField(
                        key: const Key('goal-fat-field'),
                        controller: _goalFatController,
                        label: 'Fat (g)',
                        icon: Icons.water_drop_outlined,
                        accentColor: kPrimaryButtonColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // ── Submit ─────────────────────────────────────────────
                PrimaryButton(
                  key: const Key('save-plan-button'),
                  label: 'i18n.save',
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;
                    _formKey.currentState!.save();
                    final result = Map<String, dynamic>.from(widget.plan);
                    result['description'] = _descController.text.trim();
                    result['goal_energy'] = double.tryParse(
                      _goalKcalController.text,
                    );
                    result['goal_protein'] = double.tryParse(
                      _goalProteinController.text,
                    );
                    result['goal_carbohydrates'] = double.tryParse(
                      _goalCarbsController.text,
                    );
                    result['goal_fat'] = double.tryParse(
                      _goalFatController.text,
                    );
                    Navigator.of(context).pop(result);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
