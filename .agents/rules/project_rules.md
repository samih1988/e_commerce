# Project Rules & Instructions for Antigravity

- **Always refer to and maintain `PROJECT_TRACKER.md`** at the workspace root before starting any work and update it after completing tasks.
- **State Management Convention:** Always use the shared `ResourceState<T>` located in `lib/features/common/resource_state.dart` for all Cubits/ViewModels. Do not generate individual `*_state.dart` files unless explicitly asked.
- **Network Results:** Use `ApiResult<T>` from `lib/features/network/api/api_result.dart` in use cases and repositories.
- **Dependency Injection:** Use Injectable (`@injectable`, `@LazySingleton`) and GetIt via `getIt<T>()`.
- **Responsive UI:** Rely on `flutter_screenutil` with the base design dimensions (430 x 932).
