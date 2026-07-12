# 🛍️ Flutter Shop App

A Flutter e-commerce application built with **Clean Architecture** and **BLoC (Cubit)** state management. The app fetches products from a REST API and lets users browse, search, and filter products, view product details, and manage a **cart** and **favorites** list — both persisted locally in an SQLite database so they survive app restarts.

## ✨ Features

- **Home / Discover** — product grid with search and category filtering
- **Product Details** — hero image animation, rating, description, price
- **Cart** — add/remove products, quantity stepper, swipe-to-delete with confirmation dialog, live total, badge counter
- **Favorites** — toggle favorites from anywhere in the app (heart syncs across all screens), add favorites straight to the cart, remove with confirmation dialog, badge counter
- **Local persistence** — cart and favorites are stored in SQLite; the database is the single source of truth
- **Responsive UI** — scales across screen sizes using `flutter_screenutil`
- **Reactive state** — a single `HomeCubit` keeps the grid, badges, details page, cart, and favorites in sync in real time

## 🏗️ Architecture

The project follows **Clean Architecture** with three layers:

```
lib/
├── core/            # Theme, utilities (shared AppBar, dialogs, snackbars,
│                    #   navigation helpers), DI setup, entity converters
├── data/            # Models (request/response entities), API + local
│                    #   data sources, repository implementations
├── domain/          # Use cases (one class per action: get products,
│                    #   add/remove/check cart & favorites, update quantity)
├── presentation/    # Pages & reusable widgets (home, details, cart,
│                    #   favorites, product card, cached image)
└── services/        # HomeCubit + HomeState (BLoC layer)
```

- **UI → Cubit → Use Case → Repository → Data Source** — each layer depends only on the one below it.
- Results flow back as a sealed `Success` / `Failure` type, handled with Dart 3 pattern matching.
- Dependency injection is wired with `get_it` + `injectable` code generation.

## 📦 Packages Used

| Package | Purpose |
|---|---|
| [flutter_bloc](https://pub.dev/packages/flutter_bloc) | State management (Cubit, BlocBuilder, BlocListener) |
| [get_it](https://pub.dev/packages/get_it) | Service locator for dependency injection |
| [injectable](https://pub.dev/packages/injectable) | Code generation for `get_it` registrations |
| [dio](https://pub.dev/packages/dio) | HTTP client for the products REST API |
| [retrofit](https://pub.dev/packages/retrofit) | Type-safe API client generation on top of Dio |
| [json_annotation](https://pub.dev/packages/json_annotation) / [json_serializable](https://pub.dev/packages/json_serializable) | JSON ⇄ model serialization code generation |
| [sqflite](https://pub.dev/packages/sqflite) | Local SQLite database for cart & favorites |
| [flutter_screenutil](https://pub.dev/packages/flutter_screenutil) | Responsive sizing (`.w`, `.h`, `.r`, `.sp`) |
| [cached_network_image](https://pub.dev/packages/cached_network_image) | Product image loading & caching |
| [build_runner](https://pub.dev/packages/build_runner) | Runs all code generators (dev dependency) |
| [injectable_generator](https://pub.dev/packages/injectable_generator) | Generator for injectable (dev dependency) |
| [retrofit_generator](https://pub.dev/packages/retrofit_generator) | Generator for retrofit (dev dependency) |

> Adjust this table to match your exact `pubspec.yaml` — remove any package you don't use (e.g. retrofit if you call Dio directly) and add any that are missing.

## 🚀 Getting Started

```bash
# 1. Clone the repo
git clone https://github.com/<your-username>/<repo-name>.git
cd <repo-name>

# 2. Install dependencies
flutter pub get

# 3. Generate code (DI, JSON serialization, API client)
dart run build_runner build --delete-conflicting-outputs

# 4. Run
flutter run
```

## 🗄️ Local Database

Two tables back the offline features:

- **cart** — `id`, `product_id`, `name`, `image`, `price` (TEXT), `quantity`, `value`, timestamps
- **favorite** — `id`, `product_id`, `is_fav`, `name`, `image`, `price` (TEXT), `value`, `created_date`, `updated_date`

Prices are stored as TEXT and converted safely to `double` in the entity layer.

