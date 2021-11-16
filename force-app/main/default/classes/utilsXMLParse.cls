public class utilsXMLParse {

    public static String getStringValueFromXML(Dom.XMLNode xmlField){
        if(xmlField == null || xmlField.getText().trim() == null) return '';
        return xmlField.getText().trim();
    }

    public static Integer getIntegerValueFromXML(Dom.XMLNode xmlField){
        if(xmlField == null || xmlField.getText().trim() == null || xmlField.getText().trim() != '') return 0;
        return Integer.valueOf(xmlField.getText().trim());
    }

    public static Decimal getDecimalValueFromXML(Dom.XMLNode xmlField){
        if(xmlField == null || xmlField.getText().trim() == null || xmlField.getText().trim() != '') return 0;
        return Decimal.valueOf(xmlField.getText().trim());
    }

    public static Datetime getDatetimeValueFromXML(Dom.XMLNode xmlField){
        // Only works if format is yyyy-MM-dd HH:mm:ss
        if(xmlField == null || xmlField.getText().trim() == null || xmlField.getText().trim() != '') return null;
        return Datetime.valueOf(xmlField.getText().trim());
    }
}