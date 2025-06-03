// Importations en haut du fichier
import 'dart:math';
import 'dart:convert';

// Classes utilitaires 
class MathUtils {
  static double calculateDistance(double x1, double y1, double x2, double y2) {
    return sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));
  }

  static bool isPairs(int number) {
    return number % 2 == 0;
  }
}

 // Utilisation d'extensions
  extension stringExtension on String {
    bool get isEmail => contains('@') && contains('.');

    String get capitalize {
      if (isEmpty) {
        return ''; 
      } else {
        return '${this[0].toUpperCase()}${substring(1)}';
      }
    }
  }

void exampleOrganization() {
  double distance = MathUtils.calculateDistance(0, 0, 3, 4);
  print('Distance: $distance'); // 5.0

   String email = 'test@example.com';
   print('Est un email: ${email.isEmail}'); // true

   String name = 'John Doe';
   print('Capitalize: ${name.capitalize}'); // John Doe
}