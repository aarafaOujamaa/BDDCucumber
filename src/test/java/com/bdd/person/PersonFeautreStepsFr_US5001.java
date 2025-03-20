package com.bdd.person;

import io.cucumber.java.fr.Étantdonné;
import io.cucumber.java.fr.Alors;
import io.cucumber.java.fr.Quand;
import io.cucumber.java.fr.Étantdonnéque;
import org.aarafa.cucumber.person.PersonService;
import org.aarafa.cucumber.person.PersonServiceImpl;
import org.aarafa.cucumber.person.model.Person;
import org.junit.Assert;

import java.util.List;

public class PersonFeautreStepsFr_US5001 {

    private PersonService personService = new PersonServiceImpl();
    private List<Person> listePersonnes;
    private int tailleListePersonnes;

    @Étantdonnéque("j'ai une méthode statique qui initialise une liste de personnes")
    public void initialise_une_liste_de_personnes() {
        initialiserListePersonnes();
    }


    @Quand("je me connecte, je peux voir la taille de la liste initialisée de personnes")
    public void quand_je_me_connecte_je_peux_voir_la_liste() {
        tailleListePersonnes = listePersonnes.size();
    }

    @Alors("la taille de la liste est égale à 3")
    public void alors_la_taille_de_la_liste_est_egale_a_3() {
        Assert.assertEquals(tailleListePersonnes, 3);
    }

    private void initialiserListePersonnes() {
        listePersonnes = this.personService.init();
    }
}
