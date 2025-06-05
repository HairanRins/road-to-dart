Parfait ! Voici un **résumé détaillé du système de types en Dart** avec **du code en anglais** et des **explications en français**. Ce résumé est basé sur la documentation officielle de Dart.

---

## 🔹 1. Types Numériques : `int`, `double`

```dart
int age = 30;
double price = 19.99;
```

* `int` représente des nombres entiers.
* `double` représente des nombres à virgule flottante.
* Les deux sont des sous-types de `num`.

---

## 🔹 2. Chaînes de caractères : `String`

```dart
String greeting = 'Hello, Dart!';
```

* `String` est utilisé pour les textes (séquences de caractères).
* Dart permet l’interpolation :

  ```dart
  String name = 'Alice';
  print('Hello, $name!');
  ```

---

## 🔹 3. Booléens : `bool`

```dart
bool isLoggedIn = true;
```

* Utilisé pour les conditions logiques : `true` ou `false`.

---

## 🔹 4. Listes : `List<T>`

```dart
List<int> numbers = [1, 2, 3];
```

* Une `List` est une collection ordonnée (similaire aux tableaux).
* Le type générique `<T>` permet de restreindre les types d’éléments.

---

## 🔹 5. Ensembles : `Set<T>`

```dart
Set<String> colors = {'red', 'green', 'blue'};
```

* Un `Set` est une collection non ordonnée **sans doublons**.

---

## 🔹 6. Dictionnaires : `Map<K, V>`

```dart
Map<String, int> scores = {'Alice': 90, 'Bob': 85};
```

* Un `Map` contient des paires clé/valeur.

---

## 🔹 7. Null et types nullables

```dart
String? name = null; // nullable
String nonNullable = 'Dart'; // non-nullable
```

* Le `?` indique qu’une variable peut avoir la valeur `null`.
* Dart applique une **sécurité stricte contre les nulls** (sound null safety).

---

## 🔹 8. Type dynamique : `dynamic`

```dart
dynamic something = 'Hello';
something = 123; // Pas d’erreur
```

* Permet de désactiver temporairement la vérification statique des types.
* À utiliser avec prudence.

---

## 🔹 9. Inférence de types

```dart
var age = 25; // inféré comme int
final name = 'John'; // inféré comme String
```

* `var` et `final` permettent d’inférer automatiquement le type.

---

## 🔹 10. Typedef (alias de types)

```dart
typedef IntList = List<int>;

IntList ages = [20, 30, 40];
```

* Sert à créer des noms plus lisibles pour des types complexes.

---

## 🔹 11. Enregistrements (Records)

```dart
var person = ('Alice', 25);
print(person.$1); // Alice
print(person.$2); // 25
```

* Les **records** permettent de grouper des valeurs sans créer de classe.

---

## 🔹 12. Énumérations : `enum`

```dart
enum Status { pending, approved, rejected }

Status current = Status.approved;
```

* Utilisé pour définir des constantes nommées et limitées.

---

## 🔹 13. Runes et Unicode

```dart
String emoji = '🎯';
print(emoji.runes); // Unicode code points
```

* `Runes` permet d’accéder aux caractères Unicode.

---

## 🔹 14. Fonctions comme objets

```dart
int add(int a, int b) => a + b;

void main() {
  Function operation = add;
  print(operation(2, 3)); // 5
}
```

* En Dart, les fonctions peuvent être assignées à des variables, passées en argument ou retournées.

---

## 🔹 15. Exemple de sécurité de types

```dart
void printInts(List<int> numbers) {
  for (var number in numbers) {
    print(number);
  }
}

void main() {
  var myList = <int>[1, 2, 3];
  printInts(myList); // OK

  // printInts(['a', 'b']); // Erreur à la compilation
}
```

* Dart empêche l’envoi de types incorrects, renforçant la sécurité.

---


