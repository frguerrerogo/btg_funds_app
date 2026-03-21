// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller that manages [List<TransactionEntity>] state for the transaction feature.

@ProviderFor(TransactionController)
const transactionControllerProvider = TransactionControllerProvider._();

/// Controller that manages [List<TransactionEntity>] state for the transaction feature.
final class TransactionControllerProvider
    extends
        $AsyncNotifierProvider<TransactionController, List<TransactionEntity>> {
  /// Controller that manages [List<TransactionEntity>] state for the transaction feature.
  const TransactionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transactionControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$transactionControllerHash();

  @$internal
  @override
  TransactionController create() => TransactionController();
}

String _$transactionControllerHash() =>
    r'dd70b16775222ada721d4c8548911f18bad94408';

/// Controller that manages [List<TransactionEntity>] state for the transaction feature.

abstract class _$TransactionController
    extends $AsyncNotifier<List<TransactionEntity>> {
  FutureOr<List<TransactionEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<TransactionEntity>>,
              List<TransactionEntity>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<TransactionEntity>>,
                List<TransactionEntity>
              >,
              AsyncValue<List<TransactionEntity>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
