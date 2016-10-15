public interface Orderable {

    Selector orderBy(String fieldsByComa);

    Selector orderBy(String fieldsByComa, OrderSequence sequence);

    Selector orderBy(String fieldsByComa, OrderNulls oderNullValues);

    Selector orderBy(String fieldsByComa, OrderSequence sequence, OrderNulls oderNullValues);

}