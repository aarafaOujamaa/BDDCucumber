package org.aarafa.cucumber.person;

import org.aarafa.cucumber.person.model.Person;

import java.util.List;

public class PersonServiceImpl implements PersonService {


    @Override
    public List<Person> init() {
        return List.of(new Person(1L, "luke", "jacobs",30),
                new Person(2L,"Mark", "Dupon", 41), new Person(3L, "Mike", "Jobs",20));
    }

}
