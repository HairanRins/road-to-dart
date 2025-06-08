# **Les métadonnées (*metadata*) en Dart**
---

## 📌 1. Concept général des métadonnées (*metadata*)

En programmation, les métadonnées sont des **informations additionnelles** qui décrivent ou annotent des éléments de code (fonctions, classes, variables…) sans affecter directement leur exécution.

* Elles servent à améliorer :

  * la **documentation**,
  * la **vérification statique** (linting, analyse de code),
  * la **génération de code** (ORM, sérialisation),
  * le **comportement runtime** (via réflexions ou macros).
* Elles sont déclarées souvent via une syntaxe spéciale (ex : `@Annotation`) et peuvent être traitées par des outils ou bibliothèques externes.

---

## 🔍 2. Métadonnées en Dart

### a. Définition et syntaxe

* Une annotation commence par `@` suivie soit :

  1. d’une **constante** pré-définie (ex : `@deprecated`),
  2. d’un **constructeur constant** (ex : `@MyAnno(…)`) ([reddit.com][1], [dart.dev][2]).
* Peut être appliquée à :

  * bibliothèque, import/export, classes, mixins, fonctions, méthodes, variables, paramètres, etc. .

---

### b. Annotations intégrées

Dart inclut nativement quelques annotations utiles ([dart.dev][2]) :

* **`@Deprecated('message')`** : signale que l’élément ne devrait plus être utilisé.
* **`@deprecated`** : version sans message (moins recommandé).
* **`@override`** : indique que la méthode redéfinit une méthode d’une super‑classe.
* **`@pragma`** : transmet des instructions spécifiques au compilateur.

**Exemple :**

```dart
class Television {
  @Deprecated('Use turnOn instead')
  void activate() => turnOn();

  void turnOn() { /* ... */ }
}
```

---

### c. Création d’annotations personnalisées

Vous pouvez définir vos propres annotations :

* Déclarez une **classe `const`**, souvent avec des paramètres.
* Puis utilisez-la avec `@` au-dessus de l’élément visé ([mobikul.com][3], [dart.dev][2]).

```dart
class Todo {
  final String who;
  final String what;
  const Todo(this.who, this.what);
}

@Todo('Alice', 'Implement this')
void doTask() {
  // ...
}
```

---

### d. Utilités pratiques

1. **Documentation & tooltips** : L’IDE peut afficher des avertissements (`@deprecated`) ou inférence de comportements (`@override`). ([api.flutter.dev][4])
2. **Linting et vérification statique** : ex. `@required`, `@protected` (via package `meta`). ([api.flutter.dev][4])
3. **Génération de code & réflexion** : frameworks comme Angular, serializers, macros, bibliothèques FFI, utilisent les annotations pour automatiser du code.&#x20;
4. **Frameworks & compilateur** : `@pragma` pour des options spéciales, instructions liées à Dart2JS, etc.

---

### e. Package `meta`

Le package **`meta`** fournit de nombreuses annotations utiles pour l’analyse statique ([pub.dev][5]) :

* `@required`, `@protected`, `@visibleForTesting`, etc.
* Indiquent l’intention, pour améliorer les outils de l’éditeur, ou le compilateur.

---

### f. Réflexion et metadata à l’exécution

* Dart supporte la **réflexion** (`dart:mirrors`) pour interroger les annotations à l’exécution, bien que ce soit limité côté web (tree shaking). ([mobikul.com][3], [subscription.packtpub.com][6]).
* Exemples :

  ```dart
  var classMirror = reflectClass(DemoClass);
  var annotations = classMirror.metadata;
  ```

---

## 🧾 Récapitulatif

| Aspect                    | Description                                    |
| ------------------------- | ---------------------------------------------- |
| **Syntaxe**               | `@Annotation`                                  |
| **Annotations intégrées** | `@Deprecated`, `@override`, `@pragma`          |
| **Annotations custom**    | classes `const` décorées avec `@`              |
| **Applications**          | linting, documentation, codegen, introspection |
| **Package meta**          | Ajoute `@required`, `@protected`, etc.         |
| **Réflexion**             | Permet d’accéder aux annotations à l’exécution |

---

## ✅ En résumé

Les métadonnées en Dart sont un moyen puissant d’annoter votre code pour la documentation, la vérification statique, la génération automatique et des comportements dynamiques. Elles sont définies via `@…`, activées par des annotations built‑in ou custom, et exploitées par des outils comme les IDE, l’analyseur statique, les générateurs de code et la réflexion.

[1]: https://www.reddit.com/r/FlutterDev/comments/1gri19j?utm_source=chatgpt.com "Read music metadata with audio_metadata_reader"
[2]: https://dart.dev/language/metadata?utm_source=chatgpt.com "Metadata | Dart"
[3]: https://mobikul.com/metadata-annotations-dart/?utm_source=chatgpt.com "Exploring Metadata Annotations in Dart - Mobikul"
[4]: https://api.flutter.dev/flutter/meta/?utm_source=chatgpt.com "meta library - Dart API"
[5]: https://pub.dev/packages/meta?utm_source=chatgpt.com "meta | Dart package"
[6]: https://subscription.packtpub.com/book/programming/9781783989621/4/ch04lvl1sec53/using-annotations?utm_source=chatgpt.com "DART Cookbook"


Voici un **exemple complet et progressif** d'utilisation des **annotations (metadata)** en Dart, partant des bases et allant jusqu’à une **utilisation réaliste avec réflexion**.

---

## 🎯 Objectif :

Créer une annotation personnalisée `@Todo`, l’appliquer à des fonctions, et utiliser la **réflexion** (`dart:mirrors`) pour les retrouver à l’exécution.

---

## 🔧 Étape 1 : Créer une annotation personnalisée

```dart
class Todo {
  final String who;
  final String what;

  const Todo(this.who, this.what);
}
```

* `const` : permet l’utilisation comme métadonnée (obligatoire).
* `who` et `what` : donnent un auteur et une tâche à effectuer.

---

## 🧱 Étape 2 : Annoter des fonctions ou classes

```dart
@Todo('Alice', 'Refactor this method')
void someOldMethod() {
  print('Running someOldMethod...');
}

@Todo('Bob', 'Write documentation')
class SomeClass {
  void doSomething() => print('Doing something...');
}
```

---

## 🔍 Étape 3 : Lire les annotations via réflexion

Pour accéder aux annotations **à l’exécution**, on utilise `dart:mirrors` :

> ⚠️ La réflexion ne fonctionne que dans **Dart VM**, **pas dans Flutter Web** (à cause du tree shaking).

```dart
import 'dart:mirrors';

void main() {
  // Récupère le miroir de la bibliothèque actuelle
  final currentMirror = currentMirrorSystem();
  final libraryMirror = currentMirror.findLibrary(#main);

  // Parcourt toutes les déclarations (fonctions, classes, etc.)
  libraryMirror.declarations.forEach((symbol, declaration) {
    for (var metadata in declaration.metadata) {
      var reflectee = metadata.reflectee;
      if (reflectee is Todo) {
        print('Found @Todo annotation:');
        print('- Target: ${MirrorSystem.getName(symbol)}');
        print('- Who: ${reflectee.who}');
        print('- What: ${reflectee.what}');
        print('---');
      }
    }
  });
}
```

### Résultat console :

```
Found @Todo annotation:
- Target: someOldMethod
- Who: Alice
- What: Refactor this method
---
Found @Todo annotation:
- Target: SomeClass
- Who: Bob
- What: Write documentation
---
```

---

## ✅ Explication

| Élément                 | Description                                      |
| ----------------------- | ------------------------------------------------ |
| `@Todo`                 | Annotation custom définie par l’utilisateur      |
| `@Todo('Alice', '...')` | Application à une méthode                        |
| `dart:mirrors`          | Permet d’accéder au type, nom, et métadonnées    |
| `declaration.metadata`  | Liste des annotations associées à la déclaration |
| `metadata.reflectee`    | Valeur réelle de l’annotation (`Todo`)           |

---

## 📦 Bonus : Utilisation dans un projet réel

Dans un vrai projet, on peut combiner ce type de pattern pour :

* Générer du code automatique (ex : via `build_runner`)
* Vérifier des préconditions (ex : `@Validate`)
* Annoter des endpoints d’API, mapper des classes (comme avec `json_serializable`)

---


