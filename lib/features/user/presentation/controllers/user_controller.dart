import 'package:btg_funds_app/core/core.dart' show getUserUseCaseProvider;
import 'package:btg_funds_app/features/user/domain/domain.dart' show GetUserUseCase;
import 'package:btg_funds_app/features/user/presentation/presentation.dart' show UserState;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_controller.g.dart';

/// Controller that manages [UserState] state for the user feature.
@riverpod
class UserController extends _$UserController {
  late GetUserUseCase _getUserUseCase;

  /// Initializes the controller and loads the user data on mount.
  @override
  Future<UserState> build() async {
    _getUserUseCase = ref.read(getUserUseCaseProvider);
    final user = await _getUserUseCase.execute();
    return UserState(user: user);
  }

  /// Refreshes the user data from the server.
  Future<void> refreshUser() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final user = await _getUserUseCase.execute();
      return UserState(user: user);
    });
  }
}
