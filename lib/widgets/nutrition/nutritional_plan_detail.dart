
import 'package:flutter/material.dart';
import 'package:realflutter/models/nutrition/nutritional_plan.dart';
import 'package:realflutter/theme/theme.dart';
import 'package:realflutter/widgets/nutrition/widgets.dart';

// ─── NutritionalPlanHeaderCard ────────────────────────────────────────────────

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

  // ── Helpers ─────────────────────────────────────────────────────────────────

  String _planLabel() {
    // BUG FIX: plan.id is a String — used directly, not cast to int.
    return plan.description.isNotEmpty
        ? plan.description
        : 'Nutritional Plan #${plan.id}';
  }

  String _dateRange() {
    // BUG FIX: previously always returned a hardcoded static string.
    // NutritionalPlan.creationDate / endDate are nullable Strings in
    // the current realflutter model.  We read them safely here.
    final start = plan.creationDate ?? '–';
    final end = plan.endDate;
    if (end != null && end.isNotEmpty) {
      return '$start → $end';
    }
    return '$start (open-ended)';
  }

  @override
  Widget build(BuildContext context) {
    // BUG FIX: values were hardcoded to 0.0.
    // NutritionalPlan now carries optional goal fields (see model).
    final goalKcal = plan.goalEnergy ?? 0.0;
    final goalProtein = plan.goalProtein ?? 0.0;
    final goalCarbs = plan.goalCarbohydrates ?? 0.0;
    final goalFat = plan.goalFat ?? 0.0;
    final hasGoals = goalKcal > 0 || goalProtein > 0 || goalCarbs > 0 || goalFat > 0;

    return Card(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Gradient header banner ─────────────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: const BoxDecoration(
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
                        style: RF.text(context)
                            .titleLarge
                            ?.copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _dateRange(),
                        style: RF.text(context).bodySmall?.copyWith(
                              color: Colors.white70,
                              fontStyle: FontStyle.italic,
                            ),
                      ),
                    ],
                  ),
                ),
                // Edit / delete pop-up — mirrors NutritionalPlanScreen.
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

          // ── Macro goals section ────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hasGoals ? 'Daily goals' : 'No goals set',
                  style: RF.text(context).labelMedium?.copyWith(
                        color: RF.primary(context),
                        fontWeight: FontWeight.bold,
                      ),
                ),
                if (hasGoals) ...[
                  const SizedBox(height: 8),
                  NutritionChipRow(
                    kcal: goalKcal,
                    protein: goalProtein,
                    carbs: goalCarbs,
                    fat: goalFat,
                  ),
                ] else ...[
                  const SizedBox(height: 4),
                  Text(
                    'Edit the plan to set daily macro targets.',
                    style: RF.text(context).bodySmall?.copyWith(
                          color: RF.onSurfaceVariant(context),
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}