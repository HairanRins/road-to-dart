# **Fonctions (*Functions*) en Dart**
---

## 1. Définition d’une fonction

```dart
bool isNoble(int atomicNumber) {
  return _nobleGases[atomicNumber] != null;
}
```

* **Déclaration :** `[returnType] functionName(parameters) { body }`
* `{}` englobe le corps de la fonction ; `return` renvoie une valeur (sauf si `void`).
* La fonction peut être top-level, méthode d'instance ou statique. ([tutorialspoint.com][2], [dart.dev][3])

---

## 2. Fonctions de première classe

* **Fonctions sont des objets** : on peut les assigner à une variable, les passer en paramètre, ou les retourner.

```dart
void printElement(int element) {
  print(element);
}
var list = [1, 2, 3];
list.forEach(printElement);
```

* Exemple d’assignation à une variable :

```dart
var loudify = (msg) => '!!! ${msg.toUpperCase()} !!!';
assert(loudify('hello') == '!!! HELLO !!!');
```

([dart.dev][4])

---

## 3. Types de fonctions

```dart
void greet(String name, {String greeting = 'Hello'}) =>
  print('$greeting $name!');

void Function(String, {String greeting}) g = greet;
g('Dash', greeting: 'Howdy');
```

* Les **function types** permettent de typer précisément les signatures.
* On peut utiliser `typedef` pour réutilisabilité. ([dart.dev][4])

---

## 4. Fonctions anonymes (*anonymous*)

* **Fonctions sans nom** (lambdas ou closures) :

```dart
const list = ['apples', 'bananas', 'oranges'];
var uppercaseList = list.map((item) {
  return item.toUpperCase();
}).toList();
```

* Codées directement dans des appels comme `map` ou `forEach`. ([dart.dev][4])

---

## 5. Syntaxe abrégée (arrow functions)

* Si une fonction ne contient qu’une seule expression, on peut utiliser :

```dart
int add(int a, int b) => a + b;
```

* Version courte et expressive, utile pour assignations ou retours simples.&#x20;

---

## 6. Paramètres : positionnels, nommés et optionnels

* **Positionnels requis :**

```dart
int sum(int a, int b) => a + b;
```

* **Només optionnels avec valeurs par défaut :**

```dart
void greet(String name, {String greeting = 'Hello'}) {
  print('$greeting $name');
}
```

* **Positionnels optionnels :**

```dart
void doSomething(int a, [int? b]) {
  print(a, b);
}
```

([geeksforgeeks.org][5])

---

## 7. Valeur retournée

* `void` : pas de retour.
* Sinon, la fonction doit inclure `return`.
* Fonction générique ou typée : retourne un type donné.

---

## 8. Scope lexical et closures

* Les fonctions peuvent être **imbriquées** (nested), capturant l’environnement extérieur :

```dart
int Function(int) makeMultiplier(int multiplier) {
  return (int value) => value * multiplier;
}
var doubler = makeMultiplier(2);
print(doubler(4)); // 8
```

* Permet la création de fermetures (*closures*). ([dart.dev][6])

---

## 9. Tear-offs

* Vous pouvez capturer une référence à une méthode directement :

```dart
var func = myObject.myMethod;
```

* Utilisable là où une fonction est attendue, sans écrire `()`. ([stackoverflow.com][7], [dart.dev][4])

---

## 10. Fonctions génératrices (*Generators*)

* **Sync\*** et **async\*** retournent des *iterables* ou *streams* :

```dart
Iterable<int> naturalsTo(int n) sync* {
  for (int i = 1; i <= n; i++) {
    yield i;
  }
}
```

---

## 11. Fonctions externes

* Déclarées avec le mot-clé `external`, permettant l’implémentation en natif ou via FFI.

---

## 12. Tests d’égalité

* Comparaison possible de références de fonctions : deux fonctions sont égales si elles réfèrent exactement au même objet/fonction.&#x20;

---

### 🧩 Récapitulatif des points clés :

| Concept                  | Description claire                                         |
| ------------------------ | ---------------------------------------------------------- |
| First-class functions    | Fonctions peuvent être stockées, passées, retournées       |
| Function types & typedef | Pour typer précisément les signatures                      |
| Anonymous & arrow syntax | Fonctions inline et syntaxe concise                        |
| Paramètres variés        | Requis, optionnels, nommés, avec ou sans valeur par défaut |
| Closures & lexical scope | Accès aux variables de la portée englobante                |
| Generators & external    | Créent des *iterables*/streams et implémentation externe   |
| Tear-offs & equality     | Capturer des références & comparer fonctions               |

---

[1]: https://stackoverflow.com/questions/72969905/how-to-make-use-of-the-dart-documentation-on-the-official-dart-website?utm_source=chatgpt.com "How to make use of the Dart Documentation on the Official Dart ..."
[2]: https://www.tutorialspoint.com/dart_programming/dart_programming_functions.htm?utm_source=chatgpt.com "Dart Programming - Functions - Tutorialspoint"
[3]: https://dart.dev/language?utm_source=chatgpt.com "Introduction to Dart"
[4]: https://dart.dev/language/functions?utm_source=chatgpt.com "Functions - Dart"
[5]: https://www.geeksforgeeks.org/dart-programming-functions/?utm_source=chatgpt.com "Dart – Functions - GeeksforGeeks"
[6]: https://dart.dev/effective-dart/documentation?utm_source=chatgpt.com "Effective Dart: Documentation"
[7]: https://stackoverflow.com/questions/53562578/what-is-the-difference-between-function-and-method-in-dart-programming-language?utm_source=chatgpt.com "What is the difference between Function and Method in Dart ..."
