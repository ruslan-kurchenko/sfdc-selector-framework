public interface Selector extends Orderable {

    List<SObject> get();

    Selector fields(String fieldsByComa);

    Selector parent(String parentFieldPath);

    Selector parent(String parentFieldPath, String fieldsByComa);

    Selector parent(String parentFieldPath, FieldsContainer fieldsContainer);

    Selector orderBy(String fieldsByComa);

    Selector orderBy(String fieldsByComa, OrderSequence sequence);

    Selector orderBy(String fieldsByComa, OrderNulls oderNullValues);

    Selector orderBy(String fieldsByComa, OrderSequence sequence, OrderNulls oderNullValues);

}