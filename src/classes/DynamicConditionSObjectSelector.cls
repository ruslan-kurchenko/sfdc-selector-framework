public with sharing class DynamicConditionSObjectSelector extends AbstractSelector implements DynamicConditionSelector {

    private String booleanCondition;

    private static final SelectorQueryUtil util = new SelectorQueryUtil();

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
        this.query += ' WHERE ' + this.booleanCondition;

        if(String.isNotBlank(this.orderByFieldsByComa)) {
            this.query += ' ORDER BY ' + this.orderByFieldsByComa + ' ' + this.orderSeq.getValue() + ' ' + this.orderNullValues.getValue();
        }

        System.debug('\n\n Built query: ' + this.query + '\n');
    }


    public DynamicConditionSelector setNumber(Integer expressionIndex, Decimal value) {
        return this.setGenericValue(expressionIndex, String.valueOf(value));
    }

    public DynamicConditionSelector setString(Integer expressionIndex, String value) {
        this.booleanCondition = this.booleanCondition.replace('{' + expressionIndex + '}', util.formatString(value));
        return this;
    }

    public DynamicConditionSelector setId(Integer expressionIndex, Id value) {
        return this.setString(expressionIndex, String.valueOf(value));
    }

    public DynamicConditionSelector setBoolean(Integer expressionIndex, Boolean value) {
        return this.setGenericValue(expressionIndex, String.valueOf(value));
    }

    public DynamicConditionSelector setDate(Integer expressionIndex, Date value) {
        return this.setGenericValue(expressionIndex, String.valueOf(value));
    }

    public DynamicConditionSelector setDatetime(Integer expressionIndex, Datetime value) {
        return this.setGenericValue(expressionIndex, String.valueOf(value));
    }

    public DynamicConditionSelector setTime(Integer expressionIndex, Time value) {
        return this.setGenericValue(expressionIndex, String.valueOf(value));
    }

    private DynamicConditionSelector setGenericValue(Integer expressionIndex, String genericValue) {
        this.booleanCondition = this.booleanCondition.replace('{' + expressionIndex + '}', genericValue);
        return this;
    }


    public DynamicConditionSelector setStringList(Integer expressionIndex, List<String> values) {
        String formatedValues = '(';
        for (String value : values) {
            formatedValues += util.formatString(value) + ',';
        }

        return this.setGenericValue(expressionIndex, formatedValues.removeEnd(',') + ')');
    }

    public DynamicConditionSelector setIdList(Integer expressionIndex, List<Id> values) {
        return this.setStringList(expressionIndex, (List<String>) values);
    }

    public DynamicConditionSelector setIdList(Integer expressionIndex, List<SObject> values) {
        return this.setStringSet(expressionIndex, util.getIds(new Set<SObject>(values)));
    }

    public DynamicConditionSelector setNumberList(Integer expressionIndex, List<Decimal> values) {
        return this.setGenericValue(expressionIndex, util.formatObjectList(values));
    }

    public DynamicConditionSelector setBooleanList(Integer expressionIndex, List<Boolean> values) {
        return this.setGenericValue(expressionIndex, util.formatObjectList(values));
    }

    public DynamicConditionSelector setDateList(Integer expressionIndex, List<Date> values) {
        return this.setGenericValue(expressionIndex, util.formatObjectList(values));
    }

    public DynamicConditionSelector setDatetimeList(Integer expressionIndex, List<Datetime> values) {
        return this.setGenericValue(expressionIndex, util.formatObjectList(values));
    }

    public DynamicConditionSelector setTimeList(Integer expressionIndex, List<Time> values) {
        return this.setGenericValue(expressionIndex, util.formatObjectList(values));
    }


    public DynamicConditionSelector setStringSet(Integer expressionIndex, Set<String> values) {
        return this.setStringList(expressionIndex, new List<String>(values));
    }

    public DynamicConditionSelector setIdSet(Integer expressionIndex, Set<Id> values) {
        return this.setStringList(expressionIndex, (List<String>) new List<Id>(values));
    }

    public DynamicConditionSelector setIdSet(Integer expressionIndex, Set<SObject> values) {
        return this.setStringSet(expressionIndex, util.getIds(values));
    }

    public DynamicConditionSelector setNumberSet(Integer expressionIndex, Set<Decimal> values) {
        return this.setNumberList(expressionIndex, new List<Decimal>(values));
    }

    public DynamicConditionSelector setBooleanSet(Integer expressionIndex, Set<Boolean> values) {
        return this.setBooleanList(expressionIndex, new List<Boolean>(values));
    }

    public DynamicConditionSelector setDateSet(Integer expressionIndex, Set<Date> values) {
        return this.setDateList(expressionIndex, new List<Date>(values));
    }

    public DynamicConditionSelector setDatetimeSet(Integer expressionIndex, Set<Datetime> values) {
        return this.setDatetimeList(expressionIndex, new List<Datetime>(values));
    }

    public DynamicConditionSelector setTimeSet(Integer expressionIndex, Set<Time> values) {
        return this.setTimeList(expressionIndex, new List<Time>(values));
    }

}