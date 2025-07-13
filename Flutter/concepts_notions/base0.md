# Différences entre _StatelessWidget_ et _StatefulWidget_

En Flutter, la principale différence entre un **`StatelessWidget`** et un **`StatefulWidget`** réside dans leur capacité à **gérer un état qui peut changer** au fil du temps.

- **`StatelessWidget` (Widget sans état)** : Il est **immuable**. Une fois construit, son apparence et les données qu'il contient ne peuvent pas changer. Pour toute modification, un nouveau widget doit être créé.

- **`StatefulWidget` (Widget avec état)** : Il est **dynamique**. Il peut être redessiné plusieurs fois au cours de sa vie pour refléter des changements dans son état interne, comme une interaction de l'utilisateur ou la réception de nouvelles données.

Voici une comparaison détaillée avec des cas d'usage et des exemples concrets.

---

## `StatelessWidget` (Sans état)

Un `StatelessWidget` est parfait pour les parties de votre interface utilisateur qui ne dépendent que des informations de configuration fournies lors de leur création. Pensez-y comme à une "photographie" de votre UI à un instant T.

#### **Cas d'usage fréquents**

- **Éléments d'interface statiques** : Icônes, textes, boutons avec une action fixe, logos, séparateurs.
- **Éléments de design** : Cartes décoratives, arrière-plans, éléments de mise en page qui ne changent jamais.
- **Écrans de présentation** : Un écran "À propos", des conditions d'utilisation, ou tout écran qui affiche simplement des informations.
- **Widgets réutilisables** : Créer des composants personnalisés comme un `CustomButton` ou un `ProfileAvatar` qui reçoivent leurs données de l'extérieur.

#### **Exemple d'usage concret : un bouton personnalisé**

C'est un cas d'école. Le bouton lui-même n'a pas besoin de savoir ce qui se passe après qu'on a cliqué dessus. Il reçoit juste un texte et une fonction à exécuter.

```dart
import 'package:flutter/material.dart';

// Un widget de bouton réutilisable et SANS état.
class CustomActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed; // La fonction à appeler lors du clic.

  // Les données sont passées via le constructeur.
  const CustomActionButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // La construction est simple et directe.
    // Pas de variables qui changent ici.
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
```

Dans cet exemple, `CustomActionButton` est un `StatelessWidget` car son apparence (`label`) et son comportement (`onPressed`) sont définis une fois pour toutes lors de sa création. Il ne gère aucun changement interne.

---

## `StatefulWidget` (Avec état)

Un `StatefulWidget` est utilisé lorsque l'interface utilisateur doit changer dynamiquement en réponse à des événements internes ou externes. Il est composé de deux classes : le widget lui-même (immuable) et son objet **`State`** (qui persiste et peut changer).

La magie opère avec la méthode **`setState()`**. Lorsque vous appelez cette fonction, vous signalez à Flutter que l'état interne a changé, et que le widget doit être redessiné pour refléter ce changement.

#### **Cas d'usage fréquents**

- **Interaction utilisateur** : Cases à cocher (`Checkbox`), champs de formulaire (`TextField`), sliders, interrupteurs (`Switch`).
- **Données qui se chargent** : Un écran qui affiche un indicateur de chargement (`CircularProgressIndicator`) puis affiche les données une fois qu'elles sont reçues d'une API.
- **Animations** : Tout ce qui bouge ou change de couleur/taille avec le temps.
- **Navigation avec état** : Un `BottomNavigationBar` où l'onglet sélectionné doit être mis en évidence.

#### **Exemple d'usage concret : un simple compteur de clics**

C'est l'exemple "Hello World" du `StatefulWidget`. Un compteur qui s'incrémente à chaque fois que l'on appuie sur un bouton.

```dart
import 'package:flutter/material.dart';

class ClickCounter extends StatefulWidget {
  const ClickCounter({Key? key}) : super(key: key);

  @override
  _ClickCounterState createState() => _ClickCounterState();
}

// L'objet State contient les données qui peuvent changer.
class _ClickCounterState extends State<ClickCounter> {
  // 1. Déclaration de la variable d'état.
  int _counter = 0;

  void _incrementCounter() {
    // 2. Appel de setState() pour notifier Flutter du changement.
    setState(() {
      // Toute modification de l'état doit se faire ici.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 3. Le build est appelé à chaque fois que setState est exécuté.
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('Nombre de clics :', style: TextStyle(fontSize: 20)),
        Text(
          '$_counter', // Affiche la valeur actuelle du compteur.
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _incrementCounter, // Appelle la méthode pour changer l'état.
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
```

Dans cet exemple :

1.  La variable `_counter` est l'**état**.
2.  La méthode `_incrementCounter` modifie cet état.
3.  L'appel à `setState()` déclenche la reconstruction du widget avec la nouvelle valeur de `_counter`, mettant ainsi l'interface à jour.

---

### Résumé : Quand utiliser lequel ?

| Caractéristique | `StatelessWidget`                             | `StatefulWidget`                                              |
| :-------------- | :-------------------------------------------- | :------------------------------------------------------------ |
| **État**        | ❌ **Immuable**                               | ✅ **Mutable** (peut changer)                                 |
| **Objectif**    | Afficher des données statiques                | Réagir aux interactions et aux changements de données         |
| **Méthode clé** | `build()`                                     | `createState()`, `build()`, `setState()`                      |
| **Cas d'usage** | `Icon`, `Text`, `RaisedButton`, écrans d'info | `Checkbox`, `TextField`, `Slider`, formulaires, écrans animés |
| **Analogie**    | Une photographie 🖼️                           | Un tableau blanc interactif 칠판                              |

En règle générale, **commencez toujours par un `StatelessWidget`**. Si vous vous rendez compte que votre widget a besoin de gérer des données qui changent, alors seulement convertissez-le en `StatefulWidget`. Cette approche favorise une architecture plus simple et plus performante.
