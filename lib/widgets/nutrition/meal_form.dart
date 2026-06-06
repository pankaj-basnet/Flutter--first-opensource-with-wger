import 'package:flutter/material.dart';
import 'package:realflutter/database/nutrition_repository.dart';
import 'package:realflutter/l10n/generated/app_localizations.dart';
import 'package:realflutter/models/nutrition/meal.dart';
import 'package:realflutter/widgets/nutrition/widgets.dart';

// ─── MealForm ─────────────────────────────────────────────────────────────────

class MealForm extends StatefulWidget {
  /// The id of the NutritionalPlan this meal belongs to.
  final String planId;

  /// Existing [Meal] to edit. Null → create a new meal.
  final Meal? meal;
  final NutritionRepository repo;

  const MealForm(this.planId, {super.key, this.meal, required this.repo});

  @override
  State<MealForm> createState() => _MealFormState();
}

class _MealFormState extends State<MealForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    if (widget.meal != null) {
      _nameController.text = widget.meal!.name;

      // final timeStr = widget.meal!.time;
      // if (timeStr != null && timeStr.contains(':')) {
      //   final parts = timeStr.split(':');
      //   _selectedTime = TimeOfDay(
      //     hour: int.tryParse(parts[0]) ?? 0,
      //     minute: int.tryParse(parts[1]) ?? 0,
      //   );
      // }

      _selectedTime = widget.meal!.time;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  String _formatTime(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    // FIX: i18n is the object; its properties are accessed via dot notation,
    // NOT wrapped in string literals like 'i18n.edit'.
    final i18n = AppLocalizations.of(context);
    final isEdit = widget.meal != null;

    return Scaffold(
      appBar: AppBar(
        // FIX: was Text('i18n.edit') / Text('i18n.addMeal') — literal strings.
        title: Text(isEdit ? 'i18n.edit' : 'i18n.addMeal'),
        backgroundColor: RF.primary(context),
        foregroundColor: RF.onPrimary(context),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Plan context badge ─────────────────────────────────────
                PlanBadge(planId: widget.planId),
                const SizedBox(height: 20),

                // ── Meal name ──────────────────────────────────────────────
                TextFormField(
                  key: const Key('meal-name-field'),
                  controller: _nameController,
                  decoration: InputDecoration(
                    // FIX: was 'i18n.name' — a string literal.
                    labelText: 'i18n.name',
                    prefixIcon: const Icon(Icons.restaurant_menu),
                    border: const OutlineInputBorder(),
                    helperText: 'e.g. Breakfast, Pre-workout snack',
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Please enter a meal name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // ── Meal time picker ───────────────────────────────────────
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: _selectedTime ?? TimeOfDay.now(),
                    );
                    if (picked != null) {
                      setState(() => _selectedTime = picked);
                    }
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      // FIX: was 'i18n.time'.
                      labelText: i18n.time,
                      prefixIcon: const Icon(Icons.access_time),
                      border: const OutlineInputBorder(),
                      suffixIcon: _selectedTime != null
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              tooltip: 'Clear time',
                              onPressed: () =>
                                  setState(() => _selectedTime = null),
                            )
                          : null,
                    ),
                    child: Text(
                      _selectedTime != null
                          ? _formatTime(_selectedTime!)
                          : 'Optional – tap to set',
                      style: _selectedTime != null
                          ? RF.text(context).bodyMedium
                          : RF
                                .text(context)
                                .bodyMedium
                                ?.copyWith(color: RF.onSurfaceVariant(context)),
                    ),
                  ),
                ),

                const Spacer(),

                // ── Save button ────────────────────────────────────────────
                PrimaryButton(
                  key: const Key('save-meal-button'),
                  // FIX: was isEdit ? 'i18n.save' : 'i18n.addMeal' — literals.
                  label: isEdit ? i18n.save : 'i18n.addMeal',
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;
                    _formKey.currentState!.save();

                    final meal = Meal(
                      id: (widget.meal?.id.isNotEmpty == true)
                          ? widget.meal!.id
                          : '',
                      planId: widget.planId,
                      name: _nameController.text.trim(),
                      time: _selectedTime ?? TimeOfDay.now(),
                      // time: _selectedTime != null
                      //     // ? _formatTime(_selectedTime!)
                      //     ? _selectedTime
                      //     : null,
                    );

                    if (widget.meal != null && widget.meal!.id.isNotEmpty) {
                      await widget.repo.updateMeal(meal);
                    } else {
                      await widget.repo.insertMeal(meal);
                    }

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
