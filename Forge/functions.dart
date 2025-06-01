void main() {
  // Fonction simple
  void sayHello() {
    print('Hello !');
  }

  // Fonction avec paramètres et valeur de retour
  int add(int a, int b) {
    return a + b;
  }

  // Fonction avec expression (arrow function)
  int multiplier(int a, int b) => a * b;

  // Paramètres optionnels positionnels
  String greeting(String name, [String? title]) {
    if (title != null) {
      return 'Hello $title $name';
    }
    return 'Hello $name';
  }

  // Paramètres nommés
  void createPerson({required String nom, int age = 0, String ville = 'Inconnue'}) {
    print('Nom: $nom, Age: $age, Ville: $ville');
  }

  // Utilisation des fonctions
  sayHello();
  int resultat = add(5, 3);
  int produit = multiplier(4, 6);
  print('Résultat de l\'addition: $resultat');
  print('Produit: $produit');

  print(greeting('Alice'));           // Bonjour Alice
  print(greeting('Bob', 'M.'));       // Bonjour M. Bob

  createPerson(nom: 'Charlie', age: 30);
  createPerson(nom: 'Diana', ville: 'Lyon', age: 25);


  // Fonctions de Première Classe
  // Fonction comme variable
  Function operation = (int a, int b) => a + b;
  print(operation(3, 4));  // 7

  // Fonction comme paramètre
  void executeOperation(int a, int b, Function op) {
    print('Résultat: ${op(a, b)}');
  }

  executeOperation(5, 2, (x, y) => x * y); // Résultat: 10

  // Fonctions anonymes et closures
  List<int> nombres = [1, 2, 3, 4, 5];
  var pairs = nombres.where((n) => n % 2 == 0).toList();
  print(pairs); // [2, 4]
}