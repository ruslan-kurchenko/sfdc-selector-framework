public with sharing class OpportunitySelector implements Selector {

    private final static Schema.DescribeSObjectResult SOBJECT_DESCRIBE = Schema.SObjectType.Opportunity;
    private final Selector abstractSelector;

    public OpportunitySelector(FieldsContainer fieldsContainer, Boolean excludeField) {
        this.abstractSelector = new AbstractSelector(SOBJECT_DESCRIBE, fieldsContainer, excludeField);
    }

    public OpportunitySelector(FieldsContainer fieldsContainer) {
        this(fieldsContainer, false);
    }

    public OpportunitySelector() {
        this(new FieldsContainer(SOBJECT_DESCRIBE), false);
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

}