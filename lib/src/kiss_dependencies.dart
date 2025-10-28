import 'package:kiss_dependencies/src/service_locator.dart';

final _serviceLocator = ServiceLocator.instance;

class UnregisteredDependencyException implements Exception {
  UnregisteredDependencyException(this.message);
  final String message;

  @override
  String toString() => 'UnregisteredDependencyException: $message';
}

class AlreadyRegisteredException implements Exception {
  AlreadyRegisteredException(this.message);
  final String message;

  @override
  String toString() => 'AlreadyRegisteredException: $message';
}

T resolve<T extends Object>({Object? identifier}) {
  try {
    if (identifier == null) {
      return _serviceLocator.get<T>();
    }
    return _serviceLocator.get<T>(
      instanceName: identifier.toString(),
    );
  } on Object catch (_) {
    throw UnregisteredDependencyException(
      'Error resolving dependency $T with identifier $identifier',
    );
  }
}

void register<T extends Object>(
  T Function() create, {
  Object? identifier,
}) {
  if (identifier == null) {
    if (_serviceLocator.isRegistered<T>()) {
      throw AlreadyRegisteredException(
        'Dependency $T with identifier $identifier is already registered',
      );
    }
    _serviceLocator.registerLazySingleton<T>(create);
  } else {
    if (_serviceLocator.isRegistered<T>(instanceName: identifier.toString())) {
      throw AlreadyRegisteredException(
        'Dependency $T with identifier $identifier is already registered',
      );
    }
    _serviceLocator.registerLazySingleton<T>(
      create,
      instanceName: identifier.toString(),
    );
  }
}

void registerImmediate<T extends Object>(
  T instance, {
  Object? identifier,
}) {
  if (identifier == null) {
    if (_serviceLocator.isRegistered<T>()) {
      throw AlreadyRegisteredException(
        'Dependency $T with identifier $identifier is already registered',
      );
    }
    _serviceLocator.registerSingleton<T>(instance);
  } else {
    if (_serviceLocator.isRegistered<T>(instanceName: identifier.toString())) {
      throw AlreadyRegisteredException(
        'Dependency $T with identifier $identifier is already registered',
      );
    }
    _serviceLocator.registerSingleton<T>(
      instance,
      instanceName: identifier.toString(),
    );
  }
}

@Deprecated(
  'Use register() instead. register() now uses lazy registration by default.',
)
void registerLazy<T extends Object>(
  T Function() create, {
  Object? identifier,
}) {
  register<T>(create, identifier: identifier);
}

void overrideDependency<T extends Object>(
  T Function() create, {
  Object? identifier,
}) {
  _serviceLocator.unregister<T>(instanceName: identifier?.toString());
  register<T>(create, identifier: identifier);
}

void overrideDependencyImmediate<T extends Object>(
  T instance, {
  Object? identifier,
}) {
  _serviceLocator.unregister<T>(instanceName: identifier?.toString());
  registerImmediate<T>(instance, identifier: identifier);
}

@Deprecated(
  'Use overrideDependency() instead. overrideDependency() now uses lazy '
  'registration by default.',
)
void overrideDependencyLazy<T extends Object>(
  T Function() create, {
  Object? identifier,
}) {
  overrideDependency<T>(create, identifier: identifier);
}

void unregister<T extends Object>({Object? identifier}) {
  _serviceLocator.unregister<T>(instanceName: identifier?.toString());
}
