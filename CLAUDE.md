# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Flutter Tic-Tac-Toe app — Human vs CPU, local play only. Technical challenge following Clean Architecture principles.

## Commands

```bash
flutter pub get        # Install dependencies
flutter test           # Run all tests
flutter test test/game/usecases/play_game_test.dart   # Run a single test file
flutter run            # Run on connected device/emulator
flutter analyze        # Run static analysis (uses flutter_lints)
```

## Architecture

Clean Architecture with three layers inside each feature (for example `lib/game` or `lib/another_feature`):

- **domain/** — Business logic, models, repository interfaces, exceptions. No external dependencies. All models use `Equatable` for value equality and `copyWith` for immutable updates.
- **application/** — Use cases (one class per action: `StartGame`, `PlayGame`). Each use case orchestrates domain logic and interacts with repositories.
- **data/** — Repository implementations (`InMemoryGameRepository`).
- **presentation/** — Flutter UI with Riverpod (`flutter_riverpod`) for state management and `go_router` for navigation.

Shared utilities live in `lib/core/` (e.g., `groupBy` extension on `Iterable`).

## Domain Model

- **Game** — Root aggregate holding board, players, state, and difficulty.
- **Board** — 3x3 grid of `Cell` objects. Win detection via `hasCompleteRow()`, `hasCompleteColumn()`, `hasCompleteDiagonal()`.
- **Player** — Has name and symbol. Factory constructors: `Player.player(name)`, `Player.ia()`.
- **Symbol** — Enum: `x`, `o`, `empty`.
- **Difficulty** — Enum: `easy`, `medium`, `difficult`.

## Testing

Tests are in `test/game/` mirroring the source structure:
- `usecases/` — Use case tests (start game, play game)
- `winning_conditions/` — Board win detection (rows, columns, diagonals)
- `builder/game_builder.dart` — Test builder pattern for constructing `Game` instances

Tests use Given-When-Then structure with descriptive ASCII board representations in test names.
