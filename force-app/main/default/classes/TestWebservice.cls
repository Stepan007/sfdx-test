global class TestWebservice {
    global class TestMessage {
        webservice String payload;
    }

    webservice static TestMessage getData(TestMessage message) {
        System.debug(message);
        return message;
    }

    webservice static TestMessage getDataString(String message) {
        TestMessage outputMessage = new TestMessage();
        System.debug(message);
        outputMessage.payload = message;
        return outputMessage;
    }
}