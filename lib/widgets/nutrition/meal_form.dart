import 'package:flutter/material.dart';
import 'package:realflutter/l10n/generated/app_localizations.dart';
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

/// Add or edit a meal (name + optional time).
/// Used by MealSummarySection edit button and the floating "+ meal" action
/// in NutritionalPlanScreen.
class MealForm extends StatefulWidget {
  /// Plan id this meal belongs to.
  final int planId;

  /// Existing meal to edit; null means "create new".
  final Meal? meal;

  const MealForm(this.planId, {super.key, this.meal});

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
      _nameController.text = widget.meal!['name'] as String? ?? '';
      final timeStr = widget.meal!['time'] as String?;
      if (timeStr != null && timeStr.contains(':')) {
        final parts = timeStr.split(':');
        _selectedTime = TimeOfDay(
          hour: int.tryParse(parts[0]) ?? 0,
          minute: int.tryParse(parts[1]) ?? 0,
        );
      }
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
    final i18n = AppLocalizations.of(context);
    final isEdit = widget.meal != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'i18n.edit' : 'i18n.addMeal'),
        backgroundColor: _RF.primary(context),
        foregroundColor: _RF.onPrimary(context),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // - Plan badge --
                PlanBadge(planId: widget.planId),
                const SizedBox(height: 20),

                // - Meal name ---------------------
                TextFormField(
                  key: const Key('meal-name-field'),
                  controller: _nameController,
                  decoration: InputDecoration(
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

                // - Meal time picker --
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
                      labelText: 'i18n.time',
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
                          ? _RF.text(context).bodyMedium
                          : _RF
                                .text(context)
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                    ),
                  ),
                ),

                const Spacer(),

                // -- Submit --
                PrimaryButton(
                  key: const Key('save-meal-button'),
                  label: isEdit ? 'i18n.save' : 'i18n.addMeal',
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;
                    _formKey.currentState!.save();

                    final result = <String, dynamic>{
                      'plan': widget.planId,
                      'name': _nameController.text.trim(),
                      'time': _selectedTime != null
                          ? _formatTime(_selectedTime!)
                          : null,
                    };
                    if (isEdit) result['id'] = widget.meal!['id'];
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

// // -─ getMealItemForm factory -------------------------

// /// Factory matching wger's getMealItemForm signature.
// /// Returns an IngredientForm scoped to the given meal.
// Widget getMealItemForm(
//   Meal meal,
//   List<MealItem> recentMealItems,
// ) {
//   return IngredientForm(
//     plan: meal,
//     recent: recentMealItems,
//     withDate: false,
//     onSave: (
//       BuildContext context,
//       MealItem item,
//       DateTime? dt,
//     ) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Ingredient added to ${meal['name'] ?? 'meal'}',
//             textAlign: TextAlign.center,
//           ),
//         ),
//       );
//       Navigator.of(context).pop(item);
//     },
//   );
// }
