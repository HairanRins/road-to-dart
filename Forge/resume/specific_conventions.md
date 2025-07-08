# Conventions et mots-clés avec signification 

En Dart, comme dans beaucoup d'autres langages modernes, certaines conventions et mots-clés ont des significations spécifiques. Voici un guide structuré sur **`Future`**, **les noms commençant par `_`**, et d'autres concepts importants dans Dart, avec **exemples** et **explications claires**.

---

## 🔹 1. `Future` en Dart

### ➤ Signification

Un `Future` représente **une valeur qui sera disponible dans le futur** — c’est-à-dire **asynchrone**. C’est utilisé pour les opérations qui prennent du temps (ex. : lecture de fichier, requête HTTP, timer).

---

### ➤ Exemple simple

```dart
Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Données reçues';
}

void main() async {
  print('Chargement...');
  String result = await fetchData();
  print(result);
}
```

### ➤ Explication

* `Future<String>` : signifie que la fonction retourne **une chaîne de caractères à l’avenir**.
* `await` : attend la fin du `Future`.
* `async` : rend la fonction asynchrone.

---

## 🔹 2. Le tiret bas `_` : signification en Dart

### ➤ `_` en préfixe = **privé au fichier** (file-private)

Quand un nom de variable, classe, méthode ou fonction commence par un **underscore (`_`)**, cela signifie qu’il est **privé** au fichier Dart où il est défini.

---

### ➤ Exemple

```dart
// fichier: mon_module.dart
String _secret = 'Ceci est privé';

void _usageTest() {
  print('Test d\'usage privé');
}
```

* Ces éléments ne peuvent pas être **importés ou utilisés dans un autre fichier Dart**.
* Cela sert à **encapsuler** les détails internes du code.

---

## 🔹 3. `async`, `await`, `then`, `catchError`

### ➤ `async` : rend une fonction asynchrone (retourne un `Future`)

### ➤ `await` : attend un `Future` (doit être utilisé dans une fonction `async`)

### ➤ `then()` : méthode d’un `Future` pour exécuter une action après sa complétion

---

### ➤ Exemple avec `then`

```dart
Future<int> addition(int a, int b) {
  return Future.delayed(Duration(seconds: 1), () => a + b);
}

void main() {
  addition(3, 4).then((value) {
    print('Résultat : $value');
  }).catchError((e) {
    print('Erreur : $e');
  });
}
```

---

## 🔹 4. Concepts essentiels supplémentaires en Dart

### ✔ `late`

* Pour déclarer une variable non initialisée **mais qu’on promet d’initialiser plus tard**.

```dart
late String message;

void init() {
  message = 'Hello!';
}
```

---

### ✔ `final` et `const`

* `final` : valeur assignée une seule fois à l’exécution.
* `const` : valeur connue **à la compilation**.

```dart
final String name = 'Alice';
const int age = 30;
```

---

### ✔ `typedef`

* Crée un alias pour un type (utile pour les fonctions de callback).

```dart
typedef Calcul = int Function(int, int);

int addition(int a, int b) => a + b;
```

---

### ✔ `mixin`, `abstract`, `interface`

* `mixin` : pour ajouter des comportements à une classe.
* `abstract` : classe non instanciable, sert de base.
* Dart ne déclare pas explicitement les `interface`, mais **toute classe peut être utilisée comme interface**.

---

## 🔹 Résumé rapide des syntaxes utiles

| Syntaxe         | Signification                           |
| --------------- | --------------------------------------- |
| `Future<T>`     | Valeur asynchrone                       |
| `_nom`          | Élément privé au fichier                |
| `async`/`await` | Asynchrone, pour attendre des résultats |
| `final`         | Une fois assignée, valeur immuable      |
| `const`         | Constante à la compilation              |
| `late`          | Déclaration différée                    |
| `typedef`       | Alias de type, souvent pour callbacks   |

---

