import 'package:btg_funds_app/core/core.dart' show Mapper;
import 'package:btg_funds_app/features/funds/data/data.dart' show FundDto;
import 'package:btg_funds_app/features/funds/domain/domain.dart' show FundCategory, FundEntity;

/// Mapper that converts between [FundEntity] and [FundDto]. Handles category value mapping.
class FundMapper extends Mapper<FundEntity, FundDto> {
  /// Converts a [FundDto] from the data layer into a [FundEntity].
  /// Returns a [FundEntity] populated with data from [model].
  @override
  FundEntity modelToEntity(FundDto model) {
    return FundEntity(
      id: model.id,
      name: model.name,
      minimumAmount: model.minimumAmount,
      category: _mapCategory(model.category),
    );
  }

  /// Converts a [FundEntity] from the domain layer into a [FundDto].
  /// Returns a [FundDto] populated with data from [entity].
  @override
  FundDto entityToModel(FundEntity entity) {
    return FundDto(
      id: entity.id,
      name: entity.name,
      minimumAmount: entity.minimumAmount,
      category: _mapCategoryToString(entity.category),
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
