void main() {

  // Listes (Lists)

  // Création de listes
  List<int> nombres = [1, 2, 3, 4, 5];
  var fruits = ['pomme', 'banane', 'orange'];
  List<String> vide = [];

  // Opérations sur les listes
  nombres.add(6);                    // Ajouter un élément
  nombres.addAll([7, 8, 9]);        // Ajouter plusieurs éléments
  nombres.insert(0, 0);             // Insérer à un index
  nombres.remove(3);                // Supprimer par valeur
  nombres.removeAt(0);              // Supprimer par index

  print('Longueur: ${nombres.length}');
  print('Premier: ${nombres.first}');
  print('Dernier: ${nombres.last}');
  print('Est vide: ${nombres.isEmpty}');

  // Méthodes utiles
  var doubles = nombres.map((n) => n * 2).toList();
  var pairs = nombres.where((n) => n % 2 == 0).toList();
  bool contientCinq = nombres.contains(5);
  int somme = nombres.reduce((a, b) => a + b);

  print(doubles);

  // Ensembles (Sets)
  // Création de sets 
  Set<String> couleurs = {'rouge', 'vert', 'bleu'};
  var villes = <String>{'Paris', 'Londres', 'Tokyo'};

  // Opérations sur les sets
  couleurs.add('jaune');
  couleurs.addAll(['violet', 'orange']);
  couleurs.remove('vert');

  print('Contient rouge: ${couleurs.contains('rouge')}');
  print('Taille: ${couleurs.length}');

  // Opérations d'ensembles
  Set<int> setA = {1, 2, 3, 4};
  Set<int> setB = {3, 4, 5, 6};

  Set<int> union = setA.union(setB);           // {1, 2, 3, 4, 5, 6}
  Set<int> intersection = setA.intersection(setB); // {3, 4}
  Set<int> difference = setA.difference(setB);     // {1, 2}

  // Cartes(Maps)
  // Création de maps
  Map<String, int> ages = {
    'Alice': 25,
    'Bob': 30,
    'Charlie': 35
  };

  var coordonnees = <String, double>{
    'latitude': 48.8566,
    'longitude': 2.3522
  };

  // Opérations sur les maps
  ages['Diana'] = 28;              // Ajouter/modifier
  ages.remove('Bob');              // Supprimer
  ages.update('Alice', (age) => age + 1); // Mettre à jour

  print('Age d\'Alice: ${ages['Alice']}');
  print('Contient Charlie: ${ages.containsKey('Charlie')}');
  print('Clés: ${ages.keys}');
  print('Valeurs: ${ages.values}');

  // Itération
  ages.forEach((nom, age) {
    print('$nom a $age ans');
  });
}