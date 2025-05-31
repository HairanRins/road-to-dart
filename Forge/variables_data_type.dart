void main() {
    // Déclaration explicite
    int age = 25;
    String name = "Alice";
    double height = 1.75;
    bool isStudent = true;

    // Inférence de type avec 'var'
    var city = 'Paris'; // String inféré 
    var number = 42; // int inféré 

    // Variables immuables
    final birthDate = DateTime.now();  // // Valeur assignée à l'exécution
    const pi = 3.14159;   // Valeur assignée à la compilation

    // Types de Données Primitifs
    // Nombres
    int entier = 42;
    double decimal = 3.14;
    num nombreGenerique = 10; // Peut être int ou double

    // Chaînes de caractères
    String simple = 'Bonjour';
    String quotes = "Hello";
    String multilines = '''
    Ceci est un texte
    sur plusieurs lignes
    ''';

    // Interpolation de chaînes
    String nom = 'Bob';
    String message = 'Bonjour $nom, vous avez ${age + 1} ans l\'année prochaine';

    // Booléens
    bool isTrue = true;
    bool isFalse = false;

    // Null safety 
    String? nameOptional;  // Peut être null
    String nameRequis = 'Required';  // Ne peut pas être null
}
