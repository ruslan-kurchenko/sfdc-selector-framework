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