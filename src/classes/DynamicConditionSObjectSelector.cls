public with sharing class DynamicConditionSObjectSelector extends AbstractSelector {

    private String booleanCondition;

    public DynamicConditionSObjectSelector(Schema.DescribeSObjectResult sobjectDescribe, FieldsContainer fieldsContainer, String condition) {
        super(sobjectDescribe, fieldsContainer);
        this.booleanCondition = condition;
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

        // TODO: pilot implementation
        this.query += ' ' + this.booleanCondition;

        if(String.isNotBlank(this.orderByFieldsByComa)) {
            this.query += ' ORDER BY ' + this.orderByFieldsByComa + ' ' + this.orderSeq.getValue() + ' ' + this.orderNullValues.getValue();
        }
    }

}