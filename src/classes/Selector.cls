public interface Selector extends Filterable {

    List<SObject> get();

    SObject whereId(Id id);

    List<SObject> whereId(Set<Id> ids);

    List<SObject> whereId(List<Id> ids);

    List<SObject> whereId(List<SObject> records);

    List<SObject> whereId(Set<SObject> records);

}