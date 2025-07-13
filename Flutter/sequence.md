# Enchaînement clair et structuré du développement d'une application mobile Flutter

Voici un **enchaînement clair et structuré du développement d'une application mobile Flutter**, étape par étape, avec **exemples pratiques et concrets** + un **flow visuel** (textuel) pour que tu puisses suivre la logique de bout en bout.
Ce guide est adapté aussi bien à un projet personnel qu’à une application professionnelle.

---

### ✅ 1. **Idéation et planification**

**But :** Clarifier ce que tu veux construire et comment.

**Exemple concret :**

> Tu veux créer une app de To-Do + Pomodoro pour t’organiser.

**Actions :**

- Définir les features principales (To-do, Timer, Notes…)
- Créer des user stories :

  - “En tant qu’utilisateur, je peux ajouter une tâche”
  - “En tant qu’utilisateur, je peux démarrer un minuteur Pomodoro”

---

### ✅ 2. **Création du projet Flutter**

```bash
flutter create todo_pomodoro_app
cd todo_pomodoro_app
```

**Structure de base :**

```
lib/
├── main.dart
├── screens/
├── widgets/
├── models/
├── services/
├── utils/
```

---

### ✅ 3. **Maquettage UI (Wireframe rapide)**

**But :** Visualiser l’application

**Exemple :** Figma ou sur papier :

- Page d’accueil : Liste des tâches
- Bouton “Ajouter tâche”
- Onglet “Pomodoro” avec un minuteur

---

### ✅ 4. **Création des écrans de base (UI)**

**Exemple code rapide pour liste de tâches :**

```dart
class Task {
  final String title;
  bool isDone;

  Task({required this.title, this.isDone = false});
}
```

```dart
class TodoListScreen extends StatelessWidget {
  final List<Task> tasks = [
    Task(title: "Lire 10 pages"),
    Task(title: "Faire 1 Pomodoro"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mes tâches")),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (_, index) {
          return CheckboxListTile(
            title: Text(tasks[index].title),
            value: tasks[index].isDone,
            onChanged: (value) {
              tasks[index].isDone = value!;
            },
          );
        },
      ),
    );
  }
}
```

---

### ✅ 5. **Navigation entre les écrans (Routing)**

**Avec `Navigator.push` ou `GoRouter` (plus moderne)**

```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => AddTaskScreen()),
);
```

---

### ✅ 6. **Ajout du Timer Pomodoro**

**Utilisation de `Timer.periodic` :**

```dart
class PomodoroTimer extends StatefulWidget {
  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  int seconds = 1500; // 25 min
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds == 0) {
        _timer!.cancel();
      } else {
        setState(() => seconds--);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("${(seconds ~/ 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}"),
        ElevatedButton(onPressed: startTimer, child: Text("Start"))
      ],
    );
  }
}
```

---

### ✅ 7. **Stockage local (persistance)**

**Avec `shared_preferences` ou `flutter_secure_storage` :**

```yaml
dependencies:
  shared_preferences: ^2.0.15
```

```dart
final prefs = await SharedPreferences.getInstance();
prefs.setBool("isFirstOpen", false);
```

---

### ✅ 8. **Ajout de fonctionnalités secondaires**

- Notifications (plugin : `flutter_local_notifications`)
- Dark mode
- Réorganisation des tâches
- Statistiques de productivité

---

### ✅ 9. **Tests unitaires & widget tests**

**Avec `flutter_test` :**

```dart
test('Task should toggle state', () {
  final task = Task(title: "Test");
  task.isDone = !task.isDone;
  expect(task.isDone, true);
});
```

---

### ✅ 10. **Génération d’APK ou AAB pour Android**

```bash
flutter build apk --release
flutter build appbundle --release
```

---

### ✅ 11. **Publication**

- **Play Store :** via Google Play Console
- **App Store :** via Xcode + compte développeur Apple

---

### 🔁 Flow global (résumé textuel) :

```
Idée ➝ Maquette ➝ Création projet Flutter ➝ UI de base ➝ Navigation ➝ Fonctionnalités ➝ Stockage local ➝ Tests ➝ Build ➝ Publication
```

---

### 📌 Bonus bonnes pratiques :

- Utilise `provider` ou `riverpod` pour la gestion d’état
- Découpe bien le code en composants (DRY)
- Évite la logique dans le `build()`
- Fais des commits fréquents
- Documente tes fonctions

---
