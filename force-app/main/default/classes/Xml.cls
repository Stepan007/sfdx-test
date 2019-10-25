public class Xml {

    public static Object DeserializeUntyped(Dom.XmlNode[] xmlNodes) {
        Map<String, Object> items = new Map<String, Object>();

        for (Dom.XmlNode node : xmlNodes) {
            if (node.getNodeType() != Dom.XmlNodeType.ELEMENT) {
                continue;
            }

            String nodeName = node.getName();
            Object deserializedNode = DeserializeUntyped(node);

            if (items.containsKey(nodeName)) {
                Object existingItem = items.get(nodeName);

                if (existingItem instanceOf List<Object>) {
                    ((List<Object>)existingItem).add(deserializedNode);
                }
                else {
                    List<Object> childItems = new List<Object>{existingItem};
                    childItems.add(deserializedNode);
                    items.put(nodeName, childItems);
                }
            }
            else {
                items.put(nodeName, deserializedNode);
            }
        }

        return items;
    }

    public static Object DeserializeUntyped(Dom.XmlNode xmlNode) {
        String text = xmlNode.getText();

        Dom.XmlNode[] childNodes = xmlNode.getChildElements();

        //If text node, or no child nodes, return the text
        if (!String.isBlank(text) || childNodes.size() == 0) {
            return text;
        }

        return DeserializeUntyped(childNodes);
    }

    public static Map<String, Object> DeserializeUntyped(String xmlText) {
        Map<String, Object> result = new Map<String, Object>();

        Dom.Document xmlDoc = new Dom.Document();
        xmlDoc.load(xmlText);

        Dom.XmlNode rootNode = xmlDoc.getRootElement();

        result.put(rootNode.getName(), DeserializeUntyped(rootNode));

        return result;
    }
}