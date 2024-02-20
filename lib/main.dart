import 'dart:ui';
import 'package:calculator/scientific_calc.dart';
import 'package:calculator/theme.dart';
import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: const Calculator());
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  TextEditingController displayText = TextEditingController(text: '');
  String equationText = '';
  String answer = "";
  bool focus = false;
  int position = 0;
  bool equalPressed = false;

  void assertNum(String number, String actualSymbol) {
    setState(() {
      displayText.text = displayText.text + number;
      equationText = equationText + actualSymbol;
      answer = '';
      focus = false;
    });
  }

  void deleteNum(String position) {
    setState(() {
      focus = false;
      if (displayText.text[displayText.text.length - 1] == "%") {
        displayText.text =
            displayText.text.substring(0, displayText.text.length - 1);
        equationText = equationText.substring(0, equationText.length - 4);
      } else {
        displayText.text =
            displayText.text.substring(0, displayText.text.length - 1);
        equationText = equationText.substring(0, equationText.length - 1);
      }
    });
  }

  void clearAll() {
    setState(() {
      displayText.text = '';
      answer = '';
      equationText = '';
    });
  }

  void updateAnswer() {
    setState(() {
      if (equalPressed) {
        displayText.text = answer;
        equationText = answer;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScientificCalculator()),
                  );
                },
                icon: const Icon(
                  Icons.science_outlined,
                  size: 30,
                )),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 40, 8),
                child: TweenAnimationBuilder(
                  tween: Tween<double?>(
                    begin: 20,
                    end: !focus ? 40 : 20,
                  ),
                  duration: const Duration(milliseconds: 200),
                  builder: (context, value, child) {
                    return TextField(
                      style: TextStyle(
                          color: !focus
                              ? Theme.of(context).canvasColor
                              : Colors.grey,
                          fontSize: value),
                      onTap: () {
                        position = displayText.selection.base.offset;
                      },
                      readOnly: true,
                      showCursor: true,
                      textAlign: TextAlign.end,
                      controller: displayText,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 43, 8),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TweenAnimationBuilder(
                    tween: Tween<double?>(
                      begin: 20,
                      end: focus ? 40 : 20,
                    ),
                    duration: const Duration(milliseconds: 200),
                    builder: (context, value, child) {
                      return Text(
                        answer,
                        style: TextStyle(
                            color: focus
                                ? Theme.of(context).canvasColor
                                : Colors.grey,
                            fontSize: value),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: row1(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: row2(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: row3(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: row4(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 25),
            child: row5(),
          ),
        ],
      ),
    );
  }

  Row row5() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Hero(
          tag: '00',
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(35),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                assertNum('00', '00');
              },
              child: const Text('00')),
        ),
        Hero(
          tag: '0',
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(35),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                assertNum('0', '0');
              },
              child: const Text('0')),
        ),
        Hero(
          tag: '.',
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(35),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                assertNum('.', '.');
              },
              child: const Text('.')),
        ),
        Hero(
          tag: '=',
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(35),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                try {
                  setState(() {
                    answer = equationText.interpret().toString();
                    focus = true;
                    equalPressed = true;
                  });
                } catch (e) {
                  debugPrint('$e');
                  setState(() {
                    answer = '';
                  });
                }
              },
              child: const Text('=')),
        )
      ],
    );
  }

  Row row4() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Hero(
          tag: '1',
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(35),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                assertNum('1', '1');

                debugPrint('$position');
              },
              child: const Text('1')),
        ),
        Hero(
          tag: '2',
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(35),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                assertNum('2', '2');
              },
              child: const Text('2')),
        ),
        Hero(
          tag: '3',
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(35),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                assertNum('3', '3');
              },
              child: const Text('3')),
        ),
        Hero(
          tag: '+',
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(35),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                updateAnswer();
                equalPressed = false;
                assertNum('+', '+');
              },
              child: Text(
                '+',
                style: TextStyle(fontSize: 30, color: Colors.orange.shade800),
              )),
        )
      ],
    );
  }

  Row row3() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Hero(
          tag: '4',
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(35),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                assertNum('4', '4');
              },
              child: const Text('4')),
        ),
        Hero(
          tag: '5',
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(35),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                assertNum('5', '5');
              },
              child: const Text('5')),
        ),
        Hero(
          tag: '6',
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(35),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                assertNum('6', '6');
              },
              child: const Text('6')),
        ),
        Hero(
          tag: '-',
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(35),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                updateAnswer();
                equalPressed = false;
                assertNum('−', '-');
              },
              child: Text(
                '−',
                style: TextStyle(fontSize: 30, color: Colors.orange.shade800),
              )),
        )
      ],
    );
  }

  Row row2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Hero(
          tag: '7',
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(35),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                setState(() {
                  assertNum('7', '7');
                });
              },
              child: const Text('7')),
        ),
        Hero(
          tag: '8',
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(35),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                assertNum('8', '8');
              },
              child: const Text('8')),
        ),
        Hero(
          tag: '9',
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(35),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                assertNum('9', '9');
              },
              child: const Text('9')),
        ),
        Hero(
          tag: 'x',
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(35),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                updateAnswer();
                equalPressed = false;
                assertNum('×', '*');
              },
              child: Text(
                '×',
                style: TextStyle(fontSize: 30, color: Colors.orange.shade800),
              )),
        )
      ],
    );
  }

  Row row1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Hero(
          tag: 'C',
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(35),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                clearAll();
                debugPrint('3!'.interpret().toString());
              },
              child: const Text('C')),
        ),
        Hero(
          tag: '%',
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(35),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                setState(() {
                  updateAnswer();
                  equalPressed = false;
                  assertNum('%', '/100');
                  answer = equationText.interpret().toString();
                });
              },
              child: const Text('%')),
        ),
        Hero(
          tag: 'E',
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(35),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                deleteNum('$position');
              },
              child: const Icon(Icons.backspace_outlined)),
        ),
        Hero(
          tag: '÷',
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(35),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                updateAnswer();
                equalPressed = false;
                assertNum('÷', '/');
              },
              child: Text(
                '÷',
                style: TextStyle(fontSize: 30, color: Colors.orange.shade800),
              )),
        )
      ],
    );
  }
}
