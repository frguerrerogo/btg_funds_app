import 'package:btg_funds_app/core/core.dart'
    show
        AppErrorBanner,
        LoadingWidget,
        NetworkException,
        ServerException,
        SnackBarExtension,
        TimeoutException;
import 'package:btg_funds_app/features/funds/domain/domain.dart'
    show
        AlreadySubscribedException,
        FundEntity,
        InsufficientBalanceException,
        NotSubscribedException;
import 'package:btg_funds_app/features/funds/presentation/presentation.dart'
    show BalanceBanner, FundCard, FundsState, NotificationSelector, fundsControllerProvider;
import 'package:btg_funds_app/features/transaction/domain/domain.dart' show NotificationMethod;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A funds browsing screen with fund cards and subscription actions.
///
/// Provides the main UI for managing fund subscriptions and cancellations.
class FundsPage extends ConsumerStatefulWidget {
  /// Creates a [FundsPage].
  const FundsPage({super.key});

  @override
  ConsumerState<FundsPage> createState() => _FundsPageState();
}

/// Manages the state and error handling for the funds browsing interface.
class _FundsPageState extends ConsumerState<FundsPage> {
  NotificationMethod _notificationMethod = NotificationMethod.email;
  Object? _lastShownError;
  DateTime? _lastErrorTime;

  static const _errorDeduplicationWindow = Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<FundsState>>(
      fundsControllerProvider,
      (previous, next) {
        if (!next.hasError) {
          _lastShownError = null;
          return;
        }

        final error = next.error;

        final now = DateTime.now();
        if (_lastShownError == error &&
            _lastErrorTime != null &&
            now.difference(_lastErrorTime!) < _errorDeduplicationWindow) {
          return;
        }

        if (error is InsufficientBalanceException ||
            error is AlreadySubscribedException ||
            error is NotSubscribedException) {
          _lastShownError = error;
          _lastErrorTime = now;
          if (mounted) {
            final message = switch (error) {
              InsufficientBalanceException() =>
                'No cuenta con el saldo disponible para vincularse al fondo',
              AlreadySubscribedException() => 'Ya se encuentra suscrito a este fondo',
              NotSubscribedException() => 'No se encuentra suscrito a este fondo',
              _ => '',
            };
            context.showErrorSnackBar(message);
          }
        }
      },
    );

    final state = ref.watch(fundsControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Fondos disponibles')),
      body: state.when(
        loading: () => const LoadingWidget(),
        error: (error, _) => _buildErrorState(context, error),
        data: _buildContent,
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, Object error) {
    final message = switch (error) {
      TimeoutException(:final message) => message,
      ServerException(:final message) => message,
      NetworkException(:final message) => message,
      _ => 'Error desconocido. Intente de nuevo.',
    };

    return AppErrorBanner(
      message: message,
      onRetry: () => ref.invalidate(fundsControllerProvider),
    );
  }

  Widget _buildContent(FundsState fundsState) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 600;
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: BalanceBanner(
                balance: fundsState.user.balance,
                subscribedCount: fundsState.user.activeSubscriptions.length,
              ),
            ),
            if (fundsState.funds.isEmpty)
              const SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.account_balance_outlined,
                        size: 48,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'No hay fondos disponibles',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isWide ? 2 : 1,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: isWide ? 2.2 : 3.5,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final fund = fundsState.funds[index];
                      return FundCard(
                        fund: fund,
                        onSubscribe: () => _onSubscribe(fund),
                        onCancel: () => _onCancel(fund),
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

  Future<void> _onSubscribe(FundEntity fund) async {
    final confirmed = await _showSubscribeDialog(fund);
    if (!confirmed) return;

    await ref
        .read(fundsControllerProvider.notifier)
        .subscribeFund(
          fundId: fund.id,
          name: fund.name,
          minimumAmount: fund.minimumAmount,
          notificationMethod: _notificationMethod,
        );

    if (mounted && !ref.read(fundsControllerProvider).hasError) {
      context.showSuccessSnackBar('Suscripción a ${fund.name} exitosa');
    }
  }

  Future<void> _onCancel(FundEntity fund) async {
    final confirmed = await _showCancelDialog(fund);
    if (!confirmed) return;

    await ref
        .read(fundsControllerProvider.notifier)
        .cancelFund(
          fundId: fund.id,
          fundName: fund.name,
          amount: fund.minimumAmount,
          notificationMethod: _notificationMethod,
        );

    if (mounted && !ref.read(fundsControllerProvider).hasError) {
      context.showSuccessSnackBar('Cancelación de ${fund.name} exitosa');
    }
  }

  Future<bool> _showSubscribeDialog(FundEntity fund) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              title: const Text('Confirmar suscripción'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('¿Desea suscribirse a ${fund.name}?'),
                  const SizedBox(height: 16),
                  NotificationSelector(
                    selected: _notificationMethod,
                    onChanged: (method) {
                      setState(() => _notificationMethod = method);
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Confirmar'),
                ),
              ],
            ),
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
              '¿Está seguro que desea cancelar su suscripción a ${fund.name}?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('No'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
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
