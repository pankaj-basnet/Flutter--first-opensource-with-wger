# Flutter Frontend (`realflutter`) fitness mobile app


> **A production-grade, offline-first fitness application frontend containing real-world fitness modules (Nutritional Plans, Diary Logs, and Offline Storage) built to interface seamlessly with a Django (Python) backend.**


## 1. What the Project Does

`realflutter` is a cut-down version of the wger Flutter app that focuses only on the **nutrition/ingredient** module. The goal is:


The `realflutter` project is a Flutter mobile application being built as a community-facing reimplementation of the `wger` fitness/nutrition platform. Its stack combines **Drift** (type-safe SQLite ORM), **PowerSync** (offline-first sync layer), **Riverpod** (state management), and **Freezed + json_serializable** (immutable data classes with codegen). This is a production-grade technology combination that demands careful architectural discipline even at the earliest stages.

- Current project is at **25% milestone** for the first frontend (flutter) implementation, which focused entirely on `forms.dart` — the `IngredientForm` widget and the `getIngredientLogForm` factory function, which is architecturally sound.


---

## 🌍 2. The Open-Source Initiative

This project validates that any modern frontend framework can instantly snap onto a spec-compliant backend. The goal of this initiative is to create over **10 independent implementations** of the same project schema (5 frontends, 5 backends).

All clients and servers are completely plug-and-play interchangeable, rigidly adhering to a singular customized API specification modeled after the [RealWorld Spec](https://docs.realworld.show/specifications/backend/introduction/).

| # | Ecosystem | Implementation | Details |
| --- | --- | --- | --- |
| **1** | **Original Project** | [  ](https://github.com/wger-project/wger) | Wger Opensource Fitness App (Web + Mobile) |
| **2** | **Frontend (This Repo)** | Flutter + Riverpod | Mobile/Web client focusing on offline-first architecture. |
| **3** | **Backend Companion** | Django (Python) | Primary companion server adhering to the unified API spec. |

---

## 🛠 3. Architecture & State Strategy

The engineering principles behind `realflutter` heavily isolate UI components from database and networking logic. We have recently hit the **30% Milestone**, successfully moving away from hardcoded mock data in widgets to full **Drift CRUD operations** for meals and meal items, using PowerSync purely as the sync layer.

* 🔐 **Authentication & Networking (Planned):** Communicates directly with the Django backend.
* 💾 **Offline-First Persistence:** Implements a reactive data syncing framework using a unified PowerSync-backed Drift engine to stream states right into the user interface.
* 🛡️ **Robust Fallback Mechanisms:** Network out-of-bounds queries, unexpected timeouts, or uninitialized backends gracefully fall back onto the Drift local database.

---

## 🚀 5. Getting Started

### Prerequisites & Installation

1. **Clone the Git repository**
```shell
git clone git@github.com:pankaj-basnet/Flutter--first-opensource-with-wger.git
cd realflutter

```


2. **Fetch Dependencies and Run Code Generation**
```shell
flutter pub get
dart run build_runner build --delete-conflicting-outputs

```


3. **Run Application**
```shell
# Launch on your connected emulator or browser target
flutter run

```



### Testing Suite

* **Unit Tests:** `flutter test` (Runs structural unit tests assessing state providers, models, and mock repository overrides).
* **Integration Tests:** `flutter test integration_test/app_test.dart` (Executes local end-to-end user path validation sequences).

---

## 📈 6. Feature Compatibility

| # | Feature Compatibility | Spec Compliance Status | Implementation Detail |
| --- | --- | --- | --- |
| **1** | 🥗 Ingredients Management | Ongoing | Search, view nutritional data, calculate custom macro ratios. |
| **2** | 🏋️ Exercises Directory | Planned | Filter exercises by targeted muscle groups or equipment needed. |
| **3** | 📉 Measurements Trackers | Planned | Render visual tracking charts for weight and performance metrics. |

### Development Progress & Commit History


---


##  PowerSync Offline Mode: How It Wires Together 🔌

Understanding why this works offline is important for week 2 on the wger project.

```
ONLINE (PowerSync syncing):

  Django REST API
       │  JSON over HTTP
       ▼
  PowerSync Cloud
       │  WebSocket sync protocol
       ▼
  PowerSync SQLite (local)   ← same file as Drift reads
       │
       ▼
  DriftPowersyncDatabase
  (drift_sqlite_async wraps the PowerSync SQLite connection)
       │
       ▼
  NutritionRepository (SELECT/INSERT via Drift)
       │  Stream<T>
       ▼
  StreamBuilder → UI updates automatically
```

```
OFFLINE (no internet):

  Django REST API   ✗  (unreachable)
  PowerSync Cloud   ✗  (no sync)

  PowerSync SQLite (local)   ← STILL AVAILABLE, has all cached data
       │
       ▼
  DriftPowersyncDatabase  ← queries work normally against cached SQLite
       │
       ▼
  NutritionRepository → INSERT writes to local SQLite queue
       │  Stream<T>
       ▼
  StreamBuilder → UI updates from local writes immediately ✅

  When connectivity returns → PowerSync syncs queued writes to server
```

| SN | Screenshot A | Screenshot B | Screenshot C | Screenshot D |
| :--- | :--- | :--- | :--- | :--- |
| **1** |  <img src="assets/readme/screenshot_5_20260606_204139.png" width="250"/>  |  <img src="assets/readme/screenshot_6_20260606_204315.png" width="250"/>  | <img src="assets/readme/screenshot_7_20260606_204341.png" width="250"/> |   <img src="assets/readme/screenshot_8_20260606_204247.png" width="250"/>  |
<!-- | **1** |  <img src="assets/readme/screenshot_5_20260606_204139.png.png" width="250"/>  | [`6d0edb7`](https://github.com/pankaj-basnet/Flutter--first-opensource-with-wger/commit/6d0edb72da7b32468218c521fcec9ac8116ed0f8) <br>•  Setup flutter project and Integrate `http` package to fetch GitHub JSON payload.<br>• Initial UI successfully renders live-fetched nutritional plan data. | <img src="assets/readme/s3-ingredientFormScreen.png" width="250"/> |  [`6f45b96`](https://github.com/pankaj-basnet/Flutter--first-opensource-with-wger/commit/6f45b960cac6ee604520f0d79bdefc7ac87a5cbc) <br>•  Ingredient log form with data models<br>•  Drift/powersync setup for offline mode | -->



## Full Architecture Map 🏗️

```
main.dart
  └── ProviderScope (Riverpod — only here)
        └── powerSyncInstanceProvider (FutureProvider)
              └── DriftPowersyncDatabase (Drift over SQLite)
                    └── NutritionRepository (wraps Drift DAOs)
                          │
                    ┌─────┴──────────────────────────────────┐
                    │  watchPlan()  watchMeals()  insertLog() │
                    └───────────────────┬────────────────────┘
                                        │ Stream<T>
                          ┌─────────────▼──────────────────────┐
                          │  IngredientLogScreen (StreamBuilder)│
                          │  IngredientDetail                   │
                          │  MealSummarySection                 │
                          │  MealForm   PlanForm                │
                          └────────────────────────────────────┘

PowerSync sync layer (background):
  SQLite (local) ◄──────────────► wger Django REST API
                  PowerSync sync
                  (automatic when online)
```


---



#### About first-opensource-wger-devs Clones

The goal of this initiative is to create over 10 independent implementations of the same project schema (5 frontends for web/mobile, 5 backends for web/mobile). All clients and servers are completely plug-and-play interchangeable as they rigidly adhere to a singular, customized API specification modeled after the opensource [RealWorld Spec](https://docs.realworld.show/specifications/backend/introduction/).

- RealWorld's [backend implementations](https://docs.realworld.show/specifications/backend/introduction/) adhere to their own specific [API spec](https://github.com/realworld-apps/realworld/tree/main/specs/api). The full API is described in the [OpenAPI spec]https://github.com/realworld-apps/realworld/blob/main/specs/api/openapi.yml.

Aimed for first-time opensource contributors/students to use production-grade architecture while ensuring they are not overwhelmed by complex dependency trees. This training blueprint focuses on how students can study the core workout and nutrition management system, `wger`, and adapt its design for an internal practice project named `realflutter`.


|  |   | Wger Project |  |  |
| :--- | :--- | :--- | :--- | :--- |
|  | [ <img src="assets/readme/wger-web-mob-png.png" width="100"/> ](https://github.com/wger-project/wger) |  Wger Opensource Fitness App ( web + mobile ) |  |  |



---


---

## 🤝 7. Contributing & License

This frontend conforms strictly to the presentation layout requirements specified in the `first-opensource-wger-devs` Frontend Format Guides. Route names, state-dependent button conditions, and authentication token headers remain identical across all planned frontend iterations.

**To contribute:**

* Fork the repository and develop on a custom feature branch.
* Always run `dart format .` before pushing code changes.
* Ensure that modifications changing application state include corresponding Riverpod provider test evaluations.

**License:**
This project is open-source and released under the MIT License.

## Development Progress & Commit History

| SN | Screenshot A | Commit A | Screenshot B | Commit B |
| :--- | :--- | :--- | :--- | :--- |
| **1** |  <img src="assets/readme/screenshot1.png" width="250"/>  | [`6d0edb7`](https://github.com/pankaj-basnet/Flutter--first-opensource-with-wger/commit/6d0edb72da7b32468218c521fcec9ac8116ed0f8) <br>•  Setup flutter project and Integrate `http` package to fetch GitHub JSON payload.<br>• Initial UI successfully renders live-fetched nutritional plan data. | <img src="assets/readme/s3-ingredientFormScreen.png" width="250"/> |  [`6f45b96`](https://github.com/pankaj-basnet/Flutter--first-opensource-with-wger/commit/6f45b960cac6ee604520f0d79bdefc7ac87a5cbc) <br>•  Ingredient log form with data models<br>•  Drift/powersync setup for offline mode |
| **2** | <img src="assets/readme/screenshot3.png" width="250"/> | `[Hash]`<br>• Next feature description<br>• Next feature description | <img src="assets/readme/screenshot4.png" width="250"/> | `[Hash]`<br>• Next feature description<br>• Next feature description |


---

