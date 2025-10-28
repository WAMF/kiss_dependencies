# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Dart package called `kiss_dependencies` that provides lightweight dependency injection functionality with zero external dependencies. It follows the KISS (Keep It Simple, Stupid) principle with a minimal internal service locator implementation.

## Common Development Commands

### Testing
```bash
dart test
```

### Code Quality
```bash
dart fix
dart analyze
```

### Building/Publishing
```bash
dart pub publish --dry-run
dart pub publish
```

### Running Examples
```bash
dart run example/kiss_dependencies_example.dart
```

## Architecture

The package has a simple three-layer architecture:

1. **Service Locator** (`lib/src/service_locator.dart`): Minimal internal implementation (~95 lines):
   - `ServiceLocator.instance` - Singleton service locator
   - `registerSingleton<T>()` - Register immediate singletons
   - `registerLazySingleton<T>()` - Register lazy singletons
   - `get<T>()` - Retrieve dependencies
   - `isRegistered<T>()` - Check registration status
   - `unregister<T>()` - Remove dependencies
   - Uses sealed classes for registration types (immediate vs lazy)

2. **Core Module** (`lib/src/kiss_dependencies.dart`): Public API wrapping the service locator:
   - `register<T>()` - Register lazy singletons (default)
   - `registerImmediate<T>()` - Register immediate singletons
   - `resolve<T>()` - Resolve dependencies
   - `overrideDependency<T>()` - Override existing registrations
   - `unregister<T>()` - Remove dependencies
   - Custom exceptions: `UnregisteredDependencyException`, `AlreadyRegisteredException`

3. **Factory Module** (`lib/src/object_factory.dart`): Provides factory patterns for object creation:
   - `InstanceFactory<T>` - Simple factory for creating new instances
   - `ObjectFactory<T, C>` - Context-based factory
   - `ObjectFactoryPermanentCached<T, C>` - Cached factory with context-based caching

## Key Implementation Details

- Zero external dependencies - fully self-contained
- Dependencies are registered as singletons (immediate or lazy)
- Named instances are supported via optional `identifier` parameter
- The package maintains a single global `ServiceLocator` instance
- Lazy registrations only create instances on first access
- Cached factories use Map-based caching with manual cache management methods

## Testing Approach

Tests are located in `test/kiss_dependencies_test.dart` and use the standard `test` package. The test suite covers:
- Basic registration and resolution
- Named instances with identifiers
- Factory patterns
- Exception handling for unregistered dependencies
- Duplicate registration prevention
- Dependency overriding functionality