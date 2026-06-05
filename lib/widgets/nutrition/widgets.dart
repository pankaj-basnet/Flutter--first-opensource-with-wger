import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realflutter/theme/theme.dart';


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


// -- Shared widgets --

/// Full-width primary button using rfLightTheme colours.
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
          textStyle: _RF.text(context).titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        child: Text(label),
      ),
    );
  }
}

/// Small badge showing plan id – used inside MealForm for context.
class PlanBadge extends StatelessWidget {
  final int planId;

  const PlanBadge({required this.planId});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.assignment_outlined,
            size: 16, color: _RF.primary(context)),
        const SizedBox(width: 6),
        Text(
          'Plan #$planId',
          style: _RF.text(context).labelMedium?.copyWith(
                color: _RF.primary(context),
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}

/// Numeric-only text field for macro goal inputs.
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
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,1}')),
      ],
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: accentColor, size: 18),
        border: const OutlineInputBorder(),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      validator: (v) {
        if (v != null && v.isNotEmpty && double.tryParse(v) == null) {
          return 'Invalid number';
        }
        return null;
      },
    );
  }
}

// -- Nutrition chip helper --

/// A compact horizontal row of macro chips (kcal / protein / carbs / fat).
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
    final scheme = Theme.of(context).colorScheme;

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
        chip('kcal', kcal.toStringAsFixed(0), scheme.primary),
        chip('P', '${protein.toStringAsFixed(1)}g', kTertiaryColor),
        chip('C', '${carbs.toStringAsFixed(1)}g', kSecondaryColor),
        chip('F', '${fat.toStringAsFixed(1)}g', kPrimaryButtonColor),
      ],
    );
  }
}
