import 'package:get_it/get_it.dart';

final _getIt = GetIt.instance;

class UnregisteredDependencyException implements Exception {
  UnregisteredDependencyException(this.message);
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
    _getIt.registerSingleton<T>(instance);
  } else {
    _getIt.registerSingleton<T>(
      instance,
      instanceName: identifier.toString(),
    );
  }
}
