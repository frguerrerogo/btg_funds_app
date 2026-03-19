import 'package:btg_funds_app/features/user/domain/domain.dart' show UserEntity, UserRepository;

/// Use case that retrieves the current user's profile and account information.
///
/// Depends on [UserRepository] for user data retrieval.
class GetUserUseCase {
  /// Creates a [GetUserUseCase] with [repository].
  const GetUserUseCase(UserRepository repository) : _repository = repository;
  final UserRepository _repository;

  /// Retrieves the current user's profile and account information. Returns a [UserEntity] with their complete account details and subscriptions.
  Future<UserEntity> execute() async {
    return _repository.getUser();
  }
}
