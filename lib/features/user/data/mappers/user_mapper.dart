import 'package:btg_funds_app/core/core.dart' show Mapper;
import 'package:btg_funds_app/features/user/data/data.dart' show ActiveSubscriptionMapper, UserDto;
import 'package:btg_funds_app/features/user/domain/domain.dart' show UserEntity;

/// Maps between [UserEntity] and [UserDto].
///
/// This mapper is responsible for converting user domain entities to data transfer
/// objects for API serialization, and vice versa. It delegates subscription mapping
/// to the injected [activeSubscriptionMapper] to handle the conversion of the nested
/// active subscriptions list.
class UserMapper extends Mapper<UserEntity, UserDto> {
  /// Creates a new [UserMapper] instance.
  ///
  /// The [activeSubscriptionMapper] is required for converting the user's active
  /// subscriptions between domain and data layer representations.
  UserMapper({
    required this.activeSubscriptionMapper,
  });

  /// The mapper used to convert active subscriptions between layers.
  final ActiveSubscriptionMapper activeSubscriptionMapper;

  /// Converts a [UserEntity] to a [UserDto].
  ///
  /// Maps the user's domain representation to a data transfer object suitable for
  /// API communication. Delegates subscription mapping to [activeSubscriptionMapper]
  /// to convert the activeSubscriptions list from domain to data format.
  /// Returns a [UserDto] populated with data from [entity].
  @override
  UserDto entityToModel(UserEntity entity) {
    return UserDto(
      id: entity.id,
      name: entity.name,
      balance: entity.balance,
      activeSubscriptions: activeSubscriptionMapper.entitiesToModels(entity.activeSubscriptions),
    );
  }

  /// Converts a [UserDto] to a [UserEntity].
  ///
  /// Maps the user's data transfer object to a domain entity for use throughout the
  /// application's business logic. Delegates subscription mapping to [activeSubscriptionMapper]
  /// to convert the activeSubscriptions list from data to domain format.
  /// Returns a [UserEntity] populated with data from [model].
  @override
  UserEntity modelToEntity(UserDto model) {
    return UserEntity(
      id: model.id,
      name: model.name,
      balance: model.balance,
      activeSubscriptions: activeSubscriptionMapper.modelsToEntities(model.activeSubscriptions),
    );
  }
}
