/*
 * iur-ade-citygml4j - mini fixture of the iur-ade-generator tests
 * (the generators copy this license header into the generated files)
 */

package org.citygml4j.ade.iur.model.uro;

public enum ColorValue {
    RED("red"),
    GREEN("green");

    private final String value;

    ColorValue(String value) {
        this.value = value;
    }

    public String value() {
        return value;
    }

    public static ColorValue fromValue(String value) {
        for (ColorValue v : ColorValue.values()) {
            if (v.value.equals(value))
                return v;
        }

        return null;
    }

    @Override
    public String toString() {
        return value;
    }
}
