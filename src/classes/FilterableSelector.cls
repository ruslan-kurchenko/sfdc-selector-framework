public interface FilterableSelector extends Selector {

    FilterableSelector filter(String field, Operator operator, String value);

    FilterableSelector filter(String field, Operator operator, Boolean value);

    FilterableSelector filter(String field, Operator operator, Date value);

    FilterableSelector filter(String field, Operator operator, Datetime value);

    FilterableSelector filter(String field, Operator operator, Decimal value);

    FilterableSelector filter(String field, Operator operator, Time value);


    FilterableSelector filter(String field, Operator operator, List<String> value);

    FilterableSelector filter(String field, Operator operator, List<Id> value);

    FilterableSelector filter(String field, Operator operator, List<Boolean> value);

    FilterableSelector filter(String field, Operator operator, List<Date> value);

    FilterableSelector filter(String field, Operator operator, List<Datetime> value);

    FilterableSelector filter(String field, Operator operator, List<Decimal> value);

    FilterableSelector filter(String field, Operator operator, List<Time> value);

    FilterableSelector filter(String field, Operator operator, List<SObject> value);


    FilterableSelector filter(String field, Operator operator, Set<String> value);

    FilterableSelector filter(String field, Operator operator, Set<Id> value);

    FilterableSelector filter(String field, Operator operator, Set<Boolean> value);

    FilterableSelector filter(String field, Operator operator, Set<Date> value);

    FilterableSelector filter(String field, Operator operator, Set<Datetime> value);

    FilterableSelector filter(String field, Operator operator, Set<Decimal> value);

    FilterableSelector filter(String field, Operator operator, Set<Time> value);

    FilterableSelector filter(String field, Operator operator, Set<SObject> value);


    FilterableSelector filter(String field, Operator operator);
}