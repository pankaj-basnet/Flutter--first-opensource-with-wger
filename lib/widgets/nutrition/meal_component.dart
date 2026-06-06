import 'package:flutter/material.dart';
import 'package:realflutter/database/nutrition_repository.dart';
import 'package:realflutter/models/nutrition/meal.dart';
import 'package:realflutter/models/nutrition/meal_item.dart';
import 'package:realflutter/theme/theme.dart';
import 'package:realflutter/widgets/nutrition/widgets.dart';

// ─── MealSummarySection ───────────────────────────────────────────────────────

/// Expandable card showing a Meal, its MealItems, and edit actions.
/// Mirrors wger's MealWidget (meal.dart) and MealHeader.
class MealSummarySection extends StatefulWidget {
  final Meal meal;
  final NutritionRepository repo;
  final VoidCallback? onAddIngredient;
  final VoidCallback? onEditMeal;
  final VoidCallback? onDeleteMeal;

  const MealSummarySection({
    super.key,
    required this.meal,
    required this.repo,
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

  /// Real MealItem list from the domain model.
  List<MealItem> get _items => widget.meal.mealItems;

  /// TODO (70% step): join MealItem → Ingredient to compute real kcal.
  /// For now display 0 until the DB query layer is wired.
  double get _totalKcal => 0.0;

  @override
  Widget build(BuildContext context) {
    // Meal.name comes from the domain model (never null).
    final mealName = widget.meal.name.isNotEmpty
        ? widget.meal.name
        : 'Unnamed Meal';

    // previous fix (jun-05)
    // Meal.time is nullable TimeOfDay in the wger model.
    // realflutter stores it as a nullable String 'HH:mm'.
    // final mealTimeLabel = widget.meal.time ?? '';

    // jun-06
    final mealTimeLabel = widget.meal.time != null
        ? '${widget.meal.time!.hour.toString().padLeft(2, '0')}:${widget.meal.time!.minute.toString().padLeft(2, '0')}'
        : '';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 3,
      child: Column(
        children: [
          // ── Meal header ─────────────────────────────────────────────────
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 6,
            ),
            leading: CircleAvatar(
              backgroundColor: RF.primaryContainer(context),
              child: Icon(
                Icons.restaurant_menu,
                color: RF.primary(context),
                size: 20,
              ),
            ),
            title: Text(
              mealName,
              style: RF
                  .text(context)
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '${mealTimeLabel.isNotEmpty ? '$mealTimeLabel  ·  ' : ''}'
              '${widget.meal.mealItems.length} item${widget.meal.mealItems.length == 1 ? '' : 's'}',
              style: RF
                  .text(context)
                  .bodySmall
                  ?.copyWith(color: RF.onSurfaceVariant(context)),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Info / collapse — mirrors MealHeader icon logic from wger.
                IconButton(
                  tooltip: 'Toggle details',
                  icon: Icon(
                    _expanded ? Icons.info : Icons.info_outline,
                    color: RF.primary(context),
                  ),
                  onPressed: () => setState(() => _expanded = !_expanded),
                ),
                // Edit toggle — mirrors MealHeader done/edit button.
                IconButton(
                  tooltip: _editing ? 'Done' : 'Edit',
                  icon: Icon(
                    _editing ? Icons.done : Icons.edit,
                    color: RF.secondary(context),
                  ),
                  onPressed: () => setState(() => _editing = !_editing),
                ),
              ],
            ),
          ),

          // ── Edit action row ─────────────────────────────────────────────
          // Mirrors the Wrap of TextButton.icon in wger's MealWidget.
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
                    // onPressed: widget.onDeleteMeal,
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Delete meal?'),
                          content: Text(
                            'This will also remove all items in "${widget.meal.name}".',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.red,
                              ),
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );
                      if (confirm == true) widget.onDeleteMeal?.call();
                    },
                  ),
                ],
              ),
            ),

          // ── Ingredient list (shown when expanded) ───────────────────────
          if (_expanded) ...[
            const Divider(height: 1),
            if (_items.isEmpty)
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  'No ingredients defined',
                  style: RF
                      .text(context)
                      .bodySmall
                      ?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: RF.onSurfaceVariant(context),
                      ),
                ),
              )
            else
              ..._items.map((item) => _MealItemRow(item: item)),
            const Divider(height: 1),

            // Total row — mirrors NutritionTile 'total' from wger.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Text(
                    'Total',
                    style: RF
                        .text(context)
                        .labelMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  // TODO (70% step): replace zeroes with real nutrient sums
                  // once Ingredient is joined to each MealItem from the DB.
                  NutritionChipRow(
                    kcal: _totalKcal,
                    protein: 0.0,
                    carbs: 0.0,
                    fat: 0.0,
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

// ─── _MealItemRow ─────────────────────────────────────────────────────────────

/// Single ingredient row inside the expanded meal card.
///
/// MealItem only carries (id, mealId, ingredientId, weightUnitId, amount,
/// order) — it does NOT carry nutrient values. Nutrient data lives on
/// Ingredient and will be resolved in the 70% (Async Typeahead + DB) step.
///
/// For now we display amount + ingredientId as a placeholder.
class _MealItemRow extends StatelessWidget {
  final MealItem item;

  const _MealItemRow({required this.item});

  @override
  Widget build(BuildContext context) {
    // amount is a double on the domain model — not a Map entry.
    final amount = item.amount.toStringAsFixed(0);

    // BUG FIX: the previous intern version used `item['protein']` which
    // is a map-access on a typed class — that does not compile.
    // TODO (70%): resolve ingredient name via DB: watch(ingredientProvider(item.ingredientId))
    final displayName = 'Ingredient #${item.ingredientId}';

    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      leading: CircleAvatar(
        radius: 16,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        child: Text(
          // Safe: displayName always starts with 'I'.
          displayName[0].toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        ),
      ),
      title: Text(
        '$amount g  ·  $displayName',
        style: RF.text(context).bodyMedium,
        overflow: TextOverflow.ellipsis,
      ),
      // BUG FIX: trailing previously contained `$kcal` which was an
      // undefined variable.  Replaced with a placeholder until nutrient
      // data is joined from Ingredient in the 70% step.
      trailing: Text(
        '– kcal',
        style: RF
            .text(context)
            .labelSmall
            ?.copyWith(color: RF.primary(context), fontWeight: FontWeight.w600),
      ),
    );
  }
}
