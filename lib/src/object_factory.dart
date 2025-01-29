class InstanceFactory<T> {
  InstanceFactory(this.create);
  final T Function() create;
  T newInstance() {
    return create();
  }
}

class ObjectFactory<T, C> {
  ObjectFactory(this.create);
  final T Function(C context) create;
  T build(C context) {
    return create(context);
  }
}

class ObjectFactoryPermanentCached<T, C> extends ObjectFactory<T, C> {
  ObjectFactoryPermanentCached(super.create);
  final Map<C, T> _cache = {};
  @override
  T build(C context) {
    if (_cache.containsKey(context)) {
      return _cache[context]!;
    }
    final object = create(context);
    _cache[context] = object;
    return object;
  }

  void remove(C context) {
    _cache.remove(context);
  }

  void clear() {
    _cache.clear();
  }
}
