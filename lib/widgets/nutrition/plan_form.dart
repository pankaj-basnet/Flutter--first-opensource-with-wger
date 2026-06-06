import 'package:flutter/material.dart';
import 'package:realflutter/database/nutrition_repository.dart';
import 'package:realflutter/l10n/generated/app_localizations.dart';
import 'package:realflutter/models/nutrition/nutritional_plan.dart';
import 'package:realflutter/theme/theme.dart';
import 'package:realflutter/widgets/nutrition/widgets.dart';

// ─── PlanForm ─────────────────────────────────────────────────────────────────

class PlanForm extends StatefulWidget {
  /// The plan being edited. Passed as the domain model, not a raw Map.
  final NutritionalPlan plan;
  final NutritionRepository repo;

  const PlanForm(this.plan, {super.key, required this.repo});

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

    // BUG FIX: use dot notation on the NutritionalPlan model.
    // The old intern code used map-access: `widget.plan['description']`.
    _descController.text = widget.plan.description;

    // BUG FIX: goal fields live on the model (nullable double).
    // Old code: `(widget.plan['goal_energy'] as num?)?.toString() ?? ''`.
    _goalKcalController.text = widget.plan.goalEnergy?.toStringAsFixed(0) ?? '';
    _goalProteinController.text =
        widget.plan.goalProtein?.toStringAsFixed(1) ?? '';
    _goalCarbsController.text =
        widget.plan.goalCarbohydrates?.toStringAsFixed(1) ?? '';
    _goalFatController.text = widget.plan.goalFat?.toStringAsFixed(1) ?? '';
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
    // BUG FIX: i18n must be called, not used as a string prefix.
    final i18n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        // BUG FIX: was `Text('i18n.edit')`.
        title: Text('i18n.edit'),
        backgroundColor: RF.primary(context),
        foregroundColor: RF.onPrimary(context),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Description ────────────────────────────────────────────
                TextFormField(
                  key: const Key('plan-description-field'),
                  controller: _descController,
                  decoration: InputDecoration(
                    // BUG FIX: was `'i18n.description'` (string literal).
                    labelText: i18n.description,
                    prefixIcon: const Icon(Icons.sticky_note_2_outlined),
                    border: const OutlineInputBorder(),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 24),

                // ── Goals section ──────────────────────────────────────────
                Text(
                  'Daily macro goals (optional)',
                  style: RF
                      .text(context)
                      .titleSmall
                      ?.copyWith(
                        color: RF.primary(context),
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Leave blank to track without targets.',
                  style: RF
                      .text(context)
                      .bodySmall
                      ?.copyWith(color: RF.onSurfaceVariant(context)),
                ),
                const SizedBox(height: 12),

                // ── Energy ────────────────────────────────────────────────
                MacroGoalField(
                  key: const Key('goal-energy-field'),
                  controller: _goalKcalController,
                  label: 'Energy (kcal)',
                  icon: Icons.local_fire_department_outlined,
                  accentColor: RF.primary(context),
                ),
                const SizedBox(height: 12),

                // ── Protein / Carbs / Fat ──────────────────────────────────
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

                // ── Save button ────────────────────────────────────────────
                PrimaryButton(
                  key: const Key('save-plan-button'),
                  // BUG FIX: was `'i18n.save'` (string literal).
                  label: i18n.save,

                  // onPressed: () {
                  //   if (!_formKey.currentState!.validate()) return;
                  //   _formKey.currentState!.save();

                  //   // Pop a plain Map back to the caller.
                  //   // The caller persists changes via the DB / notifier
                  //   // in a later milestone.
                  //   final result = <String, dynamic>{
                  //     'id': widget.plan.id,
                  //     'description': _descController.text.trim(),
                  //     'goal_energy':
                  //         double.tryParse(_goalKcalController.text),
                  //     'goal_protein':
                  //         double.tryParse(_goalProteinController.text),
                  //     'goal_carbohydrates':
                  //         double.tryParse(_goalCarbsController.text),
                  //     'goal_fat':
                  //         double.tryParse(_goalFatController.text),
                  //   };
                  //   Navigator.of(context).pop(result);
                  // },
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;
                    _formKey.currentState!.save();

                    final updated = widget.plan.copyWith(
                      description: _descController.text.trim(),
                      goalEnergy: double.tryParse(_goalKcalController.text),
                      goalProtein: double.tryParse(_goalProteinController.text),
                      goalCarbohydrates: double.tryParse(
                        _goalCarbsController.text,
                      ),
                      goalFat: double.tryParse(_goalFatController.text),
                    );

                    await widget.repo.updatePlan(updated);
                    if (mounted) Navigator.of(context).pop();
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
