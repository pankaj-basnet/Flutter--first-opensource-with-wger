import 'package:flutter/material.dart';
import 'package:realflutter/l10n/generated/app_localizations.dart';
import 'package:realflutter/models/nutrition/nutritional_plan.dart';
import 'package:realflutter/theme/theme.dart';
import 'package:realflutter/widgets/nutrition/forms.dart';
import 'package:realflutter/widgets/nutrition/plan_form.dart';

// -- IngredientLogScreen --

class IngredientLogScreen extends StatelessWidget {
  final NutritionalPlan plan;
  final dynamic db;

  const IngredientLogScreen({super.key, required this.plan, this.db});

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(i18n.logIngredient),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_note),
            tooltip: 'Edit plan',
            onPressed: () => _navigateToPlanForm(context),
          ),
        ],
      ),
      body: IngredientDetail(plan: plan, db: db),
    );
  }

  void _navigateToPlanForm(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => PlanForm(plan)));
  }
}
