public with sharing class AbstractSelector implements Selector {

    private Schema.DescribeSObjectResult sobjectDescribe;
    private FieldsContainer fieldsContainer;
    private Boolean excludeFields;
    private String query;

    public AbstractSelector(Schema.DescribeSObjectResult sobjectDescribe, FieldsContainer fieldsContainer, Boolean excludeFields) {
        this.sobjectDescribe = sobjectDescribe;
        this.fieldsContainer = fieldsContainer;
        this.excludeFields = excludeFields;
        this.refreshQuery();
    }

    public AbstractSelector(Schema.DescribeSObjectResult sobjectDescribe, FieldsContainer fieldsContainer) {
        this(sobjectDescribe, fieldsContainer, false);
    }

    public AbstractSelector(Schema.DescribeSObjectResult sobjectDescribe) {
        this(sobjectDescribe, new FieldsContainer(sobjectDescribe), false);
    }


    public List<SObject> get() {
        List<SObject> selectResult = Database.query(this.query);
        this.refreshQuery();
        return selectResult;
    }

    public SObject whereId(Id id) {
        this.query += ' WHERE Id = \'' + id + '\'';
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


}