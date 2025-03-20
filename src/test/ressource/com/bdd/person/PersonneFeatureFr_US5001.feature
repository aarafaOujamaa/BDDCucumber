#language: fr
Fonctionnalité:   Fonctionnalité de test des personnes
# Cette fonctionnalité teste le service de gestion des personnes.
# Ce service ne nécessite pas de connexion à une base de données.
# Les personnes doivent être stockées dans une liste en mémoire.

# Premier scénario : Initialisation de la liste des personnes
  Scénario:  Initialisation d'une liste donnée de personnes
    Etant donné que j'ai une méthode statique qui initialise une liste de personnes
    Quand je me connecte, je peux voir la taille de la liste initialisée de personnes
    Alors la taille de la liste est égale à 3

# Création d'une nouvelle personne avec des valeurs aléatoires
  Scénario: Création d'une nouvelle personne
    Étant donné que la liste de personnes contient déjà 3 personnes
    Quand je crée une nouvelle personne avec des valeurs aléatoires
    Alors je récupère l'ID de la nouvelle personne et la liste contient plus de 3 personnes

# Création en masse de personnes
  Plan du scénario: Création en masse
    Étant donné que la liste de personnes contient déjà 3 personnes
    Quand je crée une nouvelle personne avec <Prénom> <Nom> et <Âge>
    Alors je récupère l'ID de la nouvelle personne et la liste contient plus de 3 personnes

    Exemples:
      | Prénom  | Nom      | Âge |
      | Luc     | Jacobs   | 30  |
      | Marc    | Dupon    | 41  |
      | Michel  | Jobs     | 20  |

# Mise à jour d'une personne existante
  Plan du scénario: Mise à jour d'une personne par ID
    Étant donné que la liste de personnes contient déjà 3 personnes
    Quand je mets à jour les données d'une personne avec <ID> et <Prénom> <Nom> et <Âge>
    Alors je récupère la personne mise à jour

    Exemples:
      | ID | Prénom | Nom      | Âge |
      | 1  | Ali    | Boulait  | 31  |
      | 2  | Marc2  | Dupon2   | 44  |
      | 3  | Michel | Jobs2    | 21  |

# Suppression d'une personne existante
  Scénario: Suppression d'une personne donnée
    Étant donné que la liste de personnes contient déjà 3 personnes
    Quand je supprime une personne avec l'ID "1"
    Alors la personne donnée est supprimée et la taille de la liste est égale à "2"
