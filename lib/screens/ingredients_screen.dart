import 'package:flutter/material.dart';
import 'package:realflutter/database/nutrition_repository.dart';
import 'package:realflutter/l10n/generated/app_localizations.dart';
import 'package:realflutter/models/nutrition/nutritional_plan.dart';
import 'package:realflutter/theme/theme.dart';
import 'package:realflutter/widgets/nutrition/forms.dart';
import 'package:realflutter/widgets/nutrition/plan_form.dart';

// -- IngredientLogScreen --

class IngredientLogScreen extends StatelessWidget {
  // final NutritionalPlan plan;
  final String planId; // pass ID, not the whole plan
  final NutritionRepository repo;
  final dynamic db;

  const IngredientLogScreen({
    super.key,
    required this.planId,
    this.db,
    required this.repo,
  });

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
      // body: IngredientDetail(plan: plan, db: db, repo: repo),
      body: StreamBuilder<NutritionalPlan?>(
        stream: repo.watchPlan(planId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final plan = snapshot.data;
          if (plan == null) {
            return const Center(child: Text('Plan not found'));
          }
          return IngredientDetail(plan: plan, repo: repo);
        },
      ),
    );
  }

  void _navigateToPlanForm(BuildContext context) {
    // Navigator.of(
    //   context,
    // ).push(MaterialPageRoute(builder: (_) => PlanForm(plan)));

    repo.watchPlan(planId).first.then((plan) {
      if (plan != null && context.mounted) {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => PlanForm(plan, repo: repo)));
      }
    });
  }
}
