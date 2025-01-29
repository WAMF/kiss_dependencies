import 'package:get_it/get_it.dart';

final _getIt = GetIt.instance;

class UnregisteredDependencyException implements Exception {
  UnregisteredDependencyException(this.message);
  final String message;
}

class AlreadyRegisteredException implements Exception {
  AlreadyRegisteredException(this.message);
  final String message;
}

T resolve<T extends Object>({Object? identifier}) {
  try {
    if (identifier == null) {
      return _getIt.get<T>();
    }
    return _getIt.get<T>(
      instanceName: identifier.toString(),
    );
  } on Object catch (_) {
    throw UnregisteredDependencyException(
      'Error resolving dependency $T with identifier $identifier',
    );
  }
}

void register<T extends Object>(
  T instance, {
  Object? identifier,
}) {
  if (identifier == null) {
    if (_getIt.isRegistered<T>()) {
      throw AlreadyRegisteredException(
        'Dependency $T with identifier $identifier is already registered',
      );
    }
    _getIt.registerSingleton<T>(instance);
  } else {
    if (_getIt.isRegistered<T>(instanceName: identifier.toString())) {
      throw AlreadyRegisteredException(
        'Dependency $T with identifier $identifier is already registered',
      );
    }
    _getIt.registerSingleton<T>(
      instance,
      instanceName: identifier.toString(),
    );
  }
}

void registerLazy<T extends Object>(
  T Function() create, {
  Object? identifier,
}) {
  if (identifier == null) {
    _getIt.registerLazySingleton<T>(create);
  } else {
    _getIt.registerLazySingleton<T>(
      create,
      instanceName: identifier.toString(),
    );
  }
}

void override<T extends Object>(
  T instance, {
  Object? identifier,
}) {
  _getIt.unregister<T>(instanceName: identifier?.toString());
  register<T>(instance, identifier: identifier);
}

void overrideLazy<T extends Object>(
  T Function() create, {
  Object? identifier,
}) {
  _getIt.unregister<T>(instanceName: identifier?.toString());
  registerLazy<T>(create, identifier: identifier);
}
