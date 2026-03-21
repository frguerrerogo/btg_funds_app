import 'package:btg_funds_app/app/router/app_routes.dart';
import 'package:btg_funds_app/core/widgets/error_widget.dart';
import 'package:go_router/go_router.dart';

/// Global GoRouter instance for the application navigation.
/// Routes are generated from `@TypedGoRoute` annotations in `app_routes.dart`.
/// Uses a custom error handler via `errorBuilder` with [AppRouteErrorWidget].
final appRouter = GoRouter(
  initialLocation: '/funds',
  debugLogDiagnostics: true,
  routes: $appRoutes,
  errorBuilder: (context, state) => AppRouteErrorWidget(state: state),
);
