public interface Selector {

    List<SObject> get();

    SObject whereId(Id id);

    List<SObject> whereId(Set<Id> ids);

    List<SObject> whereId(List<Id> ids);

    List<SObject> whereId(List<SObject> records);

    List<SObject> whereId(Set<SObject> records);

    Selector filter(String field, Operator operator, String value);

    Selector filter(String field, Operator operator, Id value);

    Selector filter(String field, Operator operator, Integer value);
}