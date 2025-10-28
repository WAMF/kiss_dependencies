## 3.0.0

- Removed get_it dependency - now uses internal minimal service locator implementation
- Zero external runtime dependencies
- Smaller package footprint with full control over implementation
- Same public API - no changes needed in your code

## 2.0.1

- Improved exception handling: Added `toString()` methods to `AlreadyRegisteredException` and `UnregisteredDependencyException` for better error messages

## 2.0.0

**BREAKING CHANGES:**
- `register()` now uses lazy registration by default (was immediate)
- `registerLazy()` is now deprecated, use `register()` instead
- `overrideDependency()` now uses lazy registration by default (was immediate)
- `overrideDependencyLazy()` is now deprecated, use `overrideDependency()` instead

**New Features:**
- Added `registerImmediate()` function for immediate registration
- Added `overrideDependencyImmediate()` function for immediate override
- Added `unregister()` function for removing dependencies
- Added `analysis_options.yaml` with very_good_analysis linter rules

## 1.3.0

- Renamed `override` to `overrideDependency` and `overrideLazy` to `overrideDependencyLazy`

## 1.2.0

- Added `override` and `overrideLazy`
- Added `AlreadyRegisteredException`

## 1.1.0

- Added `registerLazy`

## 1.0.1

- Added `InstanceFactory`

## 1.0.0

- Initial version.
