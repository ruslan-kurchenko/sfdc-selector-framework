public with sharing class SObjectSelector extends AbstractSelector implements FilterableSelector {

    public SObjectSelector(Schema.DescribeSObjectResult sobjectDescribe, FieldsContainer fieldsContainer) {
        super(sobjectDescribe, fieldsContainer);
    }

    public SObjectSelector(Schema.DescribeSObjectResult sobjectDescribe) {
        this(sobjectDescribe, new FieldsContainer(sobjectDescribe));
    }

    public SObjectSelector(String sobjectName) {
        super(sobjectName);
    }


    private void buildQuery() {
        this.query = 'SELECT ';
        if (String.isNotBlank(this.excludedFieldsByComa)) {
            FieldsContainer allFieldsContainer = new FieldsContainer(this.sobjectDescribe);
            allFieldsContainer.filter(this.fieldsContainer);
            this.query += allFieldsContainer.join(',');
        } else {
            this.query += this.fieldsContainer.join(',');
        }

        this.query += ' FROM ' + this.sobjectDescribe.getName();

        Boolean conditionStarted = false;
        for (Filter filter : this.filters) {
            this.query += !conditionStarted ? ' WHERE ' : ' AND ';
            this.query += filter.getCondition();
            conditionStarted = true;
        }

        if(String.isNotBlank(this.orderByFieldsByComa)) {
            this.query += ' ORDER BY ' + this.orderByFieldsByComa + ' ' + this.orderSeq.getValue() + ' ' + this.orderNullValues.getValue();
        }
    }


    public SObject whereId(Id id) {
        this.filter('Id', Operator.EQUALS, id);
        List<SObject> selectResult = this.get();
        return selectResult.isEmpty() ? null : selectResult.get(0);
    }

    public List<SObject> whereId(Set<String> ids) {
        this.filter('Id', Operator.IS_IN, ids);
        return this.get();
    }

    public List<SObject> whereId(List<String> ids) {
        this.filter('Id', Operator.IS_IN, ids);
        return this.get();
    }

    public List<SObject> whereId(List<SObject> records) {
        this.filter('Id', Operator.IS_IN, records);
        return this.get();
    }

    public List<SObject> whereId(Set<SObject> records) {
        this.filter('Id', Operator.IS_IN, records);
        return this.get();
    }


    public FilterableSelector filter(String field, Operator operator, String value) {
        this.filters.add(new Filter(field, operator, value));
        return this;
    }

    public FilterableSelector filter(String field, Operator operator, Boolean value) {
        this.filters.add(new Filter(field, operator, value));
        return this;
    }

    public FilterableSelector filter(String field, Operator operator, Id value) {
        this.filters.add(new Filter(field, operator, value));
        return this;
    }

    public FilterableSelector filter(String field, Operator operator, Date value) {
        this.filters.add(new Filter(field, operator, value));
        return this;
    }

    public FilterableSelector filter(String field, Operator operator, Datetime value) {
        this.filters.add(new Filter(field, operator, value));
        return this;
    }

    public FilterableSelector filter(String field, Operator operator, Decimal value) {
        this.filters.add(new Filter(field, operator, value));
        return this;
    }

    public FilterableSelector filter(String field, Operator operator, Time value) {
        this.filters.add(new Filter(field, operator, value));
        return this;
    }


    public FilterableSelector filter(String field, Operator operator, List<String> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public FilterableSelector filter(String field, Operator operator, List<Id> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public FilterableSelector filter(String field, Operator operator, List<Boolean> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public FilterableSelector filter(String field, Operator operator, List<Date> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public FilterableSelector filter(String field, Operator operator, List<Datetime> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public FilterableSelector filter(String field, Operator operator, List<Decimal> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public FilterableSelector filter(String field, Operator operator, List<Time> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }


    public FilterableSelector filter(String field, Operator operator, Set<String> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public FilterableSelector filter(String field, Operator operator, Set<Id> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public FilterableSelector filter(String field, Operator operator, Set<Boolean> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public FilterableSelector filter(String field, Operator operator, Set<Date> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public FilterableSelector filter(String field, Operator operator, Set<Datetime> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public FilterableSelector filter(String field, Operator operator, Set<Decimal> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public FilterableSelector filter(String field, Operator operator, Set<Time> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }


    public FilterableSelector filter(String field, Operator operator, List<SObject> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public FilterableSelector filter(String field, Operator operator, Set<SObject> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }


    public FilterableSelector filter(String field, Operator operator) {
        this.filters.add(new Filter(field, operator));
        return this;
    }


    public DynamicConditionSObjectSelector condition(String booleanCondition) {
        return new DynamicConditionSObjectSelector(this.sobjectDescribe, this.fieldsContainer, booleanCondition);
    }

}