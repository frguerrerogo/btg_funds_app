import 'package:btg_funds_app/features/user/domain/entities/user_entity.dart';
import 'package:btg_funds_app/features/user/domain/repositories/user_repository.dart';

/// Use case that retrieves the current user's profile and account information.
///
/// Encapsulates the business logic for fetching the authenticated user's details,
/// including balance and fund subscriptions. It delegates data access to the
/// injected repository.
class GetUserUseCase {
  /// Creates an instance of [GetUserUseCase].
  ///
  /// Requires a [_repository] implementation to fetch the current user profile.
  const GetUserUseCase(this._repository);

  final UserRepository _repository;

  /// Retrieves the current user's profile and account information.
  ///
  /// Fetches the authenticated user from the repository, returning a [UserEntity]
  /// with their complete profile including balance and subscribed funds.
  Future<UserEntity> execute() async {
    return _repository.getUser();
  }
}
