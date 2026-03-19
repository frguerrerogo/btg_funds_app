/// Abstract base class for mapping between domain entities and data models.
///
/// [Entity] represents the domain layer type and [Model] represents
/// the data layer type (e.g., a DTO). Subclasses must implement
/// [entityToModel] and [modelToEntity] to define the conversion logic.
abstract class Mapper<Entity, Model> {
  /// Converts a single [entity] from the domain layer into a data [Model].
  Model entityToModel(Entity entity);

  /// Converts a single [model] from the data layer into a domain [Entity].
  Entity modelToEntity(Model model);

  /// Converts a list of [entities] into a list of data models.
  ///
  /// Delegates each conversion to [entityToModel] and returns
  /// the resulting list of [Model] instances.
  List<Model> entitiesToModels(List<Entity> entities) {
    return entities.map(entityToModel).toList();
  }

  /// Converts a list of [models] into a list of domain entities.
  ///
  /// Delegates each conversion to [modelToEntity] and returns
  /// the resulting list of [Entity] instances.
  List<Entity> modelsToEntities(List<Model> models) {
    return models.map(modelToEntity).toList();
  }
}
