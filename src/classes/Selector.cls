public interface Selector extends Filterable {

    List<SObject> get();

    SObject whereId(Id id);

    List<SObject> whereId(Set<Id> ids);

    List<SObject> whereId(List<Id> ids);

    List<SObject> whereId(List<SObject> records);

    List<SObject> whereId(Set<SObject> records);

    Selector fields(String fieldsByComa);

    Selector parent(String parentFieldPath);

    Selector parent(String parentFieldPath, String fieldsByComa);

    Selector parent(String parentFieldPath, FieldsContainer fieldsContainer);

}