import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text('Wordle')),
          body: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 400.0),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Centramos verticalmente el Column
              children: [
                Expanded(
                  // Asegura que el CardsGrid use el espacio disponible
                  child:
                      CardsGrid(), // Incluye CardsGrid directamente en el Column
                ),
              ],
            ),
          )),
    );
  }
}

class CardsGrid extends StatefulWidget {
  const CardsGrid({super.key});

  @override
  _CardsGridState createState() => _CardsGridState();
}

class _CardsGridState extends State<CardsGrid> {
  // Lista que almacena los colores iniciales de cada Card
  final List<Color> _cardColors = List<Color>.generate(
      30, (index) => const Color.fromARGB(255, 228, 230, 233));

  final List<String> _cardLetters = List<String>.generate(30, (index) => '');

  // Método para cambiar dinámicamente el color de una tarjeta
  void changeCardColor(int index, int state) {
    var cardStates = {
      0: const Color.fromARGB(255, 255, 255, 255),
      1: const Color(0xFFa4aec4),
      2: const Color(0xFFf3c237),
      3: const Color(0xFF79b851),
    };

    if (cardStates.containsKey(state)) {
      setState(() {
        _cardColors[index] = cardStates[state]!;
      });
    } else {
      //print('Error changing card states.');
    }
  }

  void changeCardText(int index, String letter) {
    setState(() {
      _cardLetters[index] = letter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
      ),
      itemCount: _cardColors.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          // La funcion onTap es para testear.
          onTap: () => {changeCardText(index, 'A')},
          onDoubleTap: () => {changeCardColor(index, 2)},
          child: Card(
            color: _cardColors[index],
            child: SizedBox(
              child: Center(
                child: Text(
                  _cardLetters[index],
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(fontSize: 35)
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
