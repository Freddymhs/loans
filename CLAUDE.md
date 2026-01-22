# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Run the app
flutter run

# Run tests
flutter test

# Run single test file
flutter test test/path/to/test.dart

# Analyze code (lint)
flutter analyze

# Format code
dart format .

# Code generation (after modifying models with @JsonSerializable)
dart run build_runner build --delete-conflicting-outputs

# Get dependencies
flutter pub get
```

## Architecture

This is a Flutter app using **Clean Architecture with 4 numbered layers**:

```
lib/
├── 0_data/           # Data layer: API calls, models, repository implementations
├── 1_domain/         # Domain layer: entities, repository interfaces, use cases
├── 2_application/    # UI layer: BLoCs, pages, screens, widgets
└── 3_utils/          # Shared utilities: config, constants, errors, extensions
```

### Dependency Flow

```
UI (2_application) → UseCase (1_domain) → Repository Interface (1_domain)
                                                    ↑
Repository Impl (0_data) → DataSource (0_data) ────┘
```

### Key Patterns

**UseCase Pattern**: All business logic goes through use cases that return `Either<Failure, T>`:
```dart
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}
```

**BLoC Pattern**: State management with events and states. Inject use cases via constructor.

**Failure Handling**: Use sealed `Failure` classes from `3_utils/errors/failures.dart`. Repository implementations catch exceptions and return `Left(SomeFailure(...))` or `Right(data)`.

**Dependency Injection**: All dependencies registered in `injection_container.dart` using GetIt.

### Adding New Features

1. Create entity in `1_domain/entities/`
2. Create repository interface in `1_domain/repositories/`
3. Create use case(s) in `1_domain/usecases/`
4. Create model in `0_data/models/` (with `@JsonSerializable` if needed)
5. Create datasource interface and implementation in `0_data/datasources/`
6. Create repository implementation in `0_data/repositories/`
7. Create BLoC in `2_application/bloc/`
8. Register all in `injection_container.dart`

## Code Style

- Uses `very_good_analysis` for strict linting
- File naming: `snake_case.dart`
- Entities are immutable with `final` fields and extend `Equatable`
- BLoC events extend `Equatable`
- Use package imports: `package:loans/...`

## Restricciones

- No hacer commits ni sugerirlos
