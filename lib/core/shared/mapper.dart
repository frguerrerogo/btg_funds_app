/// Abstract mapper for converting between domain entities and data models.
///
/// Provides a reusable generic pattern for bidirectional conversion between the domain
/// layer and data layer. Mappers implementing this contract are responsible for bridging
/// the gap between domain entities ([Entity]) used throughout the application and data
/// transfer objects ([Model]) used for API communication and persistence.
///
/// This abstract class defines two required conversion methods that subclasses must
/// implement, and provides helper methods for batch converting lists of entities and models.
///
/// Type parameters:
/// - [Entity]: The domain entity type that represents the domain layer model
/// - [Model]: The data model or DTO type that represents the data layer model
///
/// Example:
/// ```dart
/// class UserMapper extends Mapper<UserEntity, UserDto> {
///   @override
///   UserDto entityToModel(UserEntity entity) => UserDto(
///     id: entity.id,
///     name: entity.name,
///     email: entity.email,
///   );
///
///   @override
///   UserEntity modelToEntity(UserDto model) => UserEntity(
///     id: model.id,
///     name: model.name,
///     email: model.email,
///   );
/// }
///
/// // Use the mapper
/// final mapper = UserMapper();
/// final dto = mapper.entityToModel(userEntity);
/// final dtos = mapper.entitiesToModels([entity1, entity2]);
/// ```
abstract class Mapper<Entity, Model> {
  /// Converts a domain [Entity] into a data [Model].
  ///
  /// Transforms the domain entity representation into a data model suitable for
  /// API communication or database persistence. Subclasses must override this method
  /// to provide the specific conversion logic for their entity and model types.
  /// Returns a [Model] containing the mapped data from [entity].
  Model entityToModel(Entity entity);

  /// Converts a data [Model] into a domain [Entity].
  ///
  /// Transforms the data model representation into a domain entity for use throughout
  /// the application's business logic. Subclasses must override this method to provide
  /// the specific conversion logic for their model and entity types.
  /// Returns an [Entity] containing the mapped data from [model].
  Entity modelToEntity(Model model);

  /// Converts a list of domain [Entity] objects into a list of data [Model] objects.
  ///
  /// Applies [entityToModel] to each element in the provided [entities] list,
  /// returning a new list of models. This helper method simplifies batch conversions
  /// from domain to data layer without requiring manual iteration.
  /// Returns a list of [Model] objects converted from [entities].
  List<Model> entitiesToModels(List<Entity> entities) {
    return entities.map(entityToModel).toList();
  }

  /// Converts a list of data [Model] objects into a list of domain [Entity] objects.
  ///
  /// Applies [modelToEntity] to each element in the provided [models] list,
  /// returning a new list of entities. This helper method simplifies batch conversions
  /// from data to domain layer without requiring manual iteration.
  /// Returns a list of [Entity] objects converted from [models].
  List<Entity> modelsToEntities(List<Model> models) {
    return models.map(modelToEntity).toList();
  }
}
