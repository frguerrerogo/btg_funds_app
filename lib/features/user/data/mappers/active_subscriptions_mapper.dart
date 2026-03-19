import 'package:btg_funds_app/core/core.dart' show Mapper;
import 'package:btg_funds_app/features/user/data/data.dart' show ActiveSubscriptionDto;
import 'package:btg_funds_app/features/user/domain/domain.dart' show ActiveSubscriptionEntity;

/// Mapper that converts between [ActiveSubscriptionEntity] and [ActiveSubscriptionDto].
class ActiveSubscriptionMapper extends Mapper<ActiveSubscriptionEntity, ActiveSubscriptionDto> {
  /// Converts an [ActiveSubscriptionEntity] from domain into an [ActiveSubscriptionDto].
  /// Returns an [ActiveSubscriptionDto] populated with data from [entity].
  @override
  ActiveSubscriptionDto entityToModel(ActiveSubscriptionEntity entity) {
    return ActiveSubscriptionDto(
      fundId: entity.fundId,
      fundName: entity.fundName,
      amount: entity.amount,
      subscribedAt: entity.subscribedAt.toIso8601String(),
    );
  }

  /// Converts an [ActiveSubscriptionDto] from data into an [ActiveSubscriptionEntity].
  /// Returns an [ActiveSubscriptionEntity] populated with data from [model].
  @override
  ActiveSubscriptionEntity modelToEntity(ActiveSubscriptionDto model) {
    return ActiveSubscriptionEntity(
      fundId: model.fundId,
      fundName: model.fundName,
      amount: model.amount,
      subscribedAt: DateTime.parse(model.subscribedAt),
    );
  }
}
