// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funds_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller that manages [FundsState] state for the funds feature.

@ProviderFor(FundsController)
const fundsControllerProvider = FundsControllerProvider._();

/// Controller that manages [FundsState] state for the funds feature.
final class FundsControllerProvider
    extends $AsyncNotifierProvider<FundsController, FundsState> {
  /// Controller that manages [FundsState] state for the funds feature.
  const FundsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fundsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fundsControllerHash();

  @$internal
  @override
  FundsController create() => FundsController();
}

String _$fundsControllerHash() => r'3b75d4069ab848f35469a3424173eb8776ef2288';

/// Controller that manages [FundsState] state for the funds feature.

abstract class _$FundsController extends $AsyncNotifier<FundsState> {
  FutureOr<FundsState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<FundsState>, FundsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<FundsState>, FundsState>,
              AsyncValue<FundsState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
