void main() {

    // Conditions 
    // if-else classique 
    int age = 18;
    if (age >= 18) {
      print('Majeur');
    } else if (age >= 16) {
      print('Presque majeur');
    } else {
      print('Mineur');
    }

    // Opérateur ternaire
    String statut = age >= 18 ? 'Majeur' : 'Mineur';

    // Switch-case
    String jour = 'lundi';
    switch (jour) {
      case 'lundi':
      case 'mardi':
      case 'mercredi':
      case 'jeudi':
      case 'vendredi':
        print('Jour de travail');
        break;
      case 'samedi':
      case 'dimanche':
        print('Week-end');
        break;
      default:
        print('Jour invalide');
    }

    // Boucles 
    // Boucle for classique
    for (int i = 0; i < 5; i++) {
      print('Itération $i');
    }

    // Boucle for-in
    List<String> fruits = ['pomme', 'banane', 'orange'];
    for (String fruit in fruits) {
      print('Fruit: $fruit');
    }

    // Boucle while
    int compteur = 0;
    while (compteur < 3) {
      print('Compteur: $compteur');
      compteur++;
    }

    // Boucle do-while
    int nombre = 0;
    do {
      print('Nombre: $nombre');
      nombre++;
    } while (nombre < 2);
}