public with sharing class AbstractSelector implements Selector {

    private Schema.DescribeSObjectResult sobjectDescribe;
    private FieldsContainer fieldsContainer;
    private Boolean excludeFields;
    private List<Filter> filters;
    private String query;

    private static final Map<Operator, String> OPERATORS_VALUES_BY_NAMES = new Map<Operator, String> {
            Operator.GREATER => '>',
            Operator.LESS => '<',
            Operator.EQUALS => '='
    };

    public AbstractSelector(Schema.DescribeSObjectResult sobjectDescribe, FieldsContainer fieldsContainer, Boolean excludeFields) {
        this.sobjectDescribe = sobjectDescribe;
        this.fieldsContainer = fieldsContainer;
        this.excludeFields = excludeFields;

        this.filters = new List<Filter>();

        this.refreshQuery();
    }

    public AbstractSelector(Schema.DescribeSObjectResult sobjectDescribe, FieldsContainer fieldsContainer) {
        this(sobjectDescribe, fieldsContainer, false);
    }

    public AbstractSelector(Schema.DescribeSObjectResult sobjectDescribe) {
        this(sobjectDescribe, new FieldsContainer(sobjectDescribe), false);
    }


    public List<SObject> get() {
        Boolean conditionStarted = false;
        for (Filter filter : this.filters) {
            this.query += !conditionStarted ? ' WHERE ' : ' AND ';
            this.query += filter.getCondition();
            conditionStarted = true;
        }

        System.debug('\n\n this.query => ' + this.query + '\n');

        List<SObject> selectResult = Database.query(this.query);
        this.refreshQuery();
        return selectResult;
    }

    public SObject whereId(Id id) {
        this.filters.add(new Filter('Id', Operator.EQUALS, id));
        List<SObject> selectResult = this.get();
        return selectResult.isEmpty() ? null : selectResult.get(0);
    }

    public List<SObject> whereId(Set<Id> ids) {
        this.query += ' WHERE Id IN ('+ this.encloseJoin(ids) +') ';
        return this.get();
    }

    public List<SObject> whereId(List<Id> ids) {
        this.query += ' WHERE Id IN ('+ this.encloseJoin(ids) +') ';
        return this.get();
    }

    public List<SObject> whereId(List<SObject> records) {
        this.query += ' WHERE Id IN ('+ this.encloseJoin(this.getIds(records)) +') ';
        return this.get();
    }

    public List<SObject> whereId(Set<SObject> records) {
        this.query += ' WHERE Id IN ('+ this.encloseJoin(this.getIds(records)) +') ';
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

    private void refreshQuery() {
        this.query = 'SELECT ';

        if (this.excludeFields) {
            FieldsContainer allFieldsContainer = new FieldsContainer(sobjectDescribe);
            allFieldsContainer.filter(this.fieldsContainer);
            this.query += allFieldsContainer.join(',');
        } else {
            this.query += this.fieldsContainer.join(',');
        }

        this.query += ' FROM ' + this.sobjectDescribe.getName();
    }

    private String encloseJoin(Set<Id> ids, String encloser, String delimiter) {
        List<String> enclosedIds = new List<String>();
        for (Id id : ids) {
            enclosedIds.add(encloser + ((String) id) + encloser);
        }
        return String.join(enclosedIds, delimiter);
    }

    private String encloseJoin(Set<Id> ids) {
        return this.encloseJoin(ids, '\'', ',');
    }

    private String encloseJoin(List<Id> ids) {
        return this.encloseJoin(new Set<Id>(ids), '\'', ',');
    }

    private Set<Id> getIds(List<SObject> records) {
        return this.getIds(new Set<SObject>(records));
    }

    private Set<Id> getIds(Set<SObject> records) {
        Set<Id> ids = new Set<Id>();
        for (SObject rec : records) {
            Id id = (Id) rec.get('Id');
            if(id != null) {
                ids.add(id);
            }
        }
        return ids;
    }

    private class Filter {
        private String field;
        private Operator operator;
        private String formatedValue;

        private Filter(String field, Operator operator) {
            this.field = field;
            this.operator = operator;
        }

        public Filter(String field, Operator operator, String value) {
            this(field, operator);
            this.formatedValue = this.formatString(value);
        }

        public Filter(String field, Operator operator, Id value) {
            this(field, operator);
            this.formatedValue = this.formatString((String) value);
        }

        public Filter(String field, Operator operator, Integer value) {
            this(field, operator);
            this.formatedValue = String.valueOf(value);
        }

        public String getCondition() {
            return this.field + OPERATORS_VALUES_BY_NAMES.get(this.operator) + this.formatedValue;
        }

        private String formatString(String value) {
            return '\''+ value +'\'';
        }

    }

}