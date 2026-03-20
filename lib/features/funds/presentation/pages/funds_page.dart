import 'package:btg_funds_app/core/core.dart' show AppStateErrorWidget, LoadingWidget;
import 'package:btg_funds_app/features/funds/domain/domain.dart'
    show AlreadySubscribedException, FundEntity, InsufficientBalanceException;
import 'package:btg_funds_app/features/funds/presentation/presentation.dart'
    show BalanceBanner, FundCard, NotificationSelector, fundsControllerProvider;
import 'package:btg_funds_app/features/transaction/domain/domain.dart'
    show NotificationMethod, TransactionEntity, TransactionType;
import 'package:btg_funds_app/features/transaction/presentation/presentation.dart'
    show transactionControllerProvider;
import 'package:btg_funds_app/features/user/presentation/presentation.dart'
    show userControllerProvider;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

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
            fundName: fund.name,
            amount: fund.minimumAmount,
          );

      await ref
          .read(transactionControllerProvider.notifier)
          .saveTransaction(
            TransactionEntity(
              id: const Uuid().v4(),
              fundId: fund.id,
              fundName: fund.name,
              amount: fund.minimumAmount,
              type: TransactionType.subscription,
              notificationMethod: _notificationMethod,
              createdAt: DateTime.now(),
            ),
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

    await ref.read(fundsControllerProvider.notifier).cancelFund(fund.id);

    await ref
        .read(transactionControllerProvider.notifier)
        .saveTransaction(
          TransactionEntity(
            id: const Uuid().v4(),
            fundId: fund.id,
            fundName: fund.name,
            amount: fund.minimumAmount,
            type: TransactionType.cancellation,
            notificationMethod: _notificationMethod,
            createdAt: DateTime.now(),
          ),
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
    final fundsState = ref.watch(fundsControllerProvider);
    final userState = ref.watch(userControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Fondos disponibles')),
      body: Column(
        children: [
          userState.when(
            data: (user) => BalanceBanner(
              balance: user.balance,
              subscribedCount: user.activeSubscriptions.length,
            ),
            loading: () => const SizedBox(height: 80),
            error: (_, _) => const SizedBox.shrink(),
          ),
          Expanded(
            child: fundsState.when(
              data: (funds) => LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 600;
                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isWide ? 2 : 1,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: isWide ? 2.2 : 3.5,
                    ),
                    itemCount: funds.length,
                    itemBuilder: (context, index) {
                      final fund = funds[index];
                      return FundCard(
                        fund: fund,
                        onSubscribe: () => _onSubscribe(fund),
                        onCancel: () => _onCancel(fund),
                      );
                    },
                  );
                },
              ),
              loading: () => const LoadingWidget(),
              error: (error, _) => AppStateErrorWidget(
                message: error.toString(),
                onRetry: () => ref.invalidate(fundsControllerProvider),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
