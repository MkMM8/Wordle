//palabras.dart
import 'dart:math';
class PalabrasdeCinco {
  static const List<String> palabras= [
    'abaco',
    'banco',
    'cacao',
    'rueda',
    'libro',
    'feliz',
    'gatos',
  ] ;
  

//metodo
static String obtenerPalabras() {
    var index = Random().nextInt(palabras.length);
    return palabras[index];
  }
}