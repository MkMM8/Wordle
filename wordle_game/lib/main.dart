import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wordle Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WordleGameScreen(),
    );
  }
}

class WordleGameScreen extends StatefulWidget {
  @override
  _WordleGameScreenState createState() => _WordleGameScreenState();
}

class _WordleGameScreenState extends State<WordleGameScreen> {
  Timer? _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _formattedTime {
    int minutes = _seconds ~/ 60;
    int seconds = _seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Palabros',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(181, 250, 62, 0),
        elevation: 5,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _formattedTime,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/palabros_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: CardsGrid(),
          ),
        ],
      ),
    );
  }
}

class CardsGrid extends StatefulWidget {
  const CardsGrid({super.key});

  @override
  _CardsGridState createState() => _CardsGridState();
}

class _CardsGridState extends State<CardsGrid> {
  final List<Color> _cardColors = List<Color>.generate(
      30, (index) => const Color.fromARGB(255, 228, 230, 233));
  final List<String> _cardLetters = List<String>.generate(30, (index) => '');

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
    }
  }

  void changeCardText(int index, String letter) {
    setState(() {
      _cardLetters[index] = letter;
    });
  }

  @override
  Widget build(BuildContext context) {
  return GridView.count(
    padding: const EdgeInsets.all(10),
    crossAxisCount: 5,
    crossAxisSpacing: 2,
    mainAxisSpacing: 2,
    children: List.generate(_cardColors.length, (index) {
      return GestureDetector(
        onTap: () => {changeCardText(index, 'A')},
        onDoubleTap: () => {changeCardColor(index, 2)},
        child: Card(
          color: _cardColors[index],
          child: SizedBox(
            height: 30,
            width: 30,
            child: Center(
              child: Text(
                _cardLetters[index],
                maxLines: 1,
                overflow: TextOverflow.fade,
                style: const TextStyle(fontSize: 35),
              ),
            ),
          ),
        ),
      );
    }),
  );
}
}