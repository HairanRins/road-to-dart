# **Les Libraries & Imports en Dart**
---

## 📚 1. Concept & Figures de base

* Chaque fichier Dart (et ses `part`) constitue une **library**.
* Les identifiers commençant par `_` sont **privés à la library**, car Dart n’a pas de `public/protected/private` keywords ([dart.dev][1]).
* Les libraries permettent de moduler le code, gérer la visibilité, et faciliter le partage via des packages .

---

## 🔌 2. Importer des libraries

```dart
import 'dart:math';
import 'package:my_pkg/helpers.dart';
import 'src/local_file.dart';
```

* `dart:` pour les libraries core (ex. `dart:core`, `dart:async`, `dart:math`) ([dart.dev][2]).
* `package:` pour importer des packages via pub.
* `relative path` (`../`, `./`) pour importer à l’intérieur du même package, hors `lib`.

---

## 🏷️ 3. Préfixes, `show` et `hide`

* Préfixe pour éviter les conflits :

```dart
import 'package:lib1/lib1.dart';
import 'package:lib2/lib2.dart' as lib2;
var e1 = Element();
var e2 = lib2.Element();
```

* `show` pour importer uniquement certains symboles :

```dart
import 'package:lib1/lib1.dart' show foo, bar;
```

* `hide` pour tout importer sauf certains :

```dart
import 'package:lib2/lib2.dart' hide baz;
```

([dart.dev][1], [medium.com][3])

---

## 🐢 4. Lazy loading (deferred imports)

* Permet de charger une library **on-demand**, utile en Web pour optimiser le démarrage.

```dart
import 'package:greetings/hello.dart' deferred as hello;

Future<void> greet() async {
  await hello.loadLibrary();
  hello.printGreeting();
}
```

* La library est chargée une seule fois ([dart.dev][1]).

---

## 🔄 5. `export` – ré-exportation de symboles

* Permet de créer une façade unique pour plusieurs fichiers.

```dart
// lib/my_pkg.dart
export 'src/a.dart';
export 'src/b.dart' hide BInternal;
```

* Utile pour masquer l’implémentation interne (`lib/src/` doit rester privée) ([dart.dev][4]).

---

## 🧩 6. `part` and `part of` – fichiers d’une même library

* **Partage de namespace complet** (même accès aux `_private`).

```dart
// library.dart
library my_lib;
part 'file1.dart';
part 'file2.dart';

// file1.dart
part of my_lib;
void func1() => _helper();

// file2.dart
part of my_lib;
String _helper() => 'secret';
```

* `part` est **déconseillé** pour code public : privilégier des petits fichiers et `export` ([dart.dev][4]).

---

## 🌐 7. Import/export conditionnels

* Permet de cibler différentes implémentations selon la plateforme :

```dart
export 'src/hw_none.dart'
  if (dart.library.io) 'src/hw_io.dart'
  if (dart.library.js_interop) 'src/hw_web.dart';
```

* Toutes les variations doivent partager la même API .

---

## 🛂 8. Respect de la confidentialité (`_private`)

* Le préfixe `_` rend un membre visible uniquement **dans la même library**.
* Importer un fichier différent ne donne pas accès à ses membres privés ([tutorialspoint.com][5]).

---

## ✅ 9. Bonnes pratiques

* **Un type ➝ un fichier**, éviter `part` pour découpage trop fin ([stackoverflow.com][6]).
* `lib/src/` pour code interne privé, exposer via fichiers sous `lib/` avec `export` ([dart.cn][7]).
* Préférer `import` + `export` over `part`/`part of`, pour meilleure modularité ([medium.com][3]).

---

## 🧪 10. Schéma résumé des directives

| Directive | Usage                      | Namespace           | Private access | Best use case         |
| --------- | -------------------------- | ------------------- | -------------- | --------------------- |
| `import`  | inclure a library          | oui (si non `hide`) | non            | réutilisation de code |
| `export`  | ré-exporter symboles       | oui                 | non            | façade unique         |
| `part`    | splitter une même library  | partagé             | oui            | code fortement couplé |
| `part of` | attacher un part à library | partagé             | oui            | voir `part`           |

---

## 🛠️ Exemple complet all-in-one

```dart
// lib/my_pkg.dart
library my_pkg;
export 'src/a.dart';
export 'src/b.dart' hide _internalInB;

// src/a.dart
part of my_pkg;
void aFun() => print('aFun calls: ${_helper()}');

String _helper() => 'secret';

// src/b.dart
part of my_pkg;
void bFun() => print('bFun');

// example/main.dart
import 'package:my_pkg/my_pkg.dart';
void main() {
  aFun();
  bFun();
}
```

* `aFun`, `bFun` accessibles, `_helper` et `_internalInB` restent invisibles hors de la library.

---

ℹ️ **Conclusion** : Dart offre un puissant système de libraries pour organiser le code, contrôler la visibilité, optimiser les performances (via deferred), et structurer proprement les packages.

[1]: https://dart.dev/language/libraries?utm_source=chatgpt.com "Libraries & imports - Dart"
[2]: https://dart.dev/libraries?utm_source=chatgpt.com "Dart's core libraries"
[3]: https://medium.com/%40irfandev/understanding-import-export-part-and-part-of-in-dart-c6c01c561682?utm_source=chatgpt.com "Understanding import, export, part, and part of in Dart - Medium"
[4]: https://dart.dev/tools/pub/create-packages?utm_source=chatgpt.com "Creating packages - Dart"
[5]: https://www.tutorialspoint.com/dart_programming/dart_programming_libraries.htm?utm_source=chatgpt.com "Dart Programming Libraries - Tutorialspoint"
[6]: https://stackoverflow.com/questions/44480039/dart-need-explanation-of-library-part-and-import-export?utm_source=chatgpt.com "Dart - Need explanation of library/part and import/export"
[7]: https://dart.cn/language/libraries?utm_source=chatgpt.com "Libraries & imports - Dart 中文文档"
