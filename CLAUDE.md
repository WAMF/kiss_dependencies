# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Dart package called `kiss_dependencies` that provides lightweight dependency injection functionality built on top of get_it. It follows the KISS (Keep It Simple, Stupid) principle.

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

The package has a simple two-layer architecture:

1. **Core Module** (`lib/src/kiss_dependencies.dart`): Contains the main dependency injection functions that wrap get_it functionality:
   - `register<T>()` - Register immediate singletons
   - `registerLazy<T>()` - Register lazy singletons
   - `resolve<T>()` - Resolve dependencies
   - `overrideDependency<T>()` - Override existing registrations
   - Custom exceptions: `UnregisteredDependencyException`, `AlreadyRegisteredException`

2. **Factory Module** (`lib/src/object_factory.dart`): Provides factory patterns for object creation:
   - `InstanceFactory<T>` - Simple factory for creating new instances
   - `ObjectFactory<T, C>` - Context-based factory
   - `ObjectFactoryPermanentCached<T, C>` - Cached factory with context-based caching

## Key Implementation Details

- All functionality is built on top of `get_it` package
- Dependencies are registered as singletons (immediate or lazy)
- Named instances are supported via optional `identifier` parameter
- The package maintains a single global `GetIt` instance
- Cached factories use Map-based caching with manual cache management methods

## Testing Approach

Tests are located in `test/kiss_dependencies_test.dart` and use the standard `test` package. The test suite covers:
- Basic registration and resolution
- Named instances with identifiers
- Factory patterns
- Exception handling for unregistered dependencies
- Duplicate registration prevention
- Dependency overriding functionality