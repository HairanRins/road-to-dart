# Control Flow
---

## 🧭 Introduction

Les structures de contrôle en Dart permettent de gérer l'ordre d'exécution des instructions dans un programme. Elles incluent :([scaler.com][1])

* Les **instructions conditionnelles** : `if`, `else`, `switch`
* Les **boucles** : `for`, `while`, `do-while`, `for-in`
* Les **instructions de saut** : `break`, `continue`, `return`, `throw`
* Les **assertions** : `assert`

---

## 🔹 1. Instructions conditionnelles

### a. `if`, `else if`, `else`

Permettent d'exécuter des blocs de code en fonction de conditions.

```dart
if (temperature < 10) {
  print("Very Cold");
} else if (temperature <= 20) {
  print("Cold");
} else {
  print("Warm");
}
```

### b. `if-case` (Dart 3.0+)

Permet de faire correspondre une valeur à un motif spécifique.

```dart
if (pair case [int x, int y]) {
  print('Coordinates: $x, $y');
} else {
  print('Invalid pair');
}
```

### c. `switch` et `switch-case`

Permet de comparer une expression à plusieurs valeurs possibles.

```dart
switch (fruit) {
  case 'Apple':
    print('Apple is good for health');
    break;
  case 'Banana':
    print('Banana is rich in potassium');
    break;
  default:
    print('Unknown fruit');
}
```

Note : Depuis Dart 3.0, l'utilisation de `break` est facultative si chaque `case` contient un bloc de code.

---

## 🔁 2. Boucles

### a. `for` loop

Utilisée pour exécuter un bloc de code un nombre déterminé de fois.

```dart
for (var i = 0; i < 5; i++) {
  print('Iteration $i');
}
```

### b. `for-in` loop

Itère sur les éléments d'une collection.

```dart
for (var item in items) {
  print(item);
}
```

### c. `while` loop

Exécute un bloc tant qu'une condition est vraie.

```dart
while (condition) {
  // code
}
```

### d. `do-while` loop

Exécute un bloc au moins une fois, puis répète tant qu'une condition est vraie.

```dart
do {
  // code
} while (condition);
```

---

## ⏹️ 3. Instructions de saut

### a. `break`

Interrompt la boucle ou le `switch` en cours.

```dart
for (var i = 0; i < 10; i++) {
  if (i == 5) break;
  print(i);
}
```

### b. `continue`

Passe immédiatement à l'itération suivante de la boucle.

```dart
for (var i = 0; i < 10; i++) {
  if (i % 2 == 0) continue;
  print(i);
}
```

### c. `return`

Quitte immédiatement une fonction et retourne une valeur.([medium.com][2])

```dart
int sum(int a, int b) {
  return a + b;
}
```

### d. `throw`

Lance une exception.

```dart
void checkAge(int age) {
  if (age < 18) {
    throw Exception('Underage');
  }
}
```

---

## 🧪 4. Assertions

Utilisées pour vérifier des conditions pendant le développement.

```dart
assert(age >= 0, 'Age cannot be negative');
```

Si la condition est fausse, une exception est levée.

---

## 📌 5. Autres concepts

### a. Étiquettes (`labels`)

Permettent de nommer des boucles pour un contrôle plus précis avec `break` et `continue`.

```dart
outerLoop:
for (var i = 0; i < 3; i++) {
  for (var j = 0; j < 3; j++) {
    if (i == j) continue outerLoop;
    print('i: $i, j: $j');
  }
}
```

### b. Expressions conditionnelles

Utilisent l'opérateur ternaire pour des conditions simples.

```dart
var result = (score >= 50) ? 'Pass' : 'Fail';
```

---

## 📚 Ressources supplémentaires

* [Documentation officielle sur les branches en Dart](https://dart.dev/language/branches)
* [Documentation officielle sur les boucles en Dart](https://dart.dev/language/loops)
* [Article sur les structures de contrôle en Dart](https://medium.com/@sadanandgadwal/dart-control-flow-from-if-else-to-loops-and-more-part-2-5350f5268cf7)

---

[1]: https://www.scaler.com/topics/flutter-tutorial/flow-control-in-dart/?utm_source=chatgpt.com "Flow Control in Dart - Scaler Topics"
[2]: https://medium.com/%40sadanandgadwal/dart-control-flow-from-if-else-to-loops-and-more-part-2-5350f5268cf7?utm_source=chatgpt.com "Dart Control Flow Statement — Part 2 | by Sadanand Gadwal | Medium"
