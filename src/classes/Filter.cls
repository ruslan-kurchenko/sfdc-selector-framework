public with sharing class Filter {

    private String field;
    private Operator oper;
    private Object value;

    private final static SelectorQueryUtil util = new SelectorQueryUtil();

    private Filter(String field, Operator operator, Object value) {
        this.field = field;
        this.oper = operator;
        this.value = value;
    }

    public Filter(String field, Operator operator, String value) {
        this(field, operator, (Object) util.formatString(value));
    }

    public Filter(String field, Operator operator, Id value) {
        this(field, operator, (Object) util.formatString(String.valueOf(value)));
    }

    public Filter(String field, Operator operator, Boolean value) {
        this(field, operator, (Object) value);
    }

    public Filter(String field, Operator operator, Date value) {
        this(field, operator, (Object) value);
    }

    public Filter(String field, Operator operator, Datetime value) {
        this(field, operator, (Object) value);
    }

    public Filter(String field, Operator operator, Decimal value) {
        this(field, operator, (Object) value);
    }

    public Filter(String field, Operator operator, Time value) {
        this(field, operator, (Object) value);
    }


    public Filter(String field, Operator operator, List<String> values) {
        this(field, operator);

        String formatedValues = '(';
        for (String value : values) {
            formatedValues += util.formatString(value) + ',';
        }
        this.value = formatedValues.removeEnd(',') + ')';
    }

    public Filter(String field, Operator operator, List<Id> values) {
        this(field, operator, (List<String>) values);
    }

    public Filter(String field, Operator operator, List<Boolean> values) {
        this(field, operator, util.formatObjectList(values));
    }

    public Filter(String field, Operator operator, List<Date> values) {
        this(field, operator, util.formatObjectList(values));
    }

    public Filter(String field, Operator operator, List<Datetime> values) {
        this(field, operator, util.formatObjectList(values));
    }

    public Filter(String field, Operator operator, List<Decimal> values) {
        this(field, operator, util.formatObjectList(values));
    }

    public Filter(String field, Operator operator, List<Time> values) {
        this(field, operator, util.formatObjectList(values));
    }


    public Filter(String field, Operator operator, Set<String> values) {
        this(field, operator, new List<String>(values));
    }

    public Filter(String field, Operator operator, Set<Id> values) {
        this(field, operator, new List<Id>(values));
    }

    public Filter(String field, Operator operator, Set<Boolean> values) {
        this(field, operator, new List<Boolean>(values));
    }

    public Filter(String field, Operator operator, Set<Date> values) {
        this(field, operator, new List<Date>(values));
    }

    public Filter(String field, Operator operator, Set<Datetime> values) {
        this(field, operator, new List<Datetime>(values));
    }

    public Filter(String field, Operator operator, Set<Decimal> values) {
        this(field, operator, new List<Decimal>(values));
    }

    public Filter(String field, Operator operator, Set<Time> values) {
        this(field, operator, new List<Time>(values));
    }


    public Filter(String field, Operator operator, List<SObject> values) {
        this(field, operator, util.getIds(new Set<SObject>(values)));
    }

    public Filter(String field, Operator operator, Set<SObject> values) {
        this(field, operator, util.getIds(values));
    }

    public Filter(String field, Operator nullCondition) {
        if (nullCondition != Operator.IS_NULL || nullCondition != Operator.IS_NOT_NULL) {
            // TODO: thow uncompatible Operator exception.
        }

        List<String> conditionParts = nullCondition.getValue().split(' ');
        String operatorValue = conditionParts.get(0);
        this.field = field;
        this.oper = operatorValue == Operator.EQUALS.getValue() ? Operator.EQUALS : Operator.NOT_EQUALS;
        this.value = conditionParts.get(1);
    }


    public String getCondition() {
        return this.field + this.oper.getValue() + this.value;
    }

}