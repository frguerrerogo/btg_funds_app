// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller that manages [UserState] state for the user feature.

@ProviderFor(UserController)
const userControllerProvider = UserControllerProvider._();

/// Controller that manages [UserState] state for the user feature.
final class UserControllerProvider
    extends $AsyncNotifierProvider<UserController, UserState> {
  /// Controller that manages [UserState] state for the user feature.
  const UserControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userControllerHash();

  @$internal
  @override
  UserController create() => UserController();
}

String _$userControllerHash() => r'79259ae8f2ed322642d34178916bbb6f7345efdd';

/// Controller that manages [UserState] state for the user feature.

abstract class _$UserController extends $AsyncNotifier<UserState> {
  FutureOr<UserState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<UserState>, UserState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UserState>, UserState>,
              AsyncValue<UserState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
