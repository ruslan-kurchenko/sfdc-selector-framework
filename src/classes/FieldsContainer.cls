public with sharing class FieldsContainer {

    private Set<String> fields;

    public FieldsContainer(Set<String> fields) {
        this.fields = fields;
    }

    public FieldsContainer(List<String> fields) {
        this.fields = new Set<String>(fields);
    }

    public FieldsContainer(Schema.DescribeSObjectResult sobjectDescribe) {
        this.fields = new Set<String>();
        Map<String, Schema.SObjectField> fieldsMap = sobjectDescribe.fields.getMap();
        for (Schema.SObjectField field : fieldsMap.values()) {
            fields.add(field.getDescribe().getName());
        }
    }

    public Set<String> getFields() {
        return this.fields;
    }

    public void filter(FieldsContainer filterByContainer) {
        this.fields.removeAll(filterByContainer.getFields());
    }

    public String join(String delimiter) {
        return String.join(new List<String>(fields), delimiter);
    }

}