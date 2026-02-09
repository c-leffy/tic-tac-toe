<div align="center">
  <img src="apps/tic_tac_toe/assets/icon/icon.png" alt="Tic Tac Toe" width="200">
  <h1>Tic-Tac-Toe</h1>
  <img src="demo.gif" alt="Demo" width="300">
</div>

A Flutter implementation of the classic Tic-Tac-Toe game featuring Human vs CPU gameplay, built with Clean Architecture principles.

[![Play Online](https://img.shields.io/badge/Play-Online-blue?style=for-the-badge)](https://c-leffy.github.io/tic-tac-toe/)

## Overview

Challenge the AI in this classic game! Choose your difficulty level and try to beat the computer:
- **Easy** - Random moves
- **Medium** - Blocks your winning moves
- **Difficult** - Unbeatable (Minimax algorithm)

## Testing

If you want to test the app (only for Android or web), you can :
- Use Firebase App Distribution with this link : https://appdistribution.firebase.dev/i/0ae381bcdbc34883
- Directly download the APK in the release section : https://github.com/c-leffy/tic-tac-toe/releases
- In the browser: https://c-leffy.github.io/tic-tac-toe/

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.0+)
- [Melos](https://melos.invertase.dev/) (optional, for package management)

### Installation

```bash
# Clone the repository
git clone https://github.com/c-leffy/tic-tac-toe.git
cd tic-tac-toe

# Bootstrap the workspace (installs all dependencies)
dart run melos bootstrap

# Run the app
cd apps/tic_tac_toe
flutter run
```

### Firebase Configuration

This project uses Firebase for analytics. To run the app locally, you need to configure Firebase:

1. **Create your `.env` file** in `apps/tic_tac_toe/` (see `.env.example` for required variables)

2. **Download `google-services.json`** from [Firebase Console](https://console.firebase.google.com/) and place it in `apps/tic_tac_toe/android/app/`

3. **For iOS** (optional): Download `GoogleService-Info.plist` and place it in `apps/tic_tac_toe/ios/Runner/`

#### CI/CD Configuration

For GitHub Actions, add these secrets to your repository (Settings → Secrets → Actions):

| Secret                        | How to generate                                                                                                                                  |
|-------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------|
| `DOTENV_BASE64`               | `base64 -i apps/tic_tac_toe/.env` (macOS) or `base64 -w 0 apps/tic_tac_toe/.env` (Linux)                                                         |
| `GOOGLE_SERVICES_JSON_BASE64` | `base64 -i apps/tic_tac_toe/android/app/google-services.json` (macOS) or `base64 -w 0 apps/tic_tac_toe/android/app/google-services.json` (Linux) |

## Project Structure

This project uses a **Melos monorepo** architecture with multiple packages:

```
tic_tac_toe/
├── apps/
│   └── tic_tac_toe/        # Main Flutter app (entry point, routing)
├── packages/
│   ├── analytics/           # Firebase Analytics abstraction
│   ├── core/                # Shared UI components, theme, utilities
│   ├── game/                # Game feature (logic, UI, tests)
│   ├── login/               # Login/register feature
│   └── logs/                # Logging abstraction
└── pubspec.yaml             # Workspace coordinator
```

## Commands

| Command                      | Description                           |
|------------------------------|---------------------------------------|
| `dart run melos bootstrap`   | Install dependencies for all packages |
| `dart run melos run analyze` | Run static analysis on all packages   |
| `dart run melos run test`    | Run tests in all packages             |
| `dart run melos run clean`   | Clean all packages                    |

### Package-specific Commands

```bash
# Run tests for a specific package
flutter test packages/game
flutter test packages/login

# Analyze the app
flutter analyze apps/tic_tac_toe
```

## Architecture

This project follows **Clean Architecture** (Ports & Adapters) with four distinct layers:

| Layer              | Purpose                                          |
|--------------------|--------------------------------------------------|
| **Domain**         | Models, business logic, strategies               |
| **Application**    | Use cases, ports (abstract interfaces)           |
| **Infrastructure** | Repository implementations, dependency injection |
| **Presentation**   | Views, ViewModels, Widgets                       |

**Dependency rule**: Inner layers never import outer layers. Infrastructure implements application ports.

## Documentation

- [Technical Challenge](./TECHNICAL_TEST.md) - Original test requirements

## License

This project is provided for educational and evaluation purposes.
