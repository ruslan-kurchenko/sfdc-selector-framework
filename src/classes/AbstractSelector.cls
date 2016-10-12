public with sharing class AbstractSelector implements Selector {

    private Schema.DescribeSObjectResult sobjectDescribe;
    private FieldsContainer fieldsContainer;
    //TODO: implement exculde fields functionality
    private String gluedExcludedFields;
    private List<Filter> filters;
    private String query;
    private String lastQuery;

    public AbstractSelector(Schema.DescribeSObjectResult sobjectDescribe, FieldsContainer fieldsContainer) {
        this.sobjectDescribe = sobjectDescribe;
        this.fieldsContainer = fieldsContainer;
        System.debug('\n\n fieldsContainer => ' + fieldsContainer + '\n');
        this.refresh();
    }


    public AbstractSelector(Schema.DescribeSObjectResult sobjectDescribe) {
        this(sobjectDescribe, new FieldsContainer(sobjectDescribe));
    }

    public AbstractSelector(String sobjectName) {
        Schema.DescribeSObjectResult sobjectDescribe = Schema.getGlobalDescribe().get(sobjectName).getDescribe();
        if(sobjectDescribe == null) {
            // TODO: throw exception - IncompatibleSObjectType
            System.debug(LoggingLevel.ERROR,'\n\n Throw exception - IncompatibleSObjectType \n');
        }
        this.sobjectDescribe = sobjectDescribe;
        this.fieldsContainer = new FieldsContainer(sobjectDescribe);
        System.debug('\n\n fieldsContainer => ' + fieldsContainer + '\n');
        this.refresh();
    }


    public List<SObject> get() {
        this.buildQuery();
        this.lastQuery = this.query;
        System.debug('\n\n this.query => ' + this.query + '\n');

        List<SObject> selectResult = Database.query(this.query);

        this.refresh();
        return selectResult;
    }

    private void buildQuery() {
        this.query = 'SELECT ';
        System.debug('\n\n string.isBlank(this.gluedExcludedFields) => ' + String.isBlank(this.gluedExcludedFields) + '\n');
        if (String.isNotBlank(this.gluedExcludedFields)) {
            FieldsContainer allFieldsContainer = new FieldsContainer(sobjectDescribe);
            allFieldsContainer.filter(this.fieldsContainer);
            this.query += allFieldsContainer.join(',');
            System.debug('\n\n here \n');
        } else {
            this.query += this.fieldsContainer.join(',');
            System.debug('\n\n here!!! \n');
        }

        this.query += ' FROM ' + this.sobjectDescribe.getName();

        Boolean conditionStarted = false;
        for (Filter filter : this.filters) {
            this.query += !conditionStarted ? ' WHERE ' : ' AND ';
            this.query += filter.getCondition();
            conditionStarted = true;
        }
    }

    private void refresh() {
        this.filters = new List<Filter>();
        this.gluedExcludedFields = null;
        // TODO: add refresh limit, order by and etc.
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


    private class Filter {
        private String field;
        private Operator operator;
        private Object value;

        private Filter(String field, Operator operator) {
            this.field = field;
            this.operator = operator;
        }

        private Filter(String field, Operator operator, Object value) {
            this(field, operator);
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


        public String getCondition() {
            return this.field + this.operator.getValue() + this.value;
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

}