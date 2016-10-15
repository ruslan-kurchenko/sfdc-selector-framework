public interface Selector extends Orderable {

    List<SObject> get();

    Selector fields(String fieldsByComa);

    Selector parent(String parentFieldPath);

    Selector parent(String parentFieldPath, String fieldsByComa);

    Selector parent(String parentFieldPath, FieldsContainer fieldsContainer);

}