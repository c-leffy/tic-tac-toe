<div align="center">
  <img src="assets/icon/icon.png" alt="Tic Tac Toe" width="200">
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

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.0+)

### Installation

```bash
# Clone the repository
git clone https://github.com/c-leffy/tic-tac-toe.git
cd tic-tac-toe

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Firebase Configuration

This project uses Firebase for analytics. To run the app locally, you need to configure Firebase:

1. **Create your `.env` file** at the project root (see `.env.example` for required variables)

2. **Download `google-services.json`** from [Firebase Console](https://console.firebase.google.com/) and place it in `android/app/`

3. **For iOS** (optional): Download `GoogleService-Info.plist` and place it in `ios/Runner/`

#### CI/CD Configuration

For GitHub Actions, add these secrets to your repository (Settings → Secrets → Actions):

| Secret                        | How to generate                                                                                                |
|-------------------------------|----------------------------------------------------------------------------------------------------------------|
| `DOTENV_BASE64`               | `base64 -i .env` (macOS) or `base64 -w 0 .env` (Linux)                                                         |
| `GOOGLE_SERVICES_JSON_BASE64` | `base64 -i android/app/google-services.json` (macOS) or `base64 -w 0 android/app/google-services.json` (Linux) |

## Commands

| Command             | Description                      |
|---------------------|----------------------------------|
| `flutter pub get`   | Install dependencies             |
| `flutter run`       | Run on connected device/emulator |
| `flutter test`      | Run all tests                    |
| `flutter analyze`   | Run static analysis              |
| `flutter build web` | Build for web deployment         |

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
