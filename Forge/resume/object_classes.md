# **Les classes et objets en Dart**

---

## ⚙️ 1. Concepts de base

* **Tout est objet** (à l’exception de `Null`), car Dart est orienté objet ([dart.dev][2]).
* Les **classes** servent de modèles, et les **objets** (instances) en sont les concrétisations.
* Une **library** peut contenir plusieurs classes. Les membres dont le nom commence par `_` sont privés à la même library ([dart.dev][2]).

---

## 📦 2. Définition d’une classe

```dart
class Point {
  num x, y;
  Point(this.x, this.y);           // Constructeur positionnel
  Point.origin() : x = 0, y = 0;   // Constructeur nommé
}
```

* `class` : mot-clé pour déclarer une classe.
* **Variables d’instance** : `x`, `y`.
* **Constructeurs** :

  * Standard (`Point(this.x, this.y)`)
  * Nommés via `ClassName.identifier()`.

---

## 🏗️ 3. Constructeurs et instances constantes

```dart
class ImmutablePoint {
  final num x, y;
  const ImmutablePoint(this.x, this.y);
}

var p1 = const ImmutablePoint(2, 2);
var p2 = ImmutablePoint(2, 2);  // aussi constant grâce au contexte
```

* `const` : crée des instances **immuables** au moment de la compilation.
* Identiques si mêmes paramètres ([fr.wikipedia.org][3], [dart.dev][2]).

---

## 🧭 4. Méthodes et opérateurs

```dart
class Point {
  // ...
  num distanceTo(Point other) {
    var dx = x - other.x;
    var dy = y - other.y;
    return sqrt(dx*dx + dy*dy);
  }

  num get magnitude => sqrt(x*x + y*y);
  
  Point operator +(Point other) => Point(x + other.x, y + other.y);
}
```

* **Méthodes d’instance** : fonction à l’intérieur d’une classe.
* **Getter calculé** : `get`.
* **Surcharge d’opérateur** : `operator +` permet `p1 + p2`.

---

## 🛠️ 5. Variables et méthodes statiques

```dart
class Circle {
  static const double pi = 3.14159;
  static double area(double radius) => pi * radius * radius;
}
```

* `static` applique à l’échelle de la classe, non de l’objet.
* Utiles pour constantes et méthodes utilitaires partagés.

---

## 🧬 6. Héritage, mixins et interfaces

* **Héritage unique** via `extends` :

  ```dart
  class ColoredPoint extends Point {
    String color;
    ColoredPoint(this.color, num x, num y) : super(x, y);
  }
  ```

* **Mixins** via `with` : pour ajouter du comportement multiple.

* **Interfaces** : chaque classe peut être implémentée via `implements`.

*(Voir docs pour détails avancés)* ([fr.wikipedia.org][3], [docs.flutter.dev][4], [dart.dev][2])

---

## 🔍 7. Réflexion de type

```dart
var p = Point(1, 2);
print(p.runtimeType);  // Affiche "Point"
print(p is Point);     // Utiliser `is` plutôt que `runtimeType ==`
```

* `runtimeType` renvoie le type au moment de l’exécution.
* Utiliser les testeurs `is` pour plus de fiabilité .

---

## 📘 8. Bonnes pratiques de documentation

* Utiliser les **doc comments** `///` au-dessus des classes et méthodes ([dart.dev][5]).
* Commencer par un résumé, expliquer les paramètres, la valeur retournée.
* Inclure des exemples en encadrés de code.

---

## 🧾 9. Récapitulatif

| Élément            | Utilisation et bonne pratique            |
| ------------------ | ---------------------------------------- |
| ✅ Classe           | `class Name {}`                          |
| ✅ Constructeurs    | Nominal et `const`                       |
| ✅ Membres          | Variables, méthodes, getters, opérateurs |
| ✅ Membres `static` | Constantes et utilitaires                |
| ✅ Héritage         | `extends`, `with`, `implements`          |
| ✅ Typage           | `runtimeType`, tests `is`                |
| ✅ Documentation    | `///` commentaires + exemples            |

---

### 🌟 Exemple complet

```dart
import 'dart:math';

/// A 2D point.
class Point {
  final num x, y;
  const Point(this.x, this.y);
  const Point.origin() : x = 0, y = 0;

  num distanceTo(Point other) {
    var dx = x - other.x;
    var dy = y - other.y;
    return sqrt(dx*dx + dy*dy);
  }

  num get magnitude => sqrt(x*x + y*y);
  Point operator +(Point other) => Point(x + other.x, y + other.y);
}

void main() {
  var p1 = const Point(3, 4);
  var p2 = Point.origin();
  print(p1.magnitude);                  // 5
  print(p1.distanceTo(p2));            // 5
  var p3 = p1 + Point(1, 1);
  print(p3);                           // Instance of 'Point'
}
```

---

[1]: https://www.youtube.com/watch?v=5PZj0MXckz4&utm_source=chatgpt.com "classes & objects in Dart - YouTube"
[2]: https://dart.dev/language/classes?utm_source=chatgpt.com "Classes | Dart"
[3]: https://fr.wikipedia.org/wiki/Dart_%28langage%29?utm_source=chatgpt.com "Dart (langage)"
[4]: https://docs.flutter.dev/get-started/fundamentals/dart?utm_source=chatgpt.com "Intro to Dart - Flutter Documentation"
[5]: https://dart.dev/effective-dart/documentation?utm_source=chatgpt.com "Effective Dart: Documentation"
