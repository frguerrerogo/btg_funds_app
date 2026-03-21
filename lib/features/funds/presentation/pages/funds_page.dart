import 'package:btg_funds_app/core/core.dart' show AppStateErrorWidget, LoadingWidget;
import 'package:btg_funds_app/features/funds/domain/domain.dart'
    show AlreadySubscribedException, FundEntity, InsufficientBalanceException;
import 'package:btg_funds_app/features/funds/presentation/presentation.dart'
    show BalanceBanner, FundCard, NotificationSelector, fundsControllerProvider;
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
  ConsumerState<FundsPage> createState() => _FundsScreenState();
}

class _FundsScreenState extends ConsumerState<FundsPage> {
  NotificationMethod _notificationMethod = NotificationMethod.email;

  Future<void> _onSubscribe(FundEntity fund) async {
    final confirmed = await _showSubscribeDialog(fund);
    if (!confirmed) return;

    try {
      await ref
          .read(fundsControllerProvider.notifier)
          .subscribeFund(
            fundId: fund.id,
            name: fund.name,
            minimumAmount: fund.minimumAmount,
            notificationMethod: _notificationMethod,
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Suscripción a ${fund.name} exitosa'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } on InsufficientBalanceException {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'No cuenta con el saldo disponible para vincularse al fondo',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } on AlreadySubscribedException {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ya se encuentra suscrito a este fondo'),
            backgroundColor: Colors.orange,
          ),
        );
      }
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

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cancelación de ${fund.name} exitosa'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<bool> _showSubscribeDialog(FundEntity fund) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
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
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Sí, cancelar'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(fundsControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Fondos disponibles')),
      body: state.when(
        data: (fundsState) => LayoutBuilder(
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
        ),
        loading: () => const LoadingWidget(),
        error: (error, _) => AppStateErrorWidget(
          message: error.toString(),
          onRetry: () => ref.invalidate(fundsControllerProvider),
        ),
      ),
    );
  }
}
