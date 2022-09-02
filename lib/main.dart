import 'package:flutter/material.dart';
import 'gameScrn.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'package:path/path.dart' as p;
import 'dart:math';

void main() {
  // var filePathAns = p.join(Directory.current.path, 'assets', 'answer-words.txt');
  // File fileAns = File(filePathAns);

  runApp(
    // ChangeNotifierProvider(
    //   create: (context) => LetterDisplay(),
    //   child: const MyApp(),
    // ),
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LetterDisplay>(
          create: (context) => LetterDisplay(),
        ),
        ChangeNotifierProvider<KeyboardDisplay>(
          create: (context) => KeyboardDisplay(),
        ),
        ChangeNotifierProvider<WinDisplay>(
          create: (context) => WinDisplay(),
        ),
      ],
      child: const MyApp(),
    ),

    //const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //named navigation routes
      //initialRoute: '/homeScrn',
      routes: {
        '/homeScrn': (context) => const MyApp(),
        '/dailyC': (context) => DailyC(),
        '/leaderB': (context) => const LeaderB(),
        '/instr': (context) => const Instr(),
      },

      theme: ThemeData(
          // you still need this for the homescreen?
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.pink,
          ),
          //textTheme: GoogleFonts.emilysCandyTextTheme(),
          scaffoldBackgroundColor: Colors.pink[50],
          primaryColor: Colors.pink[100], // unguessed game squares
          secondaryHeaderColor: Colors.white //text and icons for game buttons
          ),

      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    LetterDisplay.loadAnsDict(); //load up valid word guesses
    Widget titleSection = Container(
      padding: const EdgeInsets.fromLTRB(30, 45, 30, 0),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  //padding: const EdgeInsets.only(bottom: 8),
                  alignment: Alignment.center,
                  child: const Text(
                    'Wordle Plus',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                  ),
                ),
                // Text(
                //   'Daily Word',
                //   style: TextStyle(
                //     color: Colors.grey[500],
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );

    //Constant/Theme variables
    Color color = Colors.pink;
    TextStyle stanTxt = const TextStyle(
        fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white //color,
        );

    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          //zen button
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.perm_device_information, color: color),
            Container(
              margin: const EdgeInsets.only(top: 4),
              child: ElevatedButton(
                  child: Text(
                    'Instructions',
                    style: stanTxt,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/instr',
                      arguments: ScreenArguments('title', 'Zen Mode'),
                    );
                  }),
            ),
          ],
        ),
        Column(
          // daily c button
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.play_circle_fill, color: color),
            Container(
              margin: const EdgeInsets.only(top: 4),
              child: ElevatedButton(
                  child: Text(
                    'Play',
                    style: stanTxt,
                  ),
                  onPressed: () {
                    void chooseWord() async {
                      // choose a new word
                      String word = 'TESTX';
                      String loadedString = await rootBundle
                          .loadString('assets/answer_words.txt');
                      await Future.delayed(const Duration(seconds: 1));
                      List<String> wordList = loadedString.split('\n');

                      Random random = Random();
                      int index = random.nextInt(5616);

                      word = wordList[index];
                      print(index);
                      print(word);
                      print('new game');
                      LetterDisplay.answer = word.toUpperCase();
                      LetterDisplay.ansChars = {
                        LetterDisplay.answer[0],
                        LetterDisplay.answer[1],
                        LetterDisplay.answer[2],
                        LetterDisplay.answer[3],
                        LetterDisplay.answer[4]
                      };
                      //print(LetterDisplay.ansChars);
                    }

                    chooseWord();
                    //LetterDisplay.loadAnsDict();
                    //print(LetterDisplay.validList[12970]);

                    Navigator.pushNamed(
                      context,
                      '/dailyC', // route name goes here
                      arguments: ScreenArguments('title', 'Daily Challenge'),
                    );
                  }),
            ),
          ],
        ),
        Column(
          //Leaderboard
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.leaderboard, color: color),
            Container(
              margin: const EdgeInsets.only(top: 4),
              child: ElevatedButton(
                  child: Text('Leaderboard', style: stanTxt),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/leaderB',
                    );
                  }),
            ),
          ],
        ),
      ],
    );

    Widget textSection = const Padding(
      padding: EdgeInsets.all(22),
      child: Center(
        child: Text(
          'Jonathan Feng - 2022',
          softWrap: true,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: ListView(
        //can also just do Column
        children: [
          titleSection,
          Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.all(30),
            //color: Colors.amber,
            child: Image.asset(
              'assets/images/Home.png',
              width: 600,
              height: 250,
              fit: BoxFit.contain,
            ),
          ),
          buttonSection,
          textSection,
        ],
      ),
    );
  }
}

//cross-screen arguments
class ScreenArguments {
  final String title;
  final String gameMode;

  ScreenArguments(this.title, this.gameMode);
}
