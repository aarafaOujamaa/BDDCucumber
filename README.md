case : with call API
Feature: Multiple resources

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
