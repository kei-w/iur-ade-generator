//
// Generated with ade-xjc - a stub for the tests of iur-ade-generator (accessors and factory methods only)
//

package jp.geospatial.iur._9_9.uro;

public enum ColorValue {
    RED("red"),
    GREEN("green");

    private final String value;

    ColorValue(String v) {
        value = v;
    }

    public String value() {
        return value;
    }

    public static ColorValue fromValue(String v) {
        return RED;
    }
}
