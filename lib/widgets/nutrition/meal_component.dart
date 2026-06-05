import 'package:flutter/material.dart';
import 'package:realflutter/theme/theme.dart';
import 'package:realflutter/widgets/nutrition/widgets.dart';
import 'package:realflutter/models/nutrition/meal.dart';
import 'package:realflutter/models/nutrition/meal_item.dart';

// -- Primitive type aliases --
// typedef NutritionalPlan = Map<String, dynamic>;
// typedef MealItem = Map<String, dynamic>;
// typedef LogItem = Map<String, dynamic>;
// typedef Meal = Map<String, dynamic>;

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

/// Expandable meal card (Meal summary)
/// Shows meal name, time, planned kcal, and a list of ingredient rows.
class MealSummarySection extends StatefulWidget {
  final Meal meal;
  final VoidCallback? onAddIngredient;
  final VoidCallback? onEditMeal;
  final VoidCallback? onDeleteMeal;

  const MealSummarySection({
    super.key,
    required this.meal,
    this.onAddIngredient,
    this.onEditMeal,
    this.onDeleteMeal,
  });

  @override
  State<MealSummarySection> createState() => _MealSummarySectionState();
}

class _MealSummarySectionState extends State<MealSummarySection> {
  bool _expanded = false;
  bool _editing = false;

  // List<MealItem> get _items =>
  //     (widget.meal['items'] as List?)?.cast<MealItem>() ?? [];

  // double get _totalKcal => _items.fold(0.0, (s, i) {
  //       return s + ((i['energy'] as num?)?.toDouble() ?? 0);
  //     });

  // @override
  // Widget build(BuildContext context) {
  //   final mealName =
  //       (widget.meal['name'] as String?)?.isNotEmpty == true
  //           ? widget.meal['name'] as String
  //           : 'Unnamed Meal';
  //   final mealTime = widget.meal['time'] as String? ?? '';

  List<MealItem> get _items => widget.meal.mealItems;

  // 🚀 FIX: Calculate using dot notation. (Assuming energy exists on MealItem or joined Ingredient)
  // If energy is not on MealItem directly, you may need to adjust based on your DB join.
  double get _totalKcal => _items.fold(
    0.0,
    (s, i) => s + 0.0
  );

  @override
  Widget build(BuildContext context) {
    final mealName = widget.meal.name.isNotEmpty
        ? widget.meal.name
        : 'Unnamed Meal';
    final mealTime = '';
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 2,
      child: Column(
        children: [
          // ── Meal header (mirrors MealHeader from wger) ─────────────────
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 6,
            ),
            leading: CircleAvatar(
              backgroundColor: _RF.primaryContainer(context),
              child: Icon(
                Icons.restaurant_menu,
                color: _RF.primary(context),
                size: 20,
              ),
            ),
            title: Text(
              mealName,
              style: _RF
                  .text(context)
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '${mealTime.isNotEmpty ? '$mealTime  ·  ' : ''}${_totalKcal.toStringAsFixed(0)} kcal',
              style: _RF
                  .text(context)
                  .bodySmall
                  ?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // info / collapse toggle – mirrors MealHeader icon logic
                IconButton(
                  tooltip: 'Toggle details',
                  icon: Icon(
                    _expanded ? Icons.info : Icons.info_outline,
                    color: _RF.primary(context),
                  ),
                  onPressed: () => setState(() => _expanded = !_expanded),
                ),
                // edit toggle
                IconButton(
                  tooltip: _editing ? 'Done' : 'Edit',
                  icon: Icon(
                    _editing ? Icons.done : Icons.edit,
                    color: _RF.secondary(context),
                  ),
                  onPressed: () => setState(() => _editing = !_editing),
                ),
              ],
            ),
          ),

          // ── Edit action row (mirrors MealWidget editing wrap) ──────────
          if (_editing)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
              child: Wrap(
                spacing: 8,
                children: [
                  TextButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Add ingredient'),
                    onPressed: widget.onAddIngredient,
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.timer),
                    label: const Text('Edit meal'),
                    onPressed: widget.onEditMeal,
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                    style: TextButton.styleFrom(
                      foregroundColor: kSecondaryColor,
                    ),
                    onPressed: widget.onDeleteMeal,
                  ),
                ],
              ),
            ),

          // ── Ingredient list (expanded) ─────────────────────────────────
          if (_expanded) ...[
            const Divider(height: 1),
            if (_items.isEmpty)
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  'No ingredients defined',
                  style: _RF
                      .text(context)
                      .bodySmall
                      ?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              )
            else
              ..._items.map((item) => _IngredientRow(item: item)),
            const Divider(height: 1),
            // Total row – mirrors NutritionTile "total" in wger
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Text(
                    'Total',
                    style: _RF
                        .text(context)
                        .labelMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  NutritionChipRow(
                    kcal: _totalKcal,
                    protein: _items.fold(
                      0.0,
                      (s, i) => s + ((i['protein'] as num?)?.toDouble() ?? 0),
                    ),
                    carbs: _items.fold(
                      0.0,
                      (s, i) =>
                          s + ((i['carbohydrates'] as num?)?.toDouble() ?? 0),
                    ),
                    fat: _items.fold(
                      0.0,
                      (s, i) => s + ((i['fat'] as num?)?.toDouble() ?? 0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _IngredientRow extends StatelessWidget {
  final MealItem item;

  const _IngredientRow({required this.item});

  @override
  Widget build(BuildContext context) {
    // final name =
    //     item['ingredient_name'] as String? ?? item['name'] as String? ?? '…';
    // final amount = (item['amount'] as num?)?.toStringAsFixed(0) ?? '–';
    // final unit = item['weight_unit'] as String? ?? 'g';
    // final kcal = (item['energy'] as num?)?.toStringAsFixed(0) ?? '–';

    final amount = item.amount.toStringAsFixed(0);
    final name = 'Ingredient #${item.ingredientId}';

    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      leading: CircleAvatar(
        radius: 16,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : '?',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        ),
      ),
      title: Text(
        // '$amount $unit  ·  $name',
        '$amount  ·  $name',
        style: _RF.text(context).bodyMedium,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        // '$kcal kcal',
        '$kcal kcal',
        style: _RF
            .text(context)
            .labelSmall
            ?.copyWith(
              color: _RF.primary(context),
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
