# **résumé complet des *patterns* (modèles) en Dart**

---

## 🧩 Qu'est-ce qu'un *pattern* en Dart ?

Introduits avec Dart 3.0, les *patterns* sont une nouvelle construction syntaxique permettant de :

* **Faire correspondre** des valeurs à une structure attendue (*pattern matching*).
* **Déstructurer** des objets pour extraire leurs composants de manière déclarative.

Ils peuvent être utilisés dans diverses situations : déclarations de variables, affectations, instructions `switch`, expressions `if-case`, boucles `for`, etc.

---

## 🔍 Utilisations principales

### 1. Correspondance (*Matching*)

Permet de vérifier si une valeur correspond à un certain motif.

```dart
switch (number) {
  case 1:
    print('one');
    break;
}
```

Ici, le `case 1` correspond si `number` est égal à 1.([dart.dev][1])

### 2. Déstructuration (*Destructuring*)

Permet d'extraire des composants d'une structure complexe.

```dart
var numList = [1, 2, 3];
var [a, b, c] = numList;
print(a + b + c); // 6
```

Les variables `a`, `b` et `c` reçoivent respectivement les valeurs 1, 2 et 3.

---

## 📌 Où peut-on utiliser les *patterns* ?

### a. Déclaration de variables

Utilisation lors de la déclaration pour déstructurer des valeurs.([dart.dev][1])

```dart
var (a, [b, c]) = ('str', [1, 2]);
```

Ici, `a` reçoit `'str'`, `b` reçoit 1 et `c` reçoit 2.([dart.dev][1])

### b. Affectation de variables

Permet de réaffecter des valeurs en déstructurant.

```dart
var (a, b) = ('left', 'right');
(b, a) = (a, b); // Échange des valeurs
print('$a $b'); // right left
```

### c. Instructions `switch` et expressions `if-case`

Utilisation pour faire correspondre et déstructurer des valeurs dans des structures de contrôle.

```dart
switch (list) {
  case ['a' || 'b', var c]:
    print(c);
    break;
}
```

Ici, si `list` commence par `'a'` ou `'b'`, la deuxième valeur est assignée à `c`.

---

## 🧱 Types de *patterns*

### 1. *Logical-or* (`||`)

Correspond si l'une des branches correspond.

```dart
var isPrimary = switch (color) {
  Color.red || Color.yellow || Color.blue => true,
  _ => false,
};
```

### 2. *List* et *Map* patterns

Permettent de déstructurer des listes ou des maps.

```dart
var [first, second, ...rest] = [1, 2, 3, 4];
```

Ici, `first` est 1, `second` est 2, et `rest` est `[3, 4]`.

### 3. *Record* patterns

Utilisation avec des enregistrements pour extraire des valeurs.

```dart
var (name, age) = ('Alice', 30);
```

### 4. *Object* patterns

Déstructuration d'objets en accédant à leurs propriétés.

```dart
class Point {
  final int x, y;
  Point(this.x, this.y);
}

var point = Point(1, 2);
switch (point) {
  case Point(x: var x, y: var y):
    print('x=$x, y=$y');
    break;
}
```

### 5. *Wildcard* (`_`)

Ignorer certaines valeurs lors de la déstructuration.([codelabs.developers.google.com][2])

```dart
var [_, second, _] = [1, 2, 3];
```

Ici, seule la deuxième valeur est capturée.

---

## 🧠 Cas d'utilisation pratiques

* **Déstructuration de retours multiples** : Extraire plusieurs valeurs retournées par une fonction.

  ```dart
  (int, String) getData() => (42, 'Answer');
  var (number, text) = getData();
  ```

* **Validation de données JSON** : Vérifier et extraire des champs spécifiques.

  ```dart
  var json = {'type': 'text', 'value': 'Hello'};
  switch (json) {
    case {'type': 'text', 'value': var text}:
      print(text);
      break;
  }
  ```

* **Modélisation de types algébriques** : Utilisation avec des classes scellées pour représenter des états finis.

  ```dart
  sealed class Shape {}
  class Circle extends Shape {}
  class Square extends Shape {}

  Shape shape = Circle();
  switch (shape) {
    case Circle():
      print('Circle');
      break;
    case Square():
      print('Square');
      break;
  }
  ```

---

## 📚 Ressources supplémentaires

* [Documentation officielle sur les *patterns* en Dart](https://dart.dev/language/patterns)
* [Types de *patterns* en Dart](https://dart.dev/language/pattern-types)
* [Guide complet sur les enregistrements et les *patterns* en Dart](https://www.sandromaglione.com/articles/records-and-patterns-dart-language)

---

[1]: https://dart.dev/language/patterns?utm_source=chatgpt.com "Patterns | Dart"
[2]: https://codelabs.developers.google.com/codelabs/dart-patterns-records?utm_source=chatgpt.com "Dive into Dart's patterns and records - Google Codelabs"
