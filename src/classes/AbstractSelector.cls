public with sharing abstract class AbstractSelector implements Selector {

    protected Schema.DescribeSObjectResult sobjectDescribe;
    protected FieldsContainer fieldsContainer;
    protected  Boolean isCustomFieldContainer;

    //TODO: implement exculde fields functionality
    protected String excludedFieldsByComa;
    protected List<Filter> filters;

    protected String orderByFieldsByComa;
    protected  OrderSequence orderSeq;
    protected  OrderNulls orderNullValues;

    protected String query;
    private String lastQuery;

    private static final Map<String, Schema.SObjectType> GLOBAL_DESCRIBE = Schema.getGlobalDescribe();

    private static final OrderSequence DEFAULT_ORDER_SEQUENCE = OrderSequence.ASCENDING;
    private static final OrderNulls DEFAULT_ORDER_NULLS = OrderNulls.FIRST;


    public AbstractSelector(Schema.DescribeSObjectResult sobjectDescribe, FieldsContainer fieldsContainer) {
        this.sobjectDescribe = sobjectDescribe;
        this.fieldsContainer = fieldsContainer;
        this.isCustomFieldContainer = false;
        this.refresh();
    }

    public AbstractSelector(Schema.DescribeSObjectResult sobjectDescribe) {
        this(sobjectDescribe, new FieldsContainer(sobjectDescribe));
    }

    public AbstractSelector(String sobjectName) {
        Schema.DescribeSObjectResult sobjectDescribe = GLOBAL_DESCRIBE.get(sobjectName).getDescribe();
        if (sobjectDescribe == null) {
            // TODO: throw exception - IncompatibleSObjectType
        }
        this.sobjectDescribe = sobjectDescribe;
        this.fieldsContainer = new FieldsContainer(sobjectDescribe);
        this.isCustomFieldContainer = false;
        this.refresh();
    }


    public List<SObject> get() {
        this.buildQuery();
        this.lastQuery = this.query;

        System.debug(LoggingLevel.INFO, '\n\n Execution query: \n' + this.query + '\n');
        List<SObject> selectResult = Database.query(this.query);

        this.refresh();
        return selectResult;
    }

    private abstract void buildQuery();

    private void refresh() {
        this.filters = new List<Filter>();
        this.excludedFieldsByComa = null;
        // TODO: add refresh limit, order by and etc.
    }


    public Selector fields(String fieldsByComa) {
        Set<String> fields = splitFieldsByComa(fieldsByComa);
        if (!this.isCustomFieldContainer) {
            this.fieldsContainer = new FieldsContainer(fields);
            this.isCustomFieldContainer = true;
        } else {
            this.fieldsContainer.addAll(fields);
        }

        return this;
    }


    public Selector parent(String parentFieldPath) {
        //TODO: refactoring, replace GlobalDescribe on the class level
        //TODO: validate string
        List<String> fieldPathNames = parentFieldPath.split('\\.');
        String relationshipFieldName = fieldPathNames.get(fieldPathNames.size() - 1);

        String formatedRelationshipFieldName;
        if (relationshipFieldName.toLowerCase().contains('__r')) {
            formatedRelationshipFieldName = relationshipFieldName.toLowerCase().replace('__r', '__c');
        } else {
            formatedRelationshipFieldName = relationshipFieldName + 'Id';
        }

        //TODO: validate, if not standard name - need to provide specific fields
        Map<String, Schema.SObjectField> childFields = GLOBAL_DESCRIBE.get(this.sobjectDescribe.getName()).getDescribe().fields.getMap();
        List<Schema.SObjectType> alowedReferenceTypes = childFields.get(formatedRelationshipFieldName).getDescribe().getReferenceTo();
        String referenceObjectName;
        if (!alowedReferenceTypes.isEmpty()) {
            if (alowedReferenceTypes.size() > 1) {
                System.debug(LoggingLevel.ERROR, '\n\n More then one type in the list types!' + alowedReferenceTypes + '\n');
            } else {
                referenceObjectName = alowedReferenceTypes.get(0).getDescribe().getName();
            }
        } else {
            System.debug(LoggingLevel.ERROR, '\n\n The field is not relationship type! \n');
            //TODO: thow error with above debug message.
        }

        Schema.DescribeSObjectResult parentSObjectDescribe = Schema.getGlobalDescribe().get(referenceObjectName).getDescribe();
        return this.parent(parentFieldPath, new FieldsContainer(parentSObjectDescribe));
    }

    public Selector parent(String parentFieldPath, String fieldsByComa) {
        return this.parent(parentFieldPath, new FieldsContainer(splitFieldsByComa(fieldsByComa)));
    }

    public Selector parent(String parentFieldPath, FieldsContainer fieldsContainer) {
        List<String> allParentFields = new List<String>(fieldsContainer.getFields());
        for (String field : allParentFields) {
            this.fieldsContainer.add(parentFieldPath + '.' + field);
        }
        return this;
    }


    public Selector filter(String field, Operator operator, String value) {
        this.filters.add(new Filter(field, operator, value));
        return this;
    }

    public Selector filter(String field, Operator operator, Id value) {
        this.filters.add(new Filter(field, operator, value));
        return this;
    }

    public Selector filter(String field, Operator operator, Integer value) {
        this.filters.add(new Filter(field, operator, value));
        return this;
    }

    public Selector filter(String field, Operator operator, Boolean value) {
        this.filters.add(new Filter(field, operator, value));
        return this;
    }

    public Selector filter(String field, Operator operator, Date value) {
        this.filters.add(new Filter(field, operator, value));
        return this;
    }

    public Selector filter(String field, Operator operator, Datetime value) {
        this.filters.add(new Filter(field, operator, value));
        return this;
    }

    public Selector filter(String field, Operator operator, Decimal value) {
        this.filters.add(new Filter(field, operator, value));
        return this;
    }

    public Selector filter(String field, Operator operator, Double value) {
        this.filters.add(new Filter(field, operator, value));
        return this;
    }

    public Selector filter(String field, Operator operator, Long value) {
        this.filters.add(new Filter(field, operator, value));
        return this;
    }

    public Selector filter(String field, Operator operator, Time value) {
        this.filters.add(new Filter(field, operator, value));
        return this;
    }

    public Selector filter(String field, Operator operator, List<String> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public Selector filter(String field, Operator operator, List<Id> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public Selector filter(String field, Operator operator, List<Boolean> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public Selector filter(String field, Operator operator, List<Date> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public Selector filter(String field, Operator operator, List<Datetime> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public Selector filter(String field, Operator operator, List<Decimal> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public Selector filter(String field, Operator operator, List<Double> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public Selector filter(String field, Operator operator, List<Integer> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public Selector filter(String field, Operator operator, List<Long> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public Selector filter(String field, Operator operator, List<Time> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public Selector filter(String field, Operator operator, Set<String> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public Selector filter(String field, Operator operator, Set<Id> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public Selector filter(String field, Operator operator, Set<Boolean> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public Selector filter(String field, Operator operator, Set<Date> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public Selector filter(String field, Operator operator, Set<Datetime> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public Selector filter(String field, Operator operator, Set<Decimal> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public Selector filter(String field, Operator operator, Set<Double> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public Selector filter(String field, Operator operator, Set<Integer> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public Selector filter(String field, Operator operator, Set<Long> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public Selector filter(String field, Operator operator, Set<Time> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public Selector filter(String field, Operator operator, List<SObject> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public Selector filter(String field, Operator operator, Set<SObject> values) {
        this.filters.add(new Filter(field, operator, values));
        return this;
    }

    public Selector filter(String field, Operator operator) {
        this.filters.add(new Filter(field, operator));
        return this;
    }


    public Selector orderBy(String fieldsByComa) {
        return this.orderBy(fieldsByComa, DEFAULT_ORDER_SEQUENCE, DEFAULT_ORDER_NULLS);
    }

    public Selector orderBy(String fieldsByComa, OrderSequence sequence) {
        return this.orderBy(fieldsByComa, sequence, DEFAULT_ORDER_NULLS);
    }

    public Selector orderBy(String fieldsByComa, OrderNulls oderNullVal) {
        return this.orderBy(fieldsByComa, DEFAULT_ORDER_SEQUENCE, oderNullVal);
    }

    public Selector orderBy(String fieldsByComa, OrderSequence sequence, OrderNulls oderNullVal) {
        //TODO: validate passed fields.
        //TODO: validate if order fields was already set.
        this.orderByFieldsByComa = fieldsByComa;
        this.orderSeq = sequence;
        this.orderNullValues = oderNullVal;
        return this;
    }


    public class Filter {
        private String field;
        private Operator oper;
        private Object value;

        private Filter(String field, Operator operator, Object value) {
            this.field = field;
            this.oper = operator;
            this.value = value;
        }

        public Filter(String field, Operator operator, String value) {
            this(field, operator, (Object) formatString(value));
        }

        public Filter(String field, Operator operator, Id value) {
            this(field, operator, (Object) formatString(value));
        }

        public Filter(String field, Operator operator, Integer value) {
            this(field, operator, (Object) value);
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

        public Filter(String field, Operator operator, Double value) {
            this(field, operator, (Object) value);
        }

        public Filter(String field, Operator operator, Long value) {
            this(field, operator, (Object) value);
        }

        public Filter(String field, Operator operator, Time value) {
            this(field, operator, (Object) value);
        }

        public Filter(String field, Operator operator, List<String> values) {
            this(field, operator);

            String formatedValues = '(';
            for (String value : values) {
                formatedValues += formatString(value) + ',';
            }
            this.value = formatedValues.removeEnd(',') + ')';
        }

        public Filter(String field, Operator operator, List<Id> values) {
            this(field, operator, (List<String>) values);
        }

        public Filter(String field, Operator operator, List<Boolean> values) {
            this(field, operator, formatObjectList(values));
        }

        public Filter(String field, Operator operator, List<Date> values) {
            this(field, operator, formatObjectList(values));
        }

        public Filter(String field, Operator operator, List<Datetime> values) {
            this(field, operator, formatObjectList(values));
        }

        public Filter(String field, Operator operator, List<Decimal> values) {
            this(field, operator, formatObjectList(values));
        }

        public Filter(String field, Operator operator, List<Double> values) {
            this(field, operator, formatObjectList(values));
        }

        public Filter(String field, Operator operator, List<Integer> values) {
            this(field, operator, formatObjectList(values));
        }

        public Filter(String field, Operator operator, List<Long> values) {
            this(field, operator, formatObjectList(values));
        }

        public Filter(String field, Operator operator, List<Time> values) {
            this(field, operator, formatObjectList(values));
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

        public Filter(String field, Operator operator, Set<Double> values) {
            this(field, operator, new List<Double>(values));
        }

        public Filter(String field, Operator operator, Set<Integer> values) {
            this(field, operator, new List<Integer>(values));
        }

        public Filter(String field, Operator operator, Set<Long> values) {
            this(field, operator, new List<Long>(values));
        }

        public Filter(String field, Operator operator, Set<Time> values) {
            this(field, operator, new List<Time>(values));
        }

        public Filter(String field, Operator operator, List<SObject> values) {
            this(field, operator, getIds(new Set<SObject>(values)));
        }

        public Filter(String field, Operator operator, Set<SObject> values) {
            this(field, operator, getIds(values));
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


    private static String formatString(String value) {
        return '\'' + value + '\'';
    }

    private static String formatObjectList(List<Object> values) {
        String formatedString = '(';
        for (Object value : values) {
            formatedString += value + ',';
        }
        return formatedString.removeEnd(',') + ')';
    }

    private static Set<Id> getIds(Set<SObject> records) {
        Set<Id> ids = new Set<Id>();
        for (SObject rec : records) {
            Id id = (Id) rec.get('Id');
            if (id != null) {
                ids.add(id);
            }
        }
        return ids;
    }

    private static Set<String> splitFieldsByComa(String fieldsByComa) {
        //TODO: add validation for entered string.
        List<String> fields = fieldsByComa.split(',');
        Set<String> resultFields = new Set<String>();
        for (String field : fields) {
            resultFields.add(field.trim());
        }
        return resultFields;
    }

}