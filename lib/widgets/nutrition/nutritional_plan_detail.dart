import 'package:flutter/material.dart';
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

// ─── Nutritional Plan header card ────────────────────────────────────────────

/// Mirrors the FlexibleSpaceBar summary from wger's NutritionalPlanScreen.
/// Displays plan description, date range, and goal calories in a themed card.
class NutritionalPlanHeaderCard extends StatelessWidget {
  final NutritionalPlan plan;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const NutritionalPlanHeaderCard({
    super.key,
    required this.plan,
    this.onEdit,
    this.onDelete,
  });

  String _planLabel() {
    final desc = plan['description'] as String? ?? '';
    return desc.isNotEmpty ? desc : 'Nutritional Plan #${plan['id'] ?? '–'}';
  }

  String _dateRange() {
    final start = plan['creation_date'] as String? ?? '–';
    final end = plan['end_date'] as String?;
    if (end != null && end.isNotEmpty) return '$start → $end';
    return '$start (open-ended)';
  }

  @override
  Widget build(BuildContext context) {
    final goalKcal = (plan['goal_energy'] as num?)?.toDouble() ?? 0;
    final goalProtein = (plan['goal_protein'] as num?)?.toDouble() ?? 0;
    final goalCarbs = (plan['goal_carbohydrates'] as num?)?.toDouble() ?? 0;
    final goalFat = (plan['goal_fat'] as num?)?.toDouble() ?? 0;

    return Card(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Header banner ──────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [kPrimaryColor, kPrimaryButtonColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _planLabel(),
                        style: _RF
                            .text(context)
                            .titleLarge
                            ?.copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _dateRange(),
                        style: _RF
                            .text(context)
                            .bodySmall
                            ?.copyWith(
                              color: Colors.white70,
                              fontStyle: FontStyle.italic,
                            ),
                      ),
                    ],
                  ),
                ),
                // Edit / delete pop-up (mirrors NutritionalPlanScreen)
                if (onEdit != null || onDelete != null)
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                    onSelected: (v) {
                      if (v == 'edit') onEdit?.call();
                      if (v == 'delete') onDelete?.call();
                    },
                    itemBuilder: (_) => [
                      if (onEdit != null)
                        const PopupMenuItem(
                          value: 'edit',
                          child: ListTile(
                            leading: Icon(Icons.edit),
                            title: Text('Edit plan'),
                          ),
                        ),
                      if (onDelete != null) ...[
                        const PopupMenuDivider(),
                        const PopupMenuItem(
                          value: 'delete',
                          child: ListTile(
                            leading: Icon(Icons.delete),
                            title: Text('Delete plan'),
                          ),
                        ),
                      ],
                    ],
                  ),
              ],
            ),
          ),
          // ── Macro goals row ────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daily goals',
                  style: _RF
                      .text(context)
                      .labelMedium
                      ?.copyWith(
                        color: _RF.primary(context),
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                NutritionChipRow(
                  kcal: goalKcal,
                  protein: goalProtein,
                  carbs: goalCarbs,
                  fat: goalFat,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
