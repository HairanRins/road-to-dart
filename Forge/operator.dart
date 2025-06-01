void main() {
	// Opérateurs Arithmétiques 
    int a = 10, b = 3;

    print('Addition: ${a + b}');        
    print('Soustraction: ${a - b}');    
    print('Multiplication: ${a * b}');  
	print('Division: ${a / b}');        // 3.333...
	print('Division entière: ${a ~/ b}'); // 3
	print('Modulo: ${a % b}');          // 1

	// Opérateurs de Comparaison
	int x = 5, y = 10;

	print('Égal: ${x == y}');           // false
	print('Différent: ${x != y}');      // true
	print('Supérieur: ${x > y}');       // false
	print('Inférieur: ${x < y}');       // true
	print('Sup. ou égal: ${x >= y}');   // false
	print('Inf. ou égal: ${x <= y}');   // true

	// Opérateurs Logiques

	bool c = true, d = false;

	print('ET logique: ${c && d}');     // false
	print('OU logique: ${c || d}');     // true
	print('NON logique: ${!c}');        // false

	// Opérateurs Spéciaux à Dart

	// Opérateur null-aware
	String? nom;
	String affichage = nom ?? 'Anonyme';  // Si nom est null, utilise 'Anonyme'

	// Assignment null-aware
	nom ??= 'Valeur par défaut';  // Assigne seulement si nom est null

	// Conditional member access
	String? texte;
	int? longueur = texte?.length;  // Retourne null si texte est null
}