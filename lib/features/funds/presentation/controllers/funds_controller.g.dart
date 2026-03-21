// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funds_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FundsController)
const fundsControllerProvider = FundsControllerProvider._();

final class FundsControllerProvider
    extends $AsyncNotifierProvider<FundsController, FundsState> {
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

String _$fundsControllerHash() => r'9a78419b8f7c34b693759b4d1828d35e535cb811';

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
