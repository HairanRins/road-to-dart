// Utilisation de try-finally pour la gestion des ressources
import 'dart:io';

void readFile(String path) async {
  File? file;
  try {
    file = File(path);
    String content = await file.readAsString();
    print('Contenu: $content');
  } catch (e) {
    print('Erreur de lecture: $e');
  } finally {
    // Nettoyage si nécessaire
    print('Opération de lecture terminée');
  }
}

// Pattern dispose pour les ressources
abstract class Disposable {
  void dispose();
}

class ManageResource implements Disposable {
  bool _isDispose = false;

  void useResource() {
    if (_isDispose) {
      throw StateError('Ressource déjà libérée');
    }
    print('Utilisation de la ressource...');
  }
   @override
  void dispose() {
    if (!_isDispose) {
      print('Libération de la ressource...');
      _isDispose = true;
    }
  }
}