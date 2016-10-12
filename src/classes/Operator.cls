public class Operator {
    private final String value;

    public static final Operator GREATER = new Operator('>');
    public static final Operator GREATER_EQUALS = new Operator('<=');
    public static final Operator LESS = new Operator('<');
    public static final Operator LESS_EQUALS = new Operator('<=');
    public static final Operator EQUALS = new Operator('=');
    public static final Operator NOT_QUALS = new Operator('!=');
    public static final Operator IS_LIKE = new Operator('LIKE');
    public static final Operator IS_IN = new Operator('IN');
    public static final Operator IS_NOT_IN = new Operator('NOT IN');
    public static final Operator INCLUDES = new Operator('INCLUDES');
    public static final Operator NOT_INCLUDES = new Operator('INCLUDES');

    private Operator(String value) {
        this.value = value;
    }

    public String getValue() {
        return this.value;
    }
}