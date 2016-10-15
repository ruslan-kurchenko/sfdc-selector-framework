public with sharing class OrderNulls {

    private String value;

    public static OrderNulls LAST = new OrderNulls('NULLS LAST');
    public static OrderNulls FIRST = new OrderNulls('NULLS FIRST');

    private OrderNulls(String name) {
        this.value = name;
    }

    public String getValue() {
        return this.value;
    }

}