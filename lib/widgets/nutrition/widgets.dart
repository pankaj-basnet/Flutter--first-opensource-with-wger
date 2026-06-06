import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realflutter/theme/theme.dart';

// ─── Theme shortcut ──────────────────────────────────────────────────────────
// Centralised here so every widget file can import it via widgets.dart
// instead of duplicating the private _RF class.

class RF {
  RF._();

  static Color primary(BuildContext ctx) => Theme.of(ctx).colorScheme.primary;
  static Color secondary(BuildContext ctx) =>
      Theme.of(ctx).colorScheme.secondary;
  static Color tertiary(BuildContext ctx) => Theme.of(ctx).colorScheme.tertiary;
  static Color surface(BuildContext ctx) => Theme.of(ctx).colorScheme.surface;
  static Color onPrimary(BuildContext ctx) =>
      Theme.of(ctx).colorScheme.onPrimary;
  static Color primaryContainer(BuildContext ctx) =>
      Theme.of(ctx).colorScheme.primaryContainer;
  static Color onSurfaceVariant(BuildContext ctx) =>
      Theme.of(ctx).colorScheme.onSurfaceVariant;
  static TextTheme text(BuildContext ctx) => Theme.of(ctx).textTheme;
}

// ─── NutritionChipRow ────────────────────────────────────────────────────────

/// Compact horizontal row of macro chips: kcal / protein / carbs / fat.
/// Accepts raw doubles so it works with both Ingredient and computed totals.
class NutritionChipRow extends StatelessWidget {
  final double kcal;
  final double protein;
  final double carbs;
  final double fat;

  const NutritionChipRow({
    super.key,
    required this.kcal,
    required this.protein,
    required this.carbs,
    required this.fat,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    Widget chip(String label, String value, Color bg) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: bg.withOpacity(0.4)),
      ),
      child: Text(
        '$value $label',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: bg,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: [
        chip('kcal', kcal.toStringAsFixed(0), primary),
        chip('P', '${protein.toStringAsFixed(1)}g', kTertiaryColor),
        chip('C', '${carbs.toStringAsFixed(1)}g', kSecondaryColor),
        chip('F', '${fat.toStringAsFixed(1)}g', kPrimaryButtonColor),
      ],
    );
  }
}

// ─── PrimaryButton ────────────────────────────────────────────────────────────

/// Full-width elevated button using kPrimaryButtonColor from theme.dart.
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const PrimaryButton({super.key, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryButtonColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: RF
              .text(context)
              .titleSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        child: Text(label),
      ),
    );
  }
}

// ─── PlanBadge ────────────────────────────────────────────────────────────────

/// Small contextual badge showing the plan id.
/// Used inside MealForm so the intern knows which plan the meal belongs to.
class PlanBadge extends StatelessWidget {
  /// The plan id to display. Accepts a String because NutritionalPlan.id
  /// is a String (UUID / server id).
  final String planId;

  const PlanBadge({super.key, required this.planId});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.assignment_outlined, size: 16, color: RF.primary(context)),
        const SizedBox(width: 6),
        Text(
          'Plan #$planId',
          style: RF
              .text(context)
              .labelMedium
              ?.copyWith(
                color: RF.primary(context),
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}

// ─── MacroGoalField ───────────────────────────────────────────────────────────

/// Numeric text field for macro goal inputs (kcal, protein, carbs, fat).
/// Only allows digits + one decimal point.
class MacroGoalField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final Color accentColor;

  const MacroGoalField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      // Allow digits and a single decimal point; max one decimal place.
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,1}')),
      ],
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: accentColor, size: 18),
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
      ),
      validator: (v) {
        if (v != null && v.isNotEmpty && double.tryParse(v) == null) {
          return 'Invalid number';
        }
        return null; // blank == no goal set — that is fine
      },
    );
  }
}

// ─── SectionHeader ────────────────────────────────────────────────────────────

/// Reusable bold section title with an optional trailing action button.
class SectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const SectionHeader({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
      child: Row(
        children: [
          Text(
            title,
            style: RF
                .text(context)
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold, color: kPrimaryColor),
          ),
          const Spacer(),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

// ─── EmptyStateWidget ─────────────────────────────────────────────────────────

/// Centered icon + message shown when a list is empty.
class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String message;

  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: RF.onSurfaceVariant(context)),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: RF.text(context).bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
