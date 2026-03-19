import 'package:btg_funds_app/core/core.dart' show getUserUseCaseProvider;
import 'package:btg_funds_app/features/user/domain/domain.dart' show GetUserUseCase, UserEntity;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_controller.g.dart';

/// Controller that manages [UserEntity] state for the user feature.
@riverpod
class UserController extends _$UserController {
  late GetUserUseCase _getUserUseCase;

  /// Initializes the controller and loads the user data on mount.
  @override
  Future<UserEntity> build() async {
    _getUserUseCase = ref.read(getUserUseCaseProvider);
    return _getUserUseCase.execute();
  }

  /// Refreshes the user data from the server.
  Future<void> refreshUser() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _getUserUseCase.execute());
  }
}
