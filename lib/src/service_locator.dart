sealed class _Registration<T> {
  T getInstance();
  bool get isInitialized;
}

final class _ImmediateRegistration<T> implements _Registration<T> {
  _ImmediateRegistration(this._instance);

  final T _instance;

  @override
  T getInstance() => _instance;

  @override
  bool get isInitialized => true;
}

final class _LazyRegistration<T> implements _Registration<T> {
  _LazyRegistration(this._factory);

  final T Function() _factory;
  T? _instance;

  @override
  T getInstance() {
    _instance ??= _factory();
    return _instance!;
  }

  @override
  bool get isInitialized => _instance != null;
}

class ServiceLocator {
  ServiceLocator._();
  static final instance = ServiceLocator._();

  final Map<Type, _Registration<dynamic>> _unnamedRegistrations = {};
  final Map<Type, Map<String, _Registration<dynamic>>> _namedRegistrations = {};

  void registerSingleton<T extends Object>(T instance, {String? instanceName}) {
    final registration = _ImmediateRegistration<T>(instance);
    if (instanceName == null) {
      _unnamedRegistrations[T] = registration;
    } else {
      _namedRegistrations.putIfAbsent(T, () => {})[instanceName] = registration;
    }
  }

  void registerLazySingleton<T extends Object>(
    T Function() factory, {
    String? instanceName,
  }) {
    final registration = _LazyRegistration<T>(factory);
    if (instanceName == null) {
      _unnamedRegistrations[T] = registration;
    } else {
      _namedRegistrations.putIfAbsent(T, () => {})[instanceName] = registration;
    }
  }

  T get<T extends Object>({String? instanceName}) {
    final _Registration<T>? registration;
    if (instanceName == null) {
      registration = _unnamedRegistrations[T] as _Registration<T>?;
    } else {
      registration = _namedRegistrations[T]?[instanceName] as _Registration<T>?;
    }

    if (registration == null) {
      throw StateError('Type $T is not registered');
    }

    return registration.getInstance();
  }

  bool isRegistered<T extends Object>({String? instanceName}) {
    if (instanceName == null) {
      return _unnamedRegistrations.containsKey(T);
    } else {
      return _namedRegistrations[T]?.containsKey(instanceName) ?? false;
    }
  }

  void unregister<T extends Object>({String? instanceName}) {
    if (instanceName == null) {
      _unnamedRegistrations.remove(T);
    } else {
      _namedRegistrations[T]?.remove(instanceName);
      if (_namedRegistrations[T]?.isEmpty ?? false) {
        _namedRegistrations.remove(T);
      }
    }
  }
}
