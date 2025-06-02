// Future et async/await

// Fonction asynchrone simple
Future<String> getData() async {
  await Future.delayed(Duration(seconds: 2));  // Simulation d'attente
  return 'Données récupérées !';
}

// Utilisation avec async/await
void exampleAsync() async {
   print('Début de la récupération...');

   try {
     String result = await getData();
     print(result);
   } catch (e) {
      print('Erreur: $e');
   }

   print('Fin de la récupération.');
}

// Utilisation avec then/catchError
void examplePromise() {
  getData()
    .then((result) => print('Succès: $result'))
    .catchError((error) => print('Erreur: $error'));
}


// Gestion de Plusieurs Futures
Future<int> calculLent(int number) async {
  await Future.delayed(Duration(seconds: 1));
  return number * 2;
}

void exampleMany() async {
  // Exécution séquentielle
  print('=== Séquentiel ===');
  var begin = DateTime.now();

  int a = await calculLent(5);
  int b = await calculLent(10);
  int c = await calculLent(15);

  var end = DateTime.now();
  print('Résultats: $a, $b, $c');
  print('Temps: ${end.difference(begin).inSeconds}s');

  // Exécution parallèle
  print('=== Parallèle ===');
  begin = DateTime.now();

  List<int> results = await Future.wait([
    calculLent(5),
    calculLent(10),
    calculLent(15)
  ]);

  end = DateTime.now();
  print('Résultats: $results');
  print('Temps: ${end.difference(begin).inSeconds}s');
}


// Streams 
// Création d'un stream 
Stream<int> countTo(int max) async* {
  for (int i = 0; i <= max; i++) {
    await Future.delayed(Duration(milliseconds: 500));
    yield i; // Émet une valeur
  }
}

// Consommation d'un stream
void exampleStream() async {
   print('Début du comptage...');

   await for (int number in countTo(5)) {
    print('Nombre: $number');
   }

   print('Comptage terminé !');
}

// Stream avec écoute
void exampleStreamListen() {
  var stream = countTo(3);

  var subscription = stream.listen(
    (number) => print('Reçu: $number'),
    onError: (error) => print('Erreur: $error'),
    onDone: () => print('Stream terminé'),
  );

  // Possibilité d'annuler l'écoute
  // subscription.cancel();
}


