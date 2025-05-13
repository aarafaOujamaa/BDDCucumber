case : with call API
ref:https://github.com/Ragin-LundF/bbd-cucumber-gherkin-lib/blob/main/src/test/resources/features/path_manipulation/path_manipulation.feature
Feature: Multiple resources

Scenario: Polling authorized until response is correct with short config
    Given that a request polls every 1 seconds for 5 times
    And that the API path is "/api/v1/pollingAuth"
    When executing an authorized GET poll request until the response code is 200 and the body is equal to
    """
    {
      "message": "SUCCESSFUL"
    }
    """

    import java.util.concurrent.TimeUnit;

@Given("that a request polls every {int} seconds for {int} times")
public void configurePolling(int intervalSeconds, int maxAttempts) {
    context.pollInterval = intervalSeconds;
    context.maxAttempts = maxAttempts;
}

@When("executing an authorized GET poll request until the response code is {int} and the body is equal to")
public void pollUntilResponseMatches(int expectedStatusCode, String expectedJsonBody) throws Exception {
    ObjectMapper mapper = new ObjectMapper();
    Map<String, Object> expectedMap = mapper.readValue(expectedJsonBody, Map.class);

    for (int attempt = 1; attempt <= context.maxAttempts; attempt++) {
        response = given()
            .header("Authorization", "Bearer " + token)
            .get(baseUrl + context.api_path_template);

        int actualStatus = response.getStatusCode();
        Map<String, Object> actualMap = response.jsonPath().getMap("$");

        if (actualStatus == expectedStatusCode && actualMap.equals(expectedMap)) {
            return; // Success
        }

        if (attempt < context.maxAttempts) {
            TimeUnit.SECONDS.sleep(context.pollInterval);
        }
    }

    fail("Polling failed: Expected status " + expectedStatusCode + " with body " + expectedJsonBody +
         " but did not receive in " + context.maxAttempts + " attempts.");
}



  Background: 
    Given that all file paths are relative to "features/path_manipulation/"

  Scenario: Execute API call to endpoint with dynamic resources and manipulate them with data table
    Given that the API path is "/api/v1/{resourceId}/{subResourceId}"
    When executing an authorized POST call with previously given API path, body and these dynamic 'URI Elements' replaced with the 'URI Values'
      | URI Elements  | URI Values |
      | resourceId    | abc-def    |
      | subResourceId | ghi-jkl    |
    Then I ensure that the status code of the response is 201
    And I ensure that the body of the response is equal to the file "responses/response.json"



public class ApiSteps {

    private String apiPathTemplate;
    private String resolvedPath;
    private Response response;
    private final String baseUrl = "http://your-base-url.com";
    private final String token = "your-auth-token"; // Replace or load dynamically

    @Given("that the API path is {string}")
    public void setApiPath(String path) {
        this.apiPathTemplate = path;
    }

    @When("executing an authorized POST call with previously given API path, body and these dynamic 'URI Elements' replaced with the 'URI Values'")
    public void postToResolvedPath(DataTable table) throws IOException {
        Map<String, String> uriMap = table.asMap(String.class, String.class);

        resolvedPath = apiPathTemplate;
        for (Map.Entry<String, String> entry : uriMap.entrySet()) {
            resolvedPath = resolvedPath.replace("{" + entry.getKey() + "}", entry.getValue());
        }

        File jsonBody = new File("features/path_manipulation/request_body.json");
        RequestSpecification request = given()
            .header("Authorization", "Bearer " + token)
            .header("Content-Type", "application/json")
            .body(jsonBody);

        response = request.post(baseUrl + resolvedPath);
    }

    @Then("I ensure that the status code of the response is {int}")
    public void verifyStatusCode(int expectedStatusCode) {
        assertEquals("Unexpected status code", expectedStatusCode, response.getStatusCode());
    }

    @Then("I ensure that the body of the response is equal to the file {string}")
    public void compareResponseBody(String filePath) throws IOException {
        File expectedFile = new File("features/path_manipulation/" + filePath);
        String expectedJson = Files.readString(expectedFile.toPath());

        ObjectMapper mapper = new ObjectMapper();
        Map<String, Object> expectedMap = mapper.readValue(expectedJson, Map.class);
        Map<String, Object> actualMap = response.jsonPath().getMap("$");

        assertEquals("Response body does not match expected", expectedMap, actualMap);
    }
}
