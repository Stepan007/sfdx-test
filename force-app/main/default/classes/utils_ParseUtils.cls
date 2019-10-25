public class utils_ParseUtils {

    public static Date ParseDate(Object value) {
        return ParseDate(value, null, false);
    }

    public static Date ParseDate(Object value, Date defaultValue) {
        return ParseDate(value, defaultValue, true);
    }

    public static Date ParseDate(Object value, Date defaultValue, Boolean ifNullReturnDefault) {

        if (value instanceOf Date) {
            return (Date)value;
        }

        try {
            String text = String.valueOf(value);

            if (String.isEmpty(text) || 'null'.equalsIgnoreCase(text)) {
                if (ifNullReturnDefault) return defaultValue;
                return null;
            }

            return (Date)JSON.deserialize(text, Date.class);
        }
        catch (Exception ex) {
            return defaultValue;
        }
    }


    public static DateTime ParseDateTime(Object value) {
        return ParseDateTime(value, null, false);
    }

    public static DateTime ParseDateTime(Object value, DateTime defaultValue) {
        return ParseDateTime(value, defaultValue, true);
    }

    public static DateTime ParseDateTime(Object value, DateTime defaultValue, Boolean ifNullReturnDefault) {
        if (value instanceOf DateTime) {
            return (DateTime)value;
        }

        try {
            String text = String.valueOf(value);
            if (String.isEmpty(text) || 'null'.equalsIgnoreCase(text)) {
                if (ifNullReturnDefault) return defaultValue;
                return null;
            }

            return (DateTime)JSON.deserialize(text, DateTime.class);
        }
        catch (Exception ex) {
            return defaultValue;
        }
    }


    public static Integer ParseInt(Object value) {
        return ParseInt(value, null, false);
    }

    public static Integer ParseInt(Object value, Integer defaultValue) {
        return ParseInt(value, defaultValue, true);
    }

    public static Integer ParseInt(Object value, Integer defaultValue, Boolean ifNullReturnDefault) {
        if (value instanceOf Integer) {
            return (Integer)value;
        }

        try {
            String text = String.valueOf(value);
            if (String.isEmpty(text) || 'null'.equalsIgnoreCase(text)) {
                if (ifNullReturnDefault) return defaultValue;
                return null;
            }

            return (Integer)JSON.deserialize(text, Integer.class);
        }
        catch (Exception ex) {
            return defaultValue;
        }
    }

    public static Decimal ParseDecimal(Object value) {
        return ParseDecimal(value, null, false);
    }

    public static Decimal ParseDecimal(Object value, Decimal defaultValue) {
        return ParseDecimal(value, defaultValue, true);
    }

    public static Decimal ParseDecimal(Object value, Decimal defaultValue, Boolean ifNullReturnDefault) {
        if (value instanceOf Decimal) {
            return (Decimal)value;
        }

        try {
            String text = String.valueOf(value);
            if (String.isEmpty(text) || 'null'.equalsIgnoreCase(text)) {
                if (ifNullReturnDefault) return defaultValue;
                return null;
            }

            return (Decimal)JSON.deserialize(text, Decimal.class);
        }
        catch (Exception ex) {
            return defaultValue;
        }
    }


    public static Boolean ParseBoolean(Object value) {
        return ParseBoolean(value, null, false);
    }

    public static Boolean ParseBoolean(Object value, Boolean defaultValue) {
        return ParseBoolean(value, defaultValue, true);
    }

    public static Boolean ParseBoolean(Object value, Boolean defaultValue, Boolean ifNullReturnDefault) {
        if (value instanceOf Boolean) {
            return (Boolean)value;
        }

        try {
            String text = String.valueOf(value);
            if (String.isEmpty(text) || 'null'.equalsIgnoreCase(text)) {
                if (ifNullReturnDefault) return defaultValue;
                return null;
            }

            return (Boolean)JSON.deserialize(text, Boolean.class);
        }
        catch (Exception ex) {
            return defaultValue;
        }
    }


    public static Id ParseId(Object value) {
        if (value instanceOf Id) {
            return (Id)value;
        }

        try {
            String text = String.valueOf(value);
            if (String.isEmpty(text) || 'null'.equalsIgnoreCase(text)) {
                return null;
            }

            return (Id)JSON.deserialize(text, Id.class);
        }
        catch (Exception ex) {
            return null;
        }
    }

    public static String ParseString(Object value) {
        if (value instanceOf String) {
            return (String)value;
        }

        if (value == null) return null;

        try {
            String text = String.valueOf(value);
            if (String.isEmpty(text) || 'null'.equalsIgnoreCase(text)) {
                return null;
            }

            return text;
        }
        catch (Exception ex) {
            return null;
        }
    }
}