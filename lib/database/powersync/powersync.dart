import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:powersync/powersync.dart';
import 'package:realflutter/database/powersync/schema.dart';

/// The core PowerSync database instance
final powerSyncInstanceProvider = FutureProvider<PowerSyncDatabase>((
  ref,
) async {
  final dir = await getApplicationSupportDirectory();
  final path = join(dir.path, 'powersync-wger.db');

  final db = PowerSyncDatabase(
    // Your schema must be defined in a separate file (e.g., schema.dart)
    schema: schema,
    path: path,
  );

  await db.initialize();

  // ── OFFLINE-ONLY MODE FOR BEGINNERS ───────────────────────────────────────
  // db.connect(connector) would be called here when a PowerSync backend
  // and authentication are set up. For now, the app works with local
  // SQLite only. Data written to Drift is stored on device.
  // Uncomment and configure when ready for live sync:
  //
  // await db.connect(connector: MyBackendConnector());

  // Minimal connection: You can add authentication/connector
  // logic here when ready for live sync.
  return db;
});

/// Expose sync status minimally
final syncStatusProvider = StreamProvider<SyncStatus>((ref) async* {
  final db = await ref.watch(powerSyncInstanceProvider.future);
  yield* db.statusStream;
});
