import 'package:btg_funds_app/core/core.dart' show Mapper;
import 'package:btg_funds_app/features/user/data/data.dart' show ActiveSubscriptionDto;
import 'package:btg_funds_app/features/user/domain/domain.dart' show ActiveSubscriptionEntity;

/// Maps between [ActiveSubscriptionEntity] and [ActiveSubscriptionDto].
///
/// This mapper is responsible for converting active subscription domain entities
/// to data transfer objects for API serialization, handling the conversion of
/// DateTime objects to ISO 8601 strings and vice versa.
class ActiveSubscriptionMapper extends Mapper<ActiveSubscriptionEntity, ActiveSubscriptionDto> {
  /// Converts an [ActiveSubscriptionEntity] to an [ActiveSubscriptionDto].
  ///
  /// Maps the subscription's domain representation to a data transfer object suitable
  /// for API communication, converting the DateTime `subscribedAt` to an ISO 8601 string
  /// format. Returns an [ActiveSubscriptionDto] populated with data from [entity].
  @override
  ActiveSubscriptionDto entityToModel(ActiveSubscriptionEntity entity) {
    return ActiveSubscriptionDto(
      fundId: entity.fundId,
      fundName: entity.fundName,
      amount: entity.amount,
      subscribedAt: entity.subscribedAt.toIso8601String(),
    );
  }

  /// Converts an [ActiveSubscriptionDto] to an [ActiveSubscriptionEntity].
  ///
  /// Maps the subscription's data transfer object to a domain entity for use throughout
  /// the application's business logic, parsing the `subscribedAt` ISO 8601 string to
  /// a DateTime object. Returns an [ActiveSubscriptionEntity] populated with data from [model].
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
