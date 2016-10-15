public with sharing class SObjectSelector extends AbstractSelector implements Filterable {

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

    public List<SObject> whereId(Set<Id> ids) {
        this.filter('Id', Operator.IS_IN, ids);
        return this.get();
    }

    public List<SObject> whereId(List<Id> ids) {
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


    public DynamicConditionSObjectSelector query() {
        return null;
    }


    private class DynamicConditionSObjectSelector extends AbstractSelector {

        public DynamicConditionSObjectSelector(Schema.DescribeSObjectResult sobjectDescribe, FieldsContainer fieldsContainer) {
            super(sobjectDescribe, fieldsContainer);
        }

        public DynamicConditionSObjectSelector(Schema.DescribeSObjectResult sobjectDescribe) {
            this(sobjectDescribe, new FieldsContainer(sobjectDescribe));
        }

        public DynamicConditionSObjectSelector(String sobjectName) {
            super(sobjectName);
        }

        private void buildQuery() {

        }

    }

}