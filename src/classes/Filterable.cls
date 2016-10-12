public interface Filterable {

    Selector filter(String field, Operator operator, String value);

    Selector filter(String field, Operator operator, Id value);

    Selector filter(String field, Operator operator, Boolean value);

    Selector filter(String field, Operator operator, Date value);

    Selector filter(String field, Operator operator, Datetime value);

    Selector filter(String field, Operator operator, Integer value);

    Selector filter(String field, Operator operator, Decimal value);

    Selector filter(String field, Operator operator, Double value);

    Selector filter(String field, Operator operator, Long value);

    Selector filter(String field, Operator operator, Time value);

    Selector filter(String field, Operator operator, List<String> value);

    Selector filter(String field, Operator operator, List<Id> value);

    Selector filter(String field, Operator operator, List<Boolean> value);

    Selector filter(String field, Operator operator, List<Date> value);

    Selector filter(String field, Operator operator, List<Datetime> value);

    Selector filter(String field, Operator operator, List<Integer> value);

    Selector filter(String field, Operator operator, List<Decimal> value);

    Selector filter(String field, Operator operator, List<Double> value);

    Selector filter(String field, Operator operator, List<Long> value);

    Selector filter(String field, Operator operator, List<Time> value);

    Selector filter(String field, Operator operator, List<SObject> value);

    Selector filter(String field, Operator operator, Set<String> value);

    Selector filter(String field, Operator operator, Set<Id> value);

    Selector filter(String field, Operator operator, Set<Boolean> value);

    Selector filter(String field, Operator operator, Set<Date> value);

    Selector filter(String field, Operator operator, Set<Datetime> value);

    Selector filter(String field, Operator operator, Set<Integer> value);

    Selector filter(String field, Operator operator, Set<Decimal> value);

    Selector filter(String field, Operator operator, Set<Double> value);

    Selector filter(String field, Operator operator, Set<Long> value);

    Selector filter(String field, Operator operator, Set<Time> value);

    Selector filter(String field, Operator operator, Set<SObject> value);

}