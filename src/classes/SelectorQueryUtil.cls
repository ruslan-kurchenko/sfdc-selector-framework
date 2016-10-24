public with sharing class SelectorQueryUtil {

    public String formatString(String value) {
        return '\'' + value + '\'';
    }

    public String formatObjectList(List<Object> values) {
        String formatedString = '(';
        for (Object value : values) {
            formatedString += value + ',';
        }
        return formatedString.removeEnd(',') + ')';
    }

    public Set<String> getIds(Set<SObject> records) {
        Set<String> ids = new Set<String>();
        for (SObject rec : records) {
            String id = (String) rec.get('Id');
            if (id != null) {
                ids.add(id);
            }
        }
        return ids;
    }

}