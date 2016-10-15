public with sharing class OrderSequence {

    private String value;

    public static OrderSequence ASCENDING = new OrderSequence('ASC');
    public static OrderSequence DESCENING = new OrderSequence('DESC');


    private OrderSequence(String name) {
        this.value = name;
    }

    public String getValue() {
        return this.value;
    }
}