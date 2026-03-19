import 'package:btg_funds_app/core/core.dart' show Mapper;
import 'package:btg_funds_app/features/user/data/data.dart' show ActiveSubscriptionMapper, UserDto;
import 'package:btg_funds_app/features/user/domain/domain.dart' show UserEntity;

/// Mapper that converts between [UserEntity] and [UserDto]. Handles nested active subscriptions conversion.
class UserMapper extends Mapper<UserEntity, UserDto> {
  /// Creates a new [UserMapper] instance with the provided [activeSubscriptionMapper].
  UserMapper({
    required this.activeSubscriptionMapper,
  });

  /// The mapper used to convert active subscriptions between layers.
  final ActiveSubscriptionMapper activeSubscriptionMapper;

  /// Converts a [UserEntity] from domain into a [UserDto].
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

  /// Converts a [UserDto] from data into a [UserEntity].
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
