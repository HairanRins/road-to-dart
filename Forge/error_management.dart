// Try-Catch-Finally
void exampleManageErrors() {
  try {
    int result = divise(10, 0);
    print('Résultat: $result');
  } catch (e) {
    print('Erreur capturée: $e');
  } finally {
    print('Cette section s\'exécute toujours');
  }
}

int divise(int a, int b) {
  if (b == 0) {
    throw ArgumentError('Division par zéro impossible');
  }
  return a ~/ b;
}

// Gestion spécifique d'exceptions
void manageSpecific() {
  try {
    // Code potentiellement problématique
    var liste = [1, 2, 3];
    print(liste[10]); // Index hors limites
  } on RangeError catch (e) {
    print('Erreur d\'index: $e');
  } on ArgumentError catch (e) {
    print('Erreur d\'argument: $e');
  } catch (e, stackTrace) {
    print('Autre erreur: $e');
    print('Stack trace: $stackTrace');
  }
}

// Exceptions Personnalisées
class AgeInvalidException implements Exception {
  final String message;

  AgeInvalidException(this.message);

  @override
  String toString() => 'AgeInvalidException: $message';
}

void validAge(int age) {
  if (age < 0 || age > 150) {
    throw AgeInvalidException('L\'âge doit être entre 0 et 150 ans');
  }
}

// Utilisation 
void main() {
  try {
    validAge(-5);
  } catch (e) {
    print(e); // AgeInvalideException: L'âge doit être entre 0 et 150 ans
  }
}