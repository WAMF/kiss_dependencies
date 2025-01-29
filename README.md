# Kiss Dependencies

A lightweight dependency injection package for Dart that follows the KISS (Keep It Simple, Stupid) principle. Built on top of [get_it](https://pub.dev/packages/get_it), Kiss Dependencies provides a streamlined API for managing your application's dependencies.

## Features

- Simple registration and resolution of dependencies
- Support for named instances using identifiers
- Factory pattern support with caching capabilities
- Minimal boilerplate code
- Type-safe dependency resolution

## Installation

Add Kiss Dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  kiss_dependencies: ^1.0.1
```

## Usage

### Basic Dependency Registration

Register your dependencies as singletons:

```dart
// Register a simple service
final myService = MyService();
register<MyService>(myService);

// Register with an identifier
register<MyService>(myService, identifier: 'custom');
```

### Resolving Dependencies

Resolve your dependencies anywhere in your app:

```dart
// Resolve a registered service
final myService = resolve<MyService>();

// Resolve a service with an identifier
final customService = resolve<MyService>(identifier: 'custom');
```

### Using Object Factories

For cases where you need to create objects with specific context:

```dart
// Define and register a factory
register<ObjectFactory<MyObject, BuildContext>>(
  ObjectFactory((context) => MyObject(context))
);

// Resolve and use the factory
final factory = resolve<ObjectFactory<MyObject, BuildContext>>();
final myObject = factory.build(context);
```

### Cached Factory Pattern

When you need to cache objects based on context:

```dart
// Register a cached factory
register<ObjectFactoryPermanentCached<MyWidget, String>>(
  ObjectFactoryPermanentCached((id) => MyWidget(id))
);

// Resolve the factory and build instances
final cachedFactory = resolve<ObjectFactoryPermanentCached<MyWidget, String>>();
final widget1 = cachedFactory.build('unique_id');

// Subsequent calls return the cached instance
final widget2 = cachedFactory.build('unique_id'); // Returns cached instance

// Clear specific cache entries
cachedFactory.remove('unique_id');

// Clear all cached instances
cachedFactory.clear();
```

## Error Handling

The package provides clear error messages when dependencies cannot be resolved:

```dart
try {
  final unregistered = resolve<UnregisteredService>();
} on UnregisteredDependencyException catch (e) {
  print(e.message); // Prints: Error resolving dependency UnregisteredService with identifier null
}
```

## Best Practices

1. Register dependencies early in your application lifecycle
2. Use meaningful identifiers when registering multiple instances of the same type
3. Clear cached factories when they're no longer needed to prevent memory leaks
4. Keep your dependency tree simple and avoid circular dependencies

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see below for details:

```
MIT License

Copyright (c) 2025 

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
