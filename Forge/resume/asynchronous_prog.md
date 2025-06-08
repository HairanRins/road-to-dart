# **La programmation asynchrone (*Asynchronous programming*) en Dart**
---

## 🧠 1. Modèle *Event Loop* & Asynchronisme

* Dart fonctionne sur une **unique boucle d’événements** (*event loop*) par *isolate* : les opérations asynchrones sont planifiées, puis traitées l’une après l’autre lorsque le thread est libre ([stackoverflow.com][2]).
* Cela permet de ne jamais bloquer l’exécution du programme, même lors d’opérations longues (I/O, timers, etc.)

---

## 2. `Future<T>` : gestion d’une valeur asynchrone unique

* Représente une opération qui **n’est pas encore terminée**, mais qui livrera **un résultat ou une erreur** plus tard ([dart.cn][3], [api.flutter.dev][4]).

### a. Création & utilisation

* Exemple classique :

  ```dart
  Future<String> fetchData() async {
    await Future.delayed(Duration(seconds: 1));
    return 'Hello';
  }
  ```
* Deux manières de traiter le résultat :

  * Avec `then()`/`catchError()` :

    ```dart
    fetchData()
        .then((v) => print(v))
        .catchError((e) => print('Error: $e'));
    ```
  * Avec `await` dans une fonction `async` :

    ```dart
    Future<void> main() async {
      try {
        var v = await fetchData();
        print(v);
      } catch (e) {
        print('Error: $e');
      }
    }
    ```

---

## 3. `async` / `await` : syntaxe plus lisible

* Une fonction préfixée `async` retourne automatiquement un `Future<T>` ([dart.dev][5]).
* `await` suspend l'exécution jusqu’à ce que le `Future` soit complété.
* On peut **enchaîner plusieurs `await`** séquentiellement.
* Exemples :

  ```dart
  Future<void> process() async {
    var v1 = await f1();
    var v2 = await f2(v1);
    await f3(v2);
  }
  ```
* L’erreur est capturée via `try/catch` dans un bloc `async` ([dart.dev][5], [stackoverflow.com][6], [dart.dev][7]).

---

## 4. `Stream<T>` : suite d’événements asynchrones

* Modélise une **séquence de données** qui arrive dans le temps (clics, données I/O…) .

### a. Utilisation avec `await for`

```dart
Stream<int> counter(int max) async* {
  for (int i = 1; i <= max; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}

Future<void> main() async {
  await for (var n in counter(5)) {
    print(n); // 1,2,3,4,5
  }
}
```

* Permet d’itérer proprement, avec prise en charge d’erreur (via `try/catch`) .

### b. Utilisation en event-driven avec `listen()`

```dart
counter(3).listen(
  (v) => print('Value: $v'),
  onError: (e) => print('Error: $e'),
  onDone: () => print('Stream closed'),
);
```

* Offre des callbacks précis : `onData`, `onError`, `onDone`, contrôle avec `cancel()` sur la souscription.

---

## 5. Comparaison : `Future` vs `Stream`

| Concept   | Future<T>                      | Stream<T>                              |
| --------- | ------------------------------ | -------------------------------------- |
| Valeur    | Une seule (résultat ou erreur) | Suite de valeurs & erreurs             |
| Usage     | Résultat isolé                 | Événements multiples / flux de données |
| itération | `await` ou `then()`            | `await for` ou `listen()`              |

---

## 6. Erreurs & gestion

* **Futures** : non capturées génèrent un Future rejeté, à attraper avec `catchError` ou `try/catch` dans `async`.
* **Streams** : les erreurs déclenchent des événements `onError`; avec `await for`, elles provoquent une exception à envelopper dans `try/catch` ([dart.dev][1], [dart.cn][3]).

---

## 7. Cas pratiques

### a. Charger et traiter un fichier ligne par ligne

```dart
import 'dart:io';
import 'dart:convert';

Future<void> main() async {
  var file = File('log.txt');
  var stream = file.openRead().transform(utf8.decoder).transform(LineSplitter());
  await for (var line in stream) {
    print('Line: $line');
  }
}
```

### b. Requêtes HTTP séquentielles

```dart
Future<void> syncRequests() async {
  try {
    var resp1 = await http.get(Uri.parse('https://example.com/1'));
    var resp2 = await http.get(Uri.parse('https://example.com/2?data=${resp1.body}');
    print(resp2.body);
  } catch (e) {
    print('Error: $e');
  }
}
```

---

## ✅ Points à retenir

* **Modèle basé sur l’event loop** : asynchronisme non bloquant.
* **`Future<T>`** : valeur asynchrone unique.
* **`async`/`await`** : syntaxe claire et lisible pour séquencer des opérations.
* **`Stream<T>`** : flux de plusieurs événements.
* **Gestion d’erreurs** : `catchError` et `try/catch` dans `async`, `onError` ou `try/catch` pour les streams.
* **Utilisation combinée** : `Future`s et `Stream`s sont complémentaires, et essentiels pour créer des applications réactives, performantes et non bloquantes.

---

[1]: https://dart.dev/libraries/async/using-streams?utm_source=chatgpt.com "Asynchronous programming: Streams - Dart"
[2]: https://stackoverflow.com/questions/77106651/how-does-dart-run-asynchronous-code-like-future-and-stream-if-is-single-thread?utm_source=chatgpt.com "How does Dart run asynchronous code like Future and Stream if is ..."
[3]: https://dart.cn/libraries/dart-async/?utm_source=chatgpt.com "dart:async - Dart 中文文档"
[4]: https://api.flutter.dev/flutter/dart-async/?utm_source=chatgpt.com "dart:async library - Flutter API"
[5]: https://dart.dev/language/async?utm_source=chatgpt.com "Asynchronous programming - Dart"
[6]: https://stackoverflow.com/questions/28238161/how-to-make-an-asynchronous-dart-call-synchronous?utm_source=chatgpt.com "How to make an asynchronous Dart call synchronous?"
[7]: https://dart.dev/libraries/async/async-await?utm_source=chatgpt.com "Asynchronous programming: futures, async, await - Dart"
