# **Les bibliothèques cœur (*core libraries*) de Dart**

## 🧩 1. Tour général des core libraries

Dart propose plusieurs bibliothèques essentielles (`dart:*`) couvrant un large spectre fonctionnel :

| Library           | Usage                                                                 | Toujours disponible ?                                   |
| ----------------- | --------------------------------------------------------------------- | ------------------------------------------------------- |
| `dart:core`       | Types de base (`String`, `List`, `Map`, `Set`, `DateTime`, `RegExp`…) | ✔ importée automatiquement                              |
| `dart:async`      | Asynchronisme : `Future`, `Stream`, `Timer`                           | ✔                                                       |
| `dart:collection` | Collections avancées (queues, double-ended, vues non modifiables…)    | ✔                                                       |
| `dart:convert`    | Sérialisation : JSON, UTF‑8, Base64…                                  | ✔                                                       |
| `dart:math`       | Mathématiques : constantes, fonctions, RNG                            | ✔                                                       |
| `dart:typed_data` | Tableaux à type fixe, efficientes (Uint8List…)                        | ✔                                                       |
| `dart:io`         | E/S fichiers, sockets, HTTP, processus (*non-web*)                    | uniquement VM                                           |
| `dart:isolate`    | Concurrence réelle sur plusieurs isolats                              | uniquement VM                                           |
| `dart:ffi`        | Interface vers C natif                                                | uniquement VM ([dart-ko.dev][2], [en.wikipedia.org][3]) |

---

## 📘 2. `dart:core`

* Contient les types fondamentaux (`int`, `double`, `String`, `DateTime`, `Duration`, `RegExp`, `Uri`, `Iterable`…) ([api.dart.dev][4])

* Possède des méthodes pratiques :

  ```dart
  assert(int.parse('42') == 42);
  assert(double.parse('0.5').toStringAsFixed(2) == '0.50');
  ```

* Opère sur les collections de base (`List`, `Set`, `Map`) :

  ```dart
  var heroes = ['Batman', 'Superman'];
  var unique = {'a', 'b', 'a'};  // Set élimine les doublons
  ```

---

## ⏳ 3. `dart:async`

* Gère l’asynchronisme :

  * **`Future<T>`** : résultat unique asynchrone
  * **`Stream<T>`** : suite de données asynchrones

* Exemples :

  ```dart
  Future<String> fetch() async {
    await Future.delayed(Duration(seconds: 1));
    return 'done';
  }

  Stream<int> countStream(int to) async* {
    for (var i = 1; i <= to; i++) yield i;
  }
  ```

* `await` et `await for` simplifient l’écriture ([rm-dart.web.app][5])

---

## 🔢 4. `dart:collection`

* Offre des collections spécialisées (e.g. `Queue`, `LinkedList`, `SplayTreeSet`, `UnmodifiableListView`) et utilitaires dans `package:collection` ([dart-ko.dev][2]).

---

## 🔁 5. `dart:convert`

* Conversion de données (JSON, UTF‑8, Base64…)
* Exemples :

  ```dart
  import 'dart:convert';

  var jsonStr = json.encode({'a': 1, 'b': true});
  var obj = json.decode('["foo", {"bar": 499}]');
  var bytes = utf8.encode('text');
  ```

  ([api.flutter.dev][6])

---

## 🔢 6. `dart:math`

* Constantes mathématiques, fonctions trigonométriques, RNG

  ```dart
  import 'dart:math';

  var r = Random();
  print(sqrt(16));    // 4.0
  print(r.nextInt(100)); // nombre aléatoire entre 0 et 99
  ```

---

## 🧩 7. `dart:typed_data`

* Tableaux à type fixe pour données binaires, performant pour buffer, fichiers, WebGL…
* e.g. `Uint8List`, `Float32List` ([dart.dev][1], [dart-ko.dev][2])

---

## 💾 8. `dart:io`

➡️ Disponible uniquement dans les environnements Dart VM (CLI, serveur, Flutter mobile/desktop) ([rm-dart.web.app][5]).

* Gère :

  * Fichiers, répertoires (`File`, `Directory`)
  * Sockets, WebSockets, processus
  * Clients et serveurs HTTP

**Exemple de lecture de fichier texte :**

```dart
import 'dart:io';

Future<void> main() async {
  var file = File('config.txt');
  var content = await file.readAsString();
  print('Length: ${content.length}');
}
```

---

## 🔄 9. `dart:isolate`

* Permet la parallélisation via des **isolats** (pas de mémoire partagée)
* Exécution parallèle :

  ```dart
  import 'dart:isolate';

  Future<void> main() async {
    final result = await Isolate.run(() => heavyComputation());
    print(result);
  }
  ```

---

## 🛠️ 10. `dart:ffi`

* Interface pour appeler des fonctions C (native),
* Utilisé pour intégrer des bibliothèques non Dart ([fr.wikipedia.org][7], [dart.dev][8], [en.wikipedia.org][3])

---

## ℹ️ Conclusion

Les bibliothèques cœur de Dart forment un socle robuste pour :

* le typage basique (`dart:core`)
* l’asynchronisme (`dart:async`)
* la manipulation de données (`dart:convert`, `dart:typed_data`)
* les calculs (`dart:math`)
* les E/S & concurrence (via `dart:io`, `dart:isolate`)
* l’interopérabilité native (`dart:ffi`)

Chacune de ces libs est solide et adaptée à ses usages prioritaires en fonction des plateformes (web vs VM).

---


[1]: https://dart.dev/libraries?utm_source=chatgpt.com "Dart's core libraries"
[2]: https://dart-ko.dev/guides/libraries?utm_source=chatgpt.com "Core libraries - Dart 프로그래밍 언어"
[3]: https://en.wikipedia.org/wiki/Dart_%28programming_language%29?utm_source=chatgpt.com "Dart (programming language)"
[4]: https://api.dart.dev/dart-core/?utm_source=chatgpt.com "dart:core library"
[5]: https://rm-dart.web.app/articles/libraries/dart-io?utm_source=chatgpt.com "An introduction to the dart:io library"
[6]: https://api.flutter.dev/flutter/dart-convert/?utm_source=chatgpt.com "dart:convert library - Flutter API"
[7]: https://fr.wikipedia.org/wiki/Dart_%28langage%29?utm_source=chatgpt.com "Dart (langage)"
[8]: https://dart.dev/libraries/dart-io?utm_source=chatgpt.com "dart:io"
