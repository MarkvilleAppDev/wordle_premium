import 'package:flutter/material.dart';
import 'main.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'package:path/path.dart' as p;
import 'dart:math';
import 'package:collection/collection.dart';

// other Screens
class DailyC extends StatefulWidget {
  @override
  _DailyCState createState() => _DailyCState();
}

class _DailyCState extends State<DailyC> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    List<Widget> buttonArr = [
      LetterButton(
        letter: 'Q',
        buttonColor: KeyboardDisplay._buttonCol[0],
      ),
      LetterButton(
        letter: 'W',
        buttonColor: KeyboardDisplay._buttonCol[1],
      ),
      LetterButton(
        letter: 'E',
        buttonColor: KeyboardDisplay._buttonCol[2],
      ),
      LetterButton(
        letter: 'R',
        buttonColor: KeyboardDisplay._buttonCol[3],
      ),
      LetterButton(
        letter: 'T',
        buttonColor: KeyboardDisplay._buttonCol[4],
      ),
      LetterButton(
        letter: 'Y',
        buttonColor: KeyboardDisplay._buttonCol[5],
      ),
      LetterButton(
        letter: 'U',
        buttonColor: KeyboardDisplay._buttonCol[6],
      ),
      LetterButton(
        letter: 'I',
        buttonColor: KeyboardDisplay._buttonCol[7],
      ),
      LetterButton(
        letter: 'O',
        buttonColor: KeyboardDisplay._buttonCol[8],
      ),
      LetterButton(
        letter: 'P',
        buttonColor: KeyboardDisplay._buttonCol[9],
      ),
      LetterButton(
        letter: 'A',
        buttonColor: KeyboardDisplay._buttonCol[10],
      ),
      LetterButton(
        letter: 'S',
        buttonColor: KeyboardDisplay._buttonCol[11],
      ),
      LetterButton(
        letter: 'D',
        buttonColor: KeyboardDisplay._buttonCol[12],
      ),
      LetterButton(
        letter: 'F',
        buttonColor: KeyboardDisplay._buttonCol[13],
      ),
      LetterButton(
        letter: 'G',
        buttonColor: KeyboardDisplay._buttonCol[14],
      ),
      LetterButton(
        letter: 'H',
        buttonColor: KeyboardDisplay._buttonCol[15],
      ),
      LetterButton(
        letter: 'J',
        buttonColor: KeyboardDisplay._buttonCol[16],
      ),
      LetterButton(
        letter: 'K',
        buttonColor: KeyboardDisplay._buttonCol[17],
      ),
      LetterButton(
        letter: 'L',
        buttonColor: KeyboardDisplay._buttonCol[18],
      ),
      EntButton(),
      LetterButton(
        letter: 'Z',
        buttonColor: KeyboardDisplay._buttonCol[20],
      ),
      LetterButton(
        letter: 'X',
        buttonColor: KeyboardDisplay._buttonCol[21],
      ),
      LetterButton(
        letter: 'C',
        buttonColor: KeyboardDisplay._buttonCol[22],
      ),
      LetterButton(
        letter: 'V',
        buttonColor: KeyboardDisplay._buttonCol[23],
      ),
      LetterButton(
        letter: 'B',
        buttonColor: KeyboardDisplay._buttonCol[24],
      ),
      LetterButton(
        letter: 'N',
        buttonColor: KeyboardDisplay._buttonCol[25],
      ),
      LetterButton(
        letter: 'M',
        buttonColor: KeyboardDisplay._buttonCol[26],
      ),
      DelButton()
    ];

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            // restarts game
            return IconButton(
              icon: const Icon(Icons.arrow_circle_left),
              onPressed: () {
                //reset all values
                LetterDisplay._letterPointer = 0;
                LetterDisplay._charGrid =
                    List<String>.filled(30, '', growable: false);
                LetterDisplay._guessGrid =
                    List<String>.filled(30, '', growable: false);
                LetterDisplay._curRow = 0;
                LetterDisplay._gameState = 'active';
                KeyboardDisplay._buttonCol = List<Color>.filled(
                    27, const Color.fromRGBO(248, 187, 208, 1),
                    growable: false);
                WinDisplay._message = ' ';
                LetterDisplay.validWord = false;

                Navigator.pop(context);
              },
            );
          },
        ),
        title: Text(args.gameMode), // gets mode info
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              heightFactor: 3,
              child:
                  Consumer<WinDisplay>(builder: (context, WinDisplay, child) {
                return Text(WinDisplay.text);
              }),
            ),
            Consumer<LetterDisplay>(builder: (context, LetterDisplay, child) {
              return Container(
                height: 400,
                width: 300,
                child: Container(
                  // padding: const EdgeInsets.all(15),
                  child: GridView.count(
                      // childAspectRatio: 1,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 5, // 5 per row
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      children: List.generate(30, (index) {
                        return Container(
                          color:
                              getColor(index), //Theme.of(context).primaryColor,
                          child: Center(
                            child: Text(
                              LetterDisplay.charG[index],
                              //LetterDisplay._charGrid[index],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              textScaleFactor: 2,
                            ),
                          ),
                        );
                      })),
                ),
              );
            }),
            Consumer<KeyboardDisplay>(
                builder: (context, KeyboardDisplay, child) {
              List<Widget> buttonArr = [
                LetterButton(
                  letter: 'Q',
                  buttonColor: KeyboardDisplay.buttonCol[0],
                ),
                LetterButton(
                  letter: 'W',
                  buttonColor: KeyboardDisplay.buttonCol[1],
                ),
                LetterButton(
                  letter: 'E',
                  buttonColor: KeyboardDisplay.buttonCol[2],
                ),
                LetterButton(
                  letter: 'R',
                  buttonColor: KeyboardDisplay.buttonCol[3],
                ),
                LetterButton(
                  letter: 'T',
                  buttonColor: KeyboardDisplay.buttonCol[4],
                ),
                LetterButton(
                  letter: 'Y',
                  buttonColor: KeyboardDisplay.buttonCol[5],
                ),
                LetterButton(
                  letter: 'U',
                  buttonColor: KeyboardDisplay.buttonCol[6],
                ),
                LetterButton(
                  letter: 'I',
                  buttonColor: KeyboardDisplay.buttonCol[7],
                ),
                LetterButton(
                  letter: 'O',
                  buttonColor: KeyboardDisplay.buttonCol[8],
                ),
                LetterButton(
                  letter: 'P',
                  buttonColor: KeyboardDisplay.buttonCol[9],
                ),
                LetterButton(
                  letter: 'A',
                  buttonColor: KeyboardDisplay.buttonCol[10],
                ),
                LetterButton(
                  letter: 'S',
                  buttonColor: KeyboardDisplay.buttonCol[11],
                ),
                LetterButton(
                  letter: 'D',
                  buttonColor: KeyboardDisplay.buttonCol[12],
                ),
                LetterButton(
                  letter: 'F',
                  buttonColor: KeyboardDisplay.buttonCol[13],
                ),
                LetterButton(
                  letter: 'G',
                  buttonColor: KeyboardDisplay.buttonCol[14],
                ),
                LetterButton(
                  letter: 'H',
                  buttonColor: KeyboardDisplay.buttonCol[15],
                ),
                LetterButton(
                  letter: 'J',
                  buttonColor: KeyboardDisplay.buttonCol[16],
                ),
                LetterButton(
                  letter: 'K',
                  buttonColor: KeyboardDisplay.buttonCol[17],
                ),
                LetterButton(
                  letter: 'L',
                  buttonColor: KeyboardDisplay.buttonCol[18],
                ),
                EntButton(),
                LetterButton(
                  letter: 'Z',
                  buttonColor: KeyboardDisplay.buttonCol[20],
                ),
                LetterButton(
                  letter: 'X',
                  buttonColor: KeyboardDisplay.buttonCol[21],
                ),
                LetterButton(
                  letter: 'C',
                  buttonColor: KeyboardDisplay.buttonCol[22],
                ),
                LetterButton(
                  letter: 'V',
                  buttonColor: KeyboardDisplay.buttonCol[23],
                ),
                LetterButton(
                  letter: 'B',
                  buttonColor: KeyboardDisplay.buttonCol[24],
                ),
                LetterButton(
                  letter: 'N',
                  buttonColor: KeyboardDisplay.buttonCol[25],
                ),
                LetterButton(
                  letter: 'M',
                  buttonColor: KeyboardDisplay.buttonCol[26],
                ),
                DelButton()
              ];

              return Column(children: [
                Container(
                    padding: const EdgeInsets.fromLTRB(
                        10, 20, 10, 5), //left, top, right, bottom

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: buttonArr.sublist(0, 10),
                    )),
                Container(
                    padding: const EdgeInsets.fromLTRB(
                        28, 5, 28, 5), //left, top, right, bottom
                    //color: Colors.orange[200],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: buttonArr.sublist(10, 19),
                    )),
                Container(
                    padding: const EdgeInsets.fromLTRB(
                        10, 5, 10, 5), //left, top, right, bottom
                    //color: Colors.orange[300],
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: buttonArr.sublist(19, 28))),
              ]);
            }),
          ],
        ),
      ),
    );
  }

  Color getColor(int index) {
    String type = LetterDisplay._guessGrid[index];
    if (type == 'corSpt') {
      return const Color.fromRGBO(251, 140, 0, 1);
    } else if (type == 'incSpt') {
      return const Color.fromRGBO(255, 183, 77, 1);
    } else if (type == 'incGs') {
      return const Color.fromRGBO(240, 98, 146, 1);
    } else {
      return const Color.fromRGBO(248, 187, 208, 1);
    }
  }
}

class LetterDisplay extends ChangeNotifier {
  // Letter grid state management
  static String answer = 'EMPTY'; //must be all cap
  static Set<String> ansChars = {
    answer[0],
    answer[1],
    answer[2],
    answer[3],
    answer[4]
  };
  static List<String> _charGrid = List<String>.filled(30, '', growable: false);
  static int _letterPointer = 0;
  static int _curRow = 0; // 0 to 5
  static List<String> _guessGrid = List<String>.filled(30, '', growable: false);
  //corSpt = orange 800, incSpt = orange 400, '' = pink 100, incGs = pink 400

  static String _gameState = 'active';
  static List<String> validList =
      List<String>.filled(12972, '', growable: false);
  static bool validWord = false;

  //getters and setters
  int get letterP {
    return _letterPointer;
  }

  List<String> get charG {
    return _charGrid;
  }

  List<String> get guessG {
    return _guessGrid;
  }

  String get gameSt {
    return _gameState;
  }

  static void loadAnsDict() async {
    // read the file of valid guesses
    String loadedString =
        await rootBundle.loadString('assets/valid-wordle-words.txt');
    //await Future.delayed(const Duration(seconds:1)); // dont need?
    validList = loadedString.split('\n');
  }

  void addToGrid(String newLetter) {
    //_letter = newLetter;
    if ((_letterPointer < 30) && (_letterPointer < (_curRow + 1) * 5)) {
      _charGrid[_letterPointer] = newLetter;
      notifyListeners();
      _letterPointer++;
    }
  }

  void removeLetter() {
    if (_letterPointer > _curRow * 5) {
      _letterPointer--;
      _charGrid[_letterPointer] = '';
      notifyListeners();
    }
  }

  static int binarySearch<String extends Comparable<String>>(
      List<String> validList, String guess) {
    int min = 0;
    int max = validList.length - 1;
    int pointer = 0;
    int comp = 0; //compareTo
    while (min <= max) {
      pointer = ((min + max) / 2).floor();
      comp = guess.compareTo(validList[pointer]);
      if (comp == 0) {
        return pointer;
      } else if (comp > 0) {
        min = pointer + 1;
      } else {
        max = pointer - 1;
      }
    }
    return -1;
  }

  void enterGuess() {
    if ((_letterPointer % 5 == 0) && (_letterPointer > 0)) {
      // allows 5n

      int index = 0;
      String curGuess = '';
      //bool validWord = false;

      //int index = binarySearch<String>(validWord, 'zymes', 0, 3);
      String checkGuess = '';
      for (int i = 0; i < 5; i++) {
        index = _letterPointer - 5 + i;
        checkGuess += _charGrid[index];
      }
      int find = binarySearch(validList, checkGuess.toLowerCase());
      print(find);
      print(checkGuess);

      if (find == -1) {
        validWord = false;
      } else {
        validWord = true;
      }

      if (validWord) {
        for (int i = 0; i < 5; i++) {
          // check for correct position
          index = _letterPointer - 5 + i;
          curGuess += _charGrid[index];
          if (_charGrid[index] == answer[i]) {
            _guessGrid[index] = 'corSpt';
          } else if (ansChars.contains(_charGrid[index])) {
            //check for in word
            _guessGrid[index] = 'incSpt';
          } else {
            _guessGrid[index] = 'incGs';
          }
        }
        _curRow++;

        if (curGuess == answer) {
          _gameState = 'win';
        } else if (_curRow == 6) {
          _gameState = 'lose';
        }

        notifyListeners();
      }
    }
  }
}

class WinDisplay extends ChangeNotifier {
  static String _message = ' ';

  String get text {
    return _message;
  }

  void endGameMessage(String gameState) {
    if (gameState == 'win') {
      _message = 'Game Win!';
    } else if (gameState == 'lose') {
      _message = 'Answer: ${LetterDisplay.answer}';
    } else if (gameState == 'invalid') {
      _message = 'Word Not Found in Dictionary';
    } else {
      _message = ' ';
    }
    notifyListeners();
  }

  void inputMessage() {
    notifyListeners();
  }
}

class KeyboardDisplay extends ChangeNotifier {
  // Letter grid state management
  static List<Color> _buttonCol = List<Color>.filled(
      27, const Color.fromRGBO(248, 187, 208, 1),
      growable: false);
  static final List<String> _letterKey = [
    'q',
    'w',
    'e',
    'r',
    't',
    'y',
    'u',
    'i',
    'o',
    'p',
    'a',
    's',
    'd',
    'f',
    'g',
    'h',
    'j',
    'k',
    'l',
    '   ',
    'z',
    'x',
    'c',
    'v',
    'b',
    'n',
    'm',
    '   '
  ];

  List<Color> get buttonCol {
    return _buttonCol;
  }

  List<String> get letterKey {
    return _letterKey;
  }

  void changeButtonCols() {
    int index = 0;
    String curChar = '';
    String curCol = '';
    int i = 0;

    for (int j = 0; j < 5; j++) {
      i = (LetterDisplay._curRow - 1) * 5 +
          j; //scans the current row (row ++is before this so -1)
      curCol = LetterDisplay._guessGrid[i];
      if (curCol.isNotEmpty) {
        //find all the non '' coloured squares
        curChar = LetterDisplay._charGrid[i];
        index = _letterKey.indexOf(curChar.toLowerCase());

        if (curCol == 'incSpt') {
          if (_buttonCol[index] != const Color.fromRGBO(251, 140, 0, 1)) {
            _buttonCol[index] = const Color.fromRGBO(255, 183, 77, 1);
          }
        } else if (curCol == 'corSpt') {
          _buttonCol[index] = const Color.fromRGBO(251, 140, 0, 1);
        } else {
          _buttonCol[index] = const Color.fromRGBO(240, 98, 146, 1);
        }
      } else {
        _buttonCol[index] = const Color.fromRGBO(248, 187, 208, 1);
      }
    }
    notifyListeners();
  }
}

class LetterButton extends StatelessWidget {
  String letter = '';
  Color buttonColor = Colors.blue;
  LetterButton({required this.letter, required this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          ElevatedButton(
            onPressed: () {
              if (LetterDisplay._gameState != 'win') {
                Provider.of<LetterDisplay>(context, listen: false)
                    .addToGrid(letter);
              }
            },
            // style: ElevatedButton.styleFrom(
            //   fixedSize: const Size(20,50),
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(const Size(20, 50)),
              backgroundColor: MaterialStateProperty.all(buttonColor),
            ),

            child: const Text(
              ' ',
              textAlign: TextAlign.left,
            ),
          ),
          Text(
            letter,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class DelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 3,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Provider.of<LetterDisplay>(context, listen: false).removeLetter();
            },
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(const Size(20, 50)),
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromRGBO(248, 187, 208, 1)),
            ),
            child: const Text(
              ' ',
              textAlign: TextAlign.left,
            ),
          ),
          const Icon(
            Icons.backspace_outlined,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}

class EntButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 3,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Provider.of<LetterDisplay>(context, listen: false).enterGuess();
              if (LetterDisplay.validWord) {
                Provider.of<KeyboardDisplay>(context, listen: false)
                    .changeButtonCols(); // runs even if not valid guess (fix)

                if (LetterDisplay._gameState != 'active') {
                  if (LetterDisplay._gameState == 'win') {
                    Provider.of<WinDisplay>(context, listen: false)
                        .endGameMessage('win');
                  } else {
                    Provider.of<WinDisplay>(context, listen: false)
                        .endGameMessage('lose');
                  }
                } else {
                  Provider.of<WinDisplay>(context, listen: false)
                      .endGameMessage(' ');
                }
              } else {
                Provider.of<WinDisplay>(context, listen: false)
                    .endGameMessage('invalid');
              }
            },
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(const Size(20, 50)),
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromRGBO(248, 187, 208, 1)),
            ),
            child: const Text(
              ' ',
              textAlign: TextAlign.left,
            ),
          ),
          const Text(
            'Enter',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

//leaderboard page
class LeaderB extends StatelessWidget {
  const LeaderB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_circle_left),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        title: const Text('LeaderBoard'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          const Center(
            heightFactor: 8,
            child: Text(' '),
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(
                  30, 0, 30, 20), //left, top, right, bottom
              //color: Colors.red,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
                    color: const Color.fromRGBO(255, 183, 77, 1),
                    child: const Text(
                      'Coming Soon!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
                    color: Colors.white,
                    child: const Icon(Icons.construction_rounded,
                        color: Colors.black, size: 211),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class Instr extends StatelessWidget {
  // instructions page
  const Instr({super.key});

  static const List<String> ex1 = ['W', 'E', 'A', 'R', 'Y'];
  static const List<String> ex2 = ['P', 'I', 'L', 'L', 'S'];
  static const List<String> ex3 = ['V', 'A', 'G', 'U', 'E'];
  static const List<Color> ex1c = [
    Color.fromRGBO(251, 140, 0, 1),
    Color.fromRGBO(248, 187, 208, 1),
    Color.fromRGBO(248, 187, 208, 1),
    Color.fromRGBO(248, 187, 208, 1),
    Color.fromRGBO(248, 187, 208, 1),
  ];
  static const List<Color> ex2c = [
    Color.fromRGBO(248, 187, 208, 1),
    Color.fromRGBO(255, 183, 77, 1),
    Color.fromRGBO(248, 187, 208, 1),
    Color.fromRGBO(248, 187, 208, 1),
    Color.fromRGBO(248, 187, 208, 1),
  ];
  static const List<Color> ex3c = [
    Color.fromRGBO(248, 187, 208, 1),
    Color.fromRGBO(248, 187, 208, 1),
    Color.fromRGBO(248, 187, 208, 1),
    Color.fromRGBO(240, 98, 146, 1),
    Color.fromRGBO(248, 187, 208, 1),
  ];

  @override
  Widget build(BuildContext context) {
    Widget buildExample(List<String> ex, List<Color> exc) {
      return Container(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        // height: 500,
        // width: 500,
        //flex: 3,
        //color: Colors.blue,
        child: GridView.count(
            shrinkWrap: true, // needed to make gridview height not unbounded
            crossAxisCount: 5, // 5 per row
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            children: List.generate(5, (index) {
              return Container(
                color: exc[index],
                child: Center(
                  child: Text(
                    ex[index],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textScaleFactor: 2,
                  ),
                ),
              );
            })),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_circle_left),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        title: const Text('Game Instructions'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          const Center(
            heightFactor: 4,
            child: Text(
              'HOW TO PLAY',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(
                  30, 0, 30, 20), //left, top, right, bottom
              //color: Colors.red,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
                    color: Colors.white,
                    child: const Text(
                        'Guess the WORDLE in 6 tries.\n\nEach guess must be a valid 5-letter word. \nHit the enter button to submit.\n\nAfter each guess, the color of the tiles will change to show how close your guess was to the word.'),
                  ),
                  buildExample(ex1, ex1c),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    color: Colors.white,
                    child: const Text(
                        'The letter W is in the word and in the correct spot.'),
                  ),
                  buildExample(ex2, ex2c),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    color: Colors.white,
                    child: const Text(
                        'The letter I is in the word but in the wrong spot.'),
                  ),
                  buildExample(ex3, ex3c),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    color: Colors.white,
                    child: const Text(
                        'The letter U is not in the word in any spot.'),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
