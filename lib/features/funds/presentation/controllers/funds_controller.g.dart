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
    extends $AsyncNotifierProvider<FundsController, List<FundEntity>> {
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

String _$fundsControllerHash() => r'07d610e9101ad1602ec963bcff6c8c5b367cd520';

abstract class _$FundsController extends $AsyncNotifier<List<FundEntity>> {
  FutureOr<List<FundEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<FundEntity>>, List<FundEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<FundEntity>>, List<FundEntity>>,
              AsyncValue<List<FundEntity>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
