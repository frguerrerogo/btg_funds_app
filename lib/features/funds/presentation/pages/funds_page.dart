import 'package:btg_funds_app/core/core.dart'
    show
        AppColors,
        AppConstants,
        AppErrorWidget,
        ErrorMappingExtension,
        LoadingWidget,
        ResponsiveExtension,
        SnackBarExtension;
import 'package:btg_funds_app/features/funds/domain/domain.dart'
    show
        AlreadySubscribedException,
        FundEntity,
        InsufficientBalanceException,
        NotSubscribedException;
import 'package:btg_funds_app/features/funds/presentation/presentation.dart'
    show
        BalanceBanner,
        FundCard,
        FundsState,
        NotificationSelector,
        NotificationSelectorState,
        fundsControllerProvider;
import 'package:btg_funds_app/features/transaction/domain/domain.dart' show NotificationMethod;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Displays a browsing interface for available investment funds.
///
/// Allows users to subscribe to and manage their fund subscriptions with balance
/// information and real-time error handling for business operations.
class FundsPage extends ConsumerStatefulWidget {
  /// Creates a [FundsPage].
  const FundsPage({super.key});

  @override
  ConsumerState<FundsPage> createState() => _FundsPageState();
}

/// Manages the state, error handling, and user interactions for the funds browsing interface.
class _FundsPageState extends ConsumerState<FundsPage> {
  late NotificationMethod _notificationMethod;

  String? _lastErrorMessage;
  DateTime? _lastErrorTime;

  @override
  void initState() {
    super.initState();
    _notificationMethod = NotificationMethod.email;
  }

  @override
  Widget build(BuildContext context) {
    _setupErrorListener();

    final state = ref.watch(fundsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fondos disponibles'),
        centerTitle: true,
      ),
      body: state.when(
        loading: () => const LoadingWidget(),
        error: (error, _) => AppErrorWidget(
          message: error.mapTechnicalErrorToMessage(),
          onRetry: () => ref.invalidate(fundsControllerProvider),
        ),
        data: _buildContent,
      ),
    );
  }

  Widget _buildContent(FundsState fundsState) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final horizontalPadding = constraints.responsiveHorizontalPadding;

        return CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 16,
              ),
              sliver: SliverToBoxAdapter(
                child: BalanceBanner(
                  balance: fundsState.user.balance,
                  subscribedCount: fundsState.user.activeSubscriptions.length,
                ),
              ),
            ),

            if (fundsState.funds.isEmpty)
              SliverFillRemaining(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: const Center(
                    child: Text('No hay fondos disponibles'),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 16,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final fund = fundsState.funds[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: SizedBox(
                          height: 160,
                          child: FundCard(
                            fund: fund,
                            onSubscribe: () => _onSubscribe(fund),
                            onCancel: () => _onCancel(fund),
                          ),
                        ),
                      );
                    },
                    childCount: fundsState.funds.length,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  void _setupErrorListener() {
    ref.listen<AsyncValue<FundsState>>(
      fundsControllerProvider,
      (previous, next) {
        if (!next.hasError) return;

        final error = next.error;
        final message = _mapBusinessErrorToMessage(error);

        if (message == null) return;

        final now = DateTime.now();

        final isDuplicate =
            _lastErrorMessage == message &&
            _lastErrorTime != null &&
            now.difference(_lastErrorTime!) < AppConstants.errorDeduplicationWindow;

        if (isDuplicate) return;

        _lastErrorMessage = message;
        _lastErrorTime = now;

        if (mounted) {
          context.showErrorSnackBar(message);
        }
      },
    );
  }

  String? _mapBusinessErrorToMessage(Object? error) {
    if (error is InsufficientBalanceException) {
      return 'No cuenta con saldo suficiente';
    }

    if (error is AlreadySubscribedException) {
      return 'Ya está suscrito a este fondo';
    }

    if (error is NotSubscribedException) {
      return 'No está suscrito a este fondo';
    }

    return null;
  }

  Future<void> _onSubscribe(FundEntity fund) async {
    final confirmed = await _showSubscribeDialog(fund);
    if (!confirmed) return;

    final success = await ref
        .read(fundsControllerProvider.notifier)
        .subscribeFund(
          fundId: fund.id,
          name: fund.name,
          minimumAmount: fund.minimumAmount,
          notificationMethod: _notificationMethod,
        );

    if (mounted && success) {
      context.showSuccessSnackBar(
        'Suscripción a ${fund.name} exitosa',
      );
    }
  }

  Future<void> _onCancel(FundEntity fund) async {
    final confirmed = await _showCancelDialog(fund);
    if (!confirmed) return;

    final success = await ref
        .read(fundsControllerProvider.notifier)
        .cancelFund(
          fundId: fund.id,
          fundName: fund.name,
          amount: fund.minimumAmount,
          notificationMethod: _notificationMethod,
        );

    if (mounted && success) {
      context.showSuccessSnackBar(
        'Cancelación de ${fund.name} exitosa',
      );
    }
  }

  Future<bool> _showSubscribeDialog(FundEntity fund) async {
    final selectorKey = GlobalKey<NotificationSelectorState>();

    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirmar suscripción'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('¿Desea suscribirse a ${fund.name}?'),
                const SizedBox(height: 16),
                NotificationSelector(
                  key: selectorKey,
                  initialMethod: _notificationMethod,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  _notificationMethod = selectorKey.currentState!.selectedMethod;
                  Navigator.pop(context, true);
                },
                child: const Text('Confirmar'),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<bool> _showCancelDialog(FundEntity fund) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Cancelar suscripción'),
            content: Text(
              '¿Seguro que deseas cancelar ${fund.name}?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('No'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                ),
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Sí, cancelar'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
