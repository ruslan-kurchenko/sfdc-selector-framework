public with sharing class OpportunitySelector implements Selector {

    private final static Schema.DescribeSObjectResult SOBJECT_DESCRIBE = Schema.SObjectType.Opportunity;
    private final Selector abstractSelector;

    public OpportunitySelector(FieldsContainer fieldsContainer) {
        this.abstractSelector = new AbstractSelector(SOBJECT_DESCRIBE, fieldsContainer);
        System.debug('\n\n abstractSelector => ' + abstractSelector + '\n');
    }

    public OpportunitySelector() {
        this(new FieldsContainer(SOBJECT_DESCRIBE));
    }

    public List<Opportunity> get() {
        return (List<Opportunity>) this.abstractSelector.get();
    }

    public Opportunity whereId(Id id) {
        return (Opportunity) this.abstractSelector.whereId(id);
    }

    public List<Opportunity> whereId(Set<Id> ids) {
        return (List<Opportunity>) this.abstractSelector.whereId(ids);
    }

    public List<Opportunity> whereId(List<Id> ids) {
        return (List<Opportunity>) this.abstractSelector.whereId(ids);
    }

    public List<Opportunity> whereId(List<SObject> records) {
        return (List<Opportunity>) this.abstractSelector.whereId(records);
    }

    public List<Opportunity> whereId(Set<SObject> records) {
        return (List<Opportunity>) this.abstractSelector.whereId(records);
    }

    public Selector filter(String field, Operator operator, String value) {
        return this.abstractSelector.filter(field, operator, value);
    }


    public Selector filter(String field, Operator operator, Id value) {
        return this.abstractSelector.filter(field, operator, value);
    }

    public Selector filter(String field, Operator operator, Integer value) {
        return this.abstractSelector.filter(field, operator, value);
    }


    public Selector filter(String field, Operator operator, Boolean value) {
        return this.abstractSelector.filter(field, operator, value);
    }

    public Selector filter(String field, Operator operator, Date value) {
        return this.abstractSelector.filter(field, operator, value);
    }

    public Selector filter(String field, Operator operator, Datetime value) {
        return this.abstractSelector.filter(field, operator, value);
    }

    public Selector filter(String field, Operator operator, Decimal value) {
        return this.abstractSelector.filter(field, operator, value);
    }

    public Selector filter(String field, Operator operator, Double value) {
        return this.abstractSelector.filter(field, operator, value);
    }

    public Selector filter(String field, Operator operator, Long value) {
        return this.abstractSelector.filter(field, operator, value);
    }

    public Selector filter(String field, Operator operator, Time value) {
        return this.abstractSelector.filter(field, operator, value);
    }

    public Selector filter(String field, Operator operator, List<String> values) {
        return this.abstractSelector.filter(field, operator, values);
    }

    public Selector filter(String field, Operator operator, List<Id> values) {
        return this.abstractSelector.filter(field, operator, values);
    }

    public Selector filter(String field, Operator operator, List<Boolean> values) {
        return this.abstractSelector.filter(field, operator, values);
    }

    public Selector filter(String field, Operator operator, List<Date> values) {
        return this.abstractSelector.filter(field, operator, values);
    }

    public Selector filter(String field, Operator operator, List<Datetime> values) {
        return this.abstractSelector.filter(field, operator, values);
    }

    public Selector filter(String field, Operator operator, List<Decimal> values) {
        return this.abstractSelector.filter(field, operator, values);
    }

    public Selector filter(String field, Operator operator, List<Double> values) {
        return this.abstractSelector.filter(field, operator, values);
    }

    public Selector filter(String field, Operator operator, List<Integer> values) {
        return this.abstractSelector.filter(field, operator, values);
    }

    public Selector filter(String field, Operator operator, List<Long> values) {
        return this.abstractSelector.filter(field, operator, values);
    }

    public Selector filter(String field, Operator operator, List<Time> values) {
        return this.abstractSelector.filter(field, operator, values);
    }

    public Selector filter(String field, Operator operator, Set<String> values) {
        return this.abstractSelector.filter(field, operator, values);
    }

    public Selector filter(String field, Operator operator, Set<Id> values) {
        return this.abstractSelector.filter(field, operator, values);
    }

    public Selector filter(String field, Operator operator, Set<Boolean> values) {
        return this.abstractSelector.filter(field, operator, values);
    }

    public Selector filter(String field, Operator operator, Set<Date> values) {
        return this.abstractSelector.filter(field, operator, values);
    }

    public Selector filter(String field, Operator operator, Set<Datetime> values) {
        return this.abstractSelector.filter(field, operator, values);
    }

    public Selector filter(String field, Operator operator, Set<Decimal> values) {
        return this.abstractSelector.filter(field, operator, values);
    }

    public Selector filter(String field, Operator operator, Set<Double> values) {
        return this.abstractSelector.filter(field, operator, values);
    }

    public Selector filter(String field, Operator operator, Set<Integer> values) {
        return this.abstractSelector.filter(field, operator, values);
    }

    public Selector filter(String field, Operator operator, Set<Long> values) {
        return this.abstractSelector.filter(field, operator, values);
    }

    public Selector filter(String field, Operator operator, Set<Time> values) {
        return this.abstractSelector.filter(field, operator, values);
    }

    public Selector filter(String field, Operator operator, List<SObject> values) {
        return this.abstractSelector.filter(field, operator, values);
    }

    public Selector filter(String field, Operator operator, Set<SObject> values) {
        return this.abstractSelector.filter(field, operator, values);
    }


}