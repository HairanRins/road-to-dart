# **La *concurrence* (Concurrency) en Dart**

## 🧠 1. Modèle Event Loop

* Dart fonctionne avec un **event loop** (boucle d’événements) qui traite les événements un par un dans une **queue** ([dart.dev][1]).
* Cela permet de gérer les opérations asynchrones (I/O, UI, timers…) sans bloquer l’exécution principale.

**Illustration simplifiée** :

```dart
while (eventQueue.waitForEvent()) {
  eventQueue.processNextEvent();
}
```

---

## ⏳ 2. Programming Asynchrone

### 🔹 Future

* Représente le résultat d’une opération asynchrone (succès ou erreur) ([dhiwise.com][2]).

```dart
Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Hello';
}

void main() {
  fetchData().then((value) => print(value));
}
```

### 🔹 async / await

* Permet d’écrire du code asynchrone de façon **synchrone lisible** ([github.com][3]).

```dart
Future<String> _readFileAsync(String file) async {
  // simulate file reading...
  return 'file content';
}

Future<void> main() async {
  final contents = await _readFileAsync('data.txt');
  print(contents);
}
```

---

## 🔁 3. Streams

* Un **Stream** produit des événements sur le temps, comme des clics ou des données réseau ([dart.dev][4]).
* Type : `Stream<int>` (suite de `int` asynchrones).

**Exemples** :

* **await-for** :

  ```dart
  Stream<int> count(int to) async* {
    for (int i = 1; i <= to; i++) {
      yield i;
    }
  }

  Future<void> main() async {
    await for (final n in count(5)) {
      print(n); // 1,2,3,4,5
    }
  }
  ```

* **listen()** :

  ```dart
  count(3).listen(
    (data) => print(data),
    onError: (e) => print('Error: $e'),
    onDone: () => print('Done'),
  );
  ```

* **Transformations** : `map`, `where`, `timeout`, `handleError`, etc. ([dart.dev][4]).

---

## 🧩 4. Isolates (concurrence d’exécution)

* Les **isolats** sont des unités d’exécution séparées : chacune possède sa **mémoire** et son **event loop**, sans partage d’état direct ([dart.dev][1]).
* Commencent dans le **main isolate**, puis peuvent créer des isolats supplémentaires pour décharger des tâches lourdes ([nimafarzin-pr.medium.com][5]).

### ⚙️ Création et communication

* **Isolate.run** (une tâche isolée unique) :

  ```dart
  import 'dart:isolate';

  Future<void> main() async {
    final result = await Isolate.run(() => heavyComputation(1000000));
    print(result);
  }
  ```

* **Isolate.spawn** et Ports (pour tâches longues) :

  ```dart
  import 'dart:isolate';

  void worker(SendPort sendPort) {
    sendPort.send('Hello from worker');
  }

  Future<void> main() async {
    final receivePort = ReceivePort();
    await Isolate.spawn(worker, receivePort.sendPort);
    receivePort.listen((msg) {
      print(msg); // Hello from worker
      receivePort.close();
    });
  }
  ```

* Limitation : communication uniquement par **message passing**, pas de mémoire partagée ([nimafarzin-pr.medium.com][5]).

> ⚠️ Note importante : sur le Web (Flutter Web), les isolates ne sont pas disponibles – on utilise à la place des **Web Workers**, ou `compute()`, qui passe la tâche sur le thread principal ([dart.dev][1]).

---

## 🎯 5. Résumé des points clés

| Concept         | Usage / Avantage                                   |
| --------------- | -------------------------------------------------- |
| **Event loop**  | Boucle centralisée traitant les tâches asynchrones |
| **Future**      | Un résultat asynchrone unique                      |
| **async/await** | Ecriture claire et séquentielle                    |
| **Stream**      | Suite de données asynchrones                       |
| **Isolate**     | Exécution parallèle réelle, mémoire isolée         |

---

## Pourquoi utiliser la concurrence ?

1. **UI fluide** : Data load ou I/O se font sans bloquer l’affichage.
2. **Scalabilité** : Les isolats profitent des coeurs multiples.
3. **Sécurité** : Pas de conditions de course, puisque pas de mémoire partagée.
4. **Modularité** : Separation des tâches CPU-intensives et UI.

---

## Exemple complet

```dart
import 'dart:isolate';
import 'dart:async';

// heavy task
int fibonacci(int n) {
  return (n < 2) ? n : fibonacci(n - 1) + fibonacci(n - 2);
}

Future<void> main() async {
  // 1️⃣ Asynchrone simple
  Future<int> delayedValue = Future.delayed(Duration(seconds: 1), () => 42);
  print(await delayedValue); // 42

  // 2️⃣ Stream
  Stream<int> s = Stream.periodic(Duration(milliseconds: 500), (i) => i);
  final sub = s.listen((val) {
    print('Stream val: $val');
    if (val >= 2) sub.cancel();
  });

  // 3️⃣ Isolate pour tâche lourde
  final result = await Isolate.run(() => fibonacci(20));
  print('Fib(20) = $result');
}
```

---

[1]: https://dart.dev/language/concurrency?utm_source=chatgpt.com "Concurrency | Dart"
[2]: https://www.dhiwise.com/post/mastering-dart-concurrency-a-comprehensive-guide?utm_source=chatgpt.com "Taking Your Apps to the Next Level with Dart Concurrency - DhiWise"
[3]: https://github.com/dart-lang/language/blob/main/working/333%20-%20shared%20memory%20multithreading/proposal.md?utm_source=chatgpt.com "Shared Memory Multithreading for Dart - GitHub"
[4]: https://dart.dev/libraries/async/using-streams?utm_source=chatgpt.com "Asynchronous programming: Streams - Dart"
[5]: https://nimafarzin-pr.medium.com/concurrency-and-isolates-in-flutter-and-dart-81d6a36932e8?utm_source=chatgpt.com "Concurrency and Isolates in Flutter and Dart | by Nima Farzin | Medium"
