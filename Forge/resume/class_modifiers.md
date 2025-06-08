# **Les *class modifiers* en Dart (>=3.0)** 
---

## 1. A quoi servent les modifiers ?

Les *class modifiers* contrôlent 4 axes :

* **Construction** : peut-on instancier la classe ?
* **Extensibilité** (`extends`) : peut-on hériter d’elle ?
* **Implémentation** (`implements`) : peut-on en implémenter l’interface ?
* **Mixins** (`with`) : peut-on la mixer dans une autre classe ?

Ils permettent de limiter l’usage d’une classe hors de sa librarie, assurant robustesse, évolutivité, et sécurité.

---

## 2. Les principaux modifiers

### ◾ **Sans modifier**

* Pas de restriction : constructible, extensible, implémentable, mixable.
  ([dart.dev][1], [vitaly-dev-official.medium.com][2], [stackoverflow.com][3], [medium.com][4], [github.com][5])

---

### ◾ **abstract**

* ⚠️ Ne peut pas être instanciée.
* Peut être étendue ou implémentée.
* Souvent utilisée comme classe de base.
  💡 Peut avoir un constructor factory.
  ([dart.dev][1], [vitaly-dev-official.medium.com][2])

**Exemple :**

```dart
abstract class Vehicle {
  void moveForward(int meters);
}
```

---

### ◾ **base**

* ⚠️ Ne peut pas être implémentée en dehors de sa librairie.
* Peut être étendue ou utilisée en mixin **à l’intérieur de la même librairie**.
* Transitive : tout sous-type en externe doit aussi être `base`, `final`, ou `sealed`.
  ([medium.com][4], [dart.dev][1])

---

### ◾ **interface**

* Empêche l’extension (`extends`) hors librairie.
* Autorise l’implémentation (`implements`) **hors librairie**.
* Idéal pour définir des API ouvertes.
  ([dart.dev][6])

---

### ◾ **final**

* Empêche toute sous-classification (`extends`, `implements`, `with`) hors librairie.
* Permet une évolution sécurisée de l’API (ajout de méthodes…).
* Toute sous-classe à l’intérieur doit être `base`, `final`, ou `sealed`.
  ([medium.com][4], [dart.dev][1])

---

### ◾ **sealed**

* ⚠️ Ne peut pas être instanciée (implicite `abstract`).
* **Seule l’extension/implémentation à l’intérieur de la librairie est permise**.
* Permet le contrôle exhaustif (`switch`) sur ses sous-classes définies.
  ([medium.com][4], [dev.to][7])

---

## 3. Combinaison de modifiers

On peut combiner certains modifiers (dans l’ordre recommandé : `abstract?`, `base|interface|final|sealed`, `mixin?`, `class`) :

* Exemples : `abstract base class`, `interface class`, `final class`…
* Combinaisons interdites : `sealed abstract`, `interface mixin`, etc.—elles sont redondantes ou contradictoires ([dart.dev][6], [stackoverflow.com][3]).

---

## 4. Tableau résumé des capacités

| Modifier          | Constructible | Extensible | Implémentable | Mixable | Exhaustif (sealed only) |
| ----------------- | :-----------: | :--------: | :-----------: | :-----: | :---------------------: |
| `class`           |       ✅       |      ✅     |       ✅       |    ✅    |            ❌            |
| `abstract class`  |       ❌       |      ✅     |       ✅       |    ✅    |            ❌            |
| `base class`      |       ✅       |      ✅     |       ❌       |    ✅    |            ❌            |
| `interface class` |       ✅       |      ❌     |       ✅       |    ✅    |            ❌            |
| `final class`     |       ✅       |      ❌     |       ❌       |    ❌    |            ❌            |
| `sealed class`    |       ❌       |      ❌     |       ❌       |    ❌    |            ✅            |

💡 Cet aperçu provient du guide et du tableau de référence ([stackoverflow.com][8]).

---

## 5. Exemples pratiques

### base + transitivité

```dart
base class Person { ... }

base class Employee extends Person { ... } // ✅
class Intern implements Person {} // ❌ car Person est base
```

### sealed + pattern matching

```dart
sealed class Shape {}
class Circle extends Shape { ... }
class Square extends Shape { ... }

double area(Shape s) {
  return switch (s) {
    Circle() => /*...*/,
    Square() => /*...*/,
  };
}
```

Compiler avertira si un type de `Shape` n’est pas couvert. ([dev.to][7])

---

## 6. Pourquoi les utiliser ?

* **Robustesse API** : protège contre des usages non souhaités.
* **Évolution sûre** : avec `final`/`sealed`, on peut ajouter des méthodes sans casser.
* **Clarté de conception** : chaque classe a une intention explicite (contrat, extension, etc.).
* **Support au pattern matching** : possible uniquement avec `sealed`.

---

### ✅ En résumé

* `abstract` : classes abstraites, non-instanciables.
* `base` : exclut l’implémentation externe, mais accepte l’héritage local.
* `interface` : permet l’implémentation externe, interdit l’héritage externe.
* `final` : interdit toute extension ou implémentation externe (applique `base` aussi).
* `sealed` : restreint la sous-hierarchy hors librairie + prise en charge des `switch` exhaustifs.

---

[1]: https://dart.dev/language/class-modifiers?utm_source=chatgpt.com "Class modifiers - Dart"
[2]: https://vitaly-dev-official.medium.com/dart-class-modifiers-unveiled-the-hidden-powerhouse-you-didnt-know-you-needed-90eefa21f94a?utm_source=chatgpt.com "Dart Class Modifiers Unveiled: The Hidden Powerhouse You Didn't ..."
[3]: https://stackoverflow.com/questions/76266384/how-do-the-new-class-modifiers-work-in-dart-3-0-interface-vs-abstract?utm_source=chatgpt.com "flutter - How do the new class modifiers work in Dart 3.0 (interface vs ..."
[4]: https://medium.com/flutter-community/new-features-in-dart-3-0-7e95ad8d0b81?utm_source=chatgpt.com "New features in Dart 3.0 - Medium"
[5]: https://github.com/dart-lang/language/blob/master/accepted/3.0/class-modifiers/feature-specification.md?utm_source=chatgpt.com "language/accepted/3.0/class-modifiers/feature-specification.md at ..."
[6]: https://dart.dev/language/modifier-reference?utm_source=chatgpt.com "Class modifiers reference - Dart"
[7]: https://dev.to/finitefield/darts-sealed-classes-a-powerful-tool-for-type-safety-and-exhaustiveness-nc9?utm_source=chatgpt.com "Dart's Sealed Classes: A Powerful Tool for Type Safety and ..."
[8]: https://stackoverflow.com/questions/77999569/what-is-difference-b-w-sealed-and-abstract-classes-in-dart?utm_source=chatgpt.com "What is difference b/w sealed and abstract classes in dart?"
