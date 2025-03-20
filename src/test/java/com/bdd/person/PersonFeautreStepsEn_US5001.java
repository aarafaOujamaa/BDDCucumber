package com.bdd.person;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.cucumber.junit.Cucumber;
import org.aarafa.cucumber.person.PersonService;
import org.aarafa.cucumber.person.PersonServiceImpl;
import org.aarafa.cucumber.person.model.Person;
import org.junit.Assert;
import org.junit.runner.RunWith;

import java.util.List;

@RunWith(Cucumber.class)
public class PersonFeautreStepsEn_US5001 {

    private PersonService personService = new PersonServiceImpl();
    private List<Person> personList;
    private int personsListSize;

    @Given("I have a static method which initializes a list of persons")
    public void given_i_have_a_static_method_which_initializes_a_list_of_persons() {
        initPersonList();
    }

    @When("I connect I can see the size of the initialized list of persons")
    public void when_I_connect_I_can_see_the_list() {
        personsListSize = personList.size();
    }

    @Then("The list size is equal to 3")
    public void then_the_list_size_is_equal_to_3() {
        Assert.assertEquals(personsListSize, 3);
    }


    // Implementing Create new Person Scenario

  /*  @Given("The list of persons contains 3 persons already stored")
    public void the_list_of_persons_contains_3_persons_already_stored() {
        personListSize = personList.size();
    }

    @When("I create a new person with random entries")
    public void i_create_new_person_with_random_entries() {
        Person randomPerson = new Person();
        randomPerson.setId(4);
        randomPerson.setFirstName("Random1");
        randomPerson.setLastName("Random2");
        randomPerson.setAge(34);
        personService.save(randomPerson);
    }

    private void initPersonsList() {
        this.personsList = this.personService.init();
    }

    private void findAllPersons() {
        this.personsList = this.person
    }



   */

    private void initPersonList() {
        personList = this.personService.init();
    }
}
