import 'package:btg_funds_app/core/core.dart' show Mapper;
import 'package:btg_funds_app/features/funds/data/data.dart' show FundDto;
import 'package:btg_funds_app/features/funds/domain/domain.dart' show FundCategory, FundEntity;

/// Mapper for converting between [FundEntity] (domain layer) and [FundDto] (data layer).
///
/// This mapper is responsible for transforming fund data between the domain and data layers,
/// handling the conversion of fund attributes including category string normalization
/// to enumerated values. It extends [Mapper] to provide bidirectional conversion
/// capabilities for fund entities and their data transfer object representations.
class FundMapper extends Mapper<FundEntity, FundDto> {
  /// Converts a [FundDto] data transfer object into a [FundEntity] domain entity.
  ///
  /// Transforms the data layer [model] representation into a domain entity, normalizing
  /// the category string from the DTO into a [FundCategory] enumeration value.
  /// Returns a [FundEntity] with all fields populated from the provided [model].
  @override
  FundEntity modelToEntity(FundDto model) {
    return FundEntity(
      id: model.id,
      name: model.name,
      minimumAmount: model.minimumAmount,
      category: _mapCategory(model.category),
      isSubscribed: model.isSubscribed,
    );
  }

  /// Converts a [FundEntity] domain entity into a [FundDto] data transfer object.
  ///
  /// Transforms the domain layer [entity] representation into a data layer DTO,
  /// converting the [FundCategory] enumeration value into its string representation
  /// for data persistence or API communication.
  /// Returns a [FundDto] with all fields populated from the provided [entity].
  @override
  FundDto entityToModel(FundEntity entity) {
    return FundDto(
      id: entity.id,
      name: entity.name,
      minimumAmount: entity.minimumAmount,
      category: _mapCategoryToString(entity.category),
      isSubscribed: entity.isSubscribed,
    );
  }

  FundCategory _mapCategory(String category) {
    switch (category.toUpperCase()) {
      case 'FPV':
        return FundCategory.fpv;
      case 'FIC':
        return FundCategory.fic;
      default:
        throw ArgumentError('Unknown fund category: $category');
    }
  }

  String _mapCategoryToString(FundCategory category) {
    switch (category) {
      case FundCategory.fpv:
        return 'FPV';
      case FundCategory.fic:
        return 'FIC';
    }
  }
}
