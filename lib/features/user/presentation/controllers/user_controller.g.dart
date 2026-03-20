// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller that manages [UserEntity] state for the user feature.

@ProviderFor(UserController)
const userControllerProvider = UserControllerProvider._();

/// Controller that manages [UserEntity] state for the user feature.
final class UserControllerProvider
    extends $AsyncNotifierProvider<UserController, UserEntity> {
  /// Controller that manages [UserEntity] state for the user feature.
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

String _$userControllerHash() => r'18acffa6afcedcb469179bae49f0fa0ef792c2e8';

/// Controller that manages [UserEntity] state for the user feature.

abstract class _$UserController extends $AsyncNotifier<UserEntity> {
  FutureOr<UserEntity> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<UserEntity>, UserEntity>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UserEntity>, UserEntity>,
              AsyncValue<UserEntity>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
