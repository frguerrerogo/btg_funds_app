import 'package:btg_funds_app/core/widgets/adaptive_scaffold.dart';
import 'package:btg_funds_app/features/funds/presentation/pages/funds_page.dart';
import 'package:btg_funds_app/features/transaction/presentation/pages/history_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'app_routes.g.dart';

// SHELL
/// Defines the app shell navigation structure using an adaptive scaffold.
/// Nests the routes displayed at /funds and /history.
@TypedShellRoute<AppShellRouteData>(
  routes: [
    TypedGoRoute<FundsRoute>(path: '/funds'),
    TypedGoRoute<HistoryRoute>(path: '/history'),
  ],
)
class AppShellRouteData extends ShellRouteData {
  /// Creates a [AppShellRouteData].
  const AppShellRouteData();

  /// Navigator key used by GoRouter to control the [AppShellRouteData] navigation stack.
  static final GlobalKey<NavigatorState> $navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return AdaptiveScaffold(child: navigator);
  }
}

// FUNDS
/// Route for [FundsPage], displayed at `/funds`.
class FundsRoute extends GoRouteData with $FundsRoute {
  /// Creates a [FundsRoute].
  const FundsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const FundsPage();
  }
}

// HISTORY
/// Route for [HistoryPage], displayed at `/history`.
class HistoryRoute extends GoRouteData with $HistoryRoute {
  /// Creates a [HistoryRoute].
  const HistoryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HistoryPage();
  }
}
