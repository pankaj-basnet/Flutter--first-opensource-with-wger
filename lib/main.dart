import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realflutter/database/nutrition_repository.dart';
import 'package:realflutter/database/powersync/database.dart';
import 'package:realflutter/l10n/generated/app_localizations.dart';
import 'package:realflutter/models/nutrition/nutritional_plan.dart';
import 'package:realflutter/theme/theme.dart';
import 'package:realflutter/widgets/nutrition/forms.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RealFlutter Offline Engine',
      theme: rfLightTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Consumer(
        builder: (context, ref, _) {
          // Listen directly to the standardized local Drift DB provider
          final databaseInstance = ref.watch(driftPowerSyncDatabase);
          return _DatabaseSeedingCoordinator(db: databaseInstance);
        },
      ),
    );
  }
}

class _DatabaseSeedingCoordinator extends StatelessWidget {
  final DriftPowersyncDatabase db;

  const _DatabaseSeedingCoordinator({required this.db});

  @override
  Widget build(BuildContext context) {
    final nutritionRepo = NutritionRepository(db);

    return StreamBuilder<List<NutritionalPlan>>(
      stream: nutritionRepo.watchAllPlans(),
      builder: (context, snapshot) {
        // Enforce systematic loading screens while waiting for SQLite descriptors
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(strokeWidth: 3.0),
            ),
          );
        }

        final dynamicPlanList = snapshot.data ?? [];

        // // Catch intercept state: if SQL storage is completely blank, execute seeding pipeline
        // if (dynamicPlanList.isEmpty) {
        //   return Scaffold(
        //     body: FutureBuilder<void>(
        //       future: nutritionRepo.seedHardcodedInitialPlans(),
        //       builder: (context, seedSnapshot) {
        //         if (seedSnapshot.connectionState == ConnectionState.none) {
        //           return Scaffold(
        //             body: Center(
        //               child: Text(
        //                 'Seeding Layer Critical Failure: ${seedSnapshot.error}',
        //                 style: const TextStyle(color: Colors.red),
        //               ),
        //             ),
        //           );
        //         }
        //         return const Scaffold(
        //           body: Center(
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 CircularProgressIndicator(),
        //                 SizedBox(height: 20),
        //                 Text(
        //                   'Initializing Offline Nutrition Templates...',
        //                   style: TextStyle(fontWeight: FontWeight.w600),
        //                 )
        //               ],
        //             ),
        //           ),
        //         );
        //       },
        //     ),
        //   );
        // }

        // nutritionRepo.seedHardcodedInitialPlans();

        // Active State Found: Render logging views using the first available plan ID
        final primaryPlanId = dynamicPlanList.first.id;
        return getIngredientLogForm(primaryPlanId, db);
      },
    );
  }
}
