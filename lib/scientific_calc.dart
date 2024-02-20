import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

class ScientificCalculator extends StatefulWidget {
  const ScientificCalculator({super.key});

  @override
  State<ScientificCalculator> createState() => _ScientificCalculatorState();
}

class _ScientificCalculatorState extends State<ScientificCalculator> {
  TextEditingController displayText = TextEditingController(text: '');
  String equationText = '';
  String answer = "";
  int position = 0;
  bool focus = false;
  bool inverse = false;
  String sinInv = 'sin\u207B\u00B9';
  String cosInv = 'cos\u207B\u00B9';
  String tanInv = 'tan\u207B\u00B9';
  String logInv = 'e\u02e3';
  String sqrtInv = 'x\u00B2';
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
    try {
      setState(() {
        focus = false;
        if (displayText.text[displayText.text.length - 1] == "%") {
          displayText.text =
              displayText.text.substring(0, displayText.text.length - 1);
          equationText = equationText.substring(0, equationText.length - 4);
        } else if (displayText.text.substring(displayText.text.length - 4) ==
                "sin(" ||
            displayText.text.substring(displayText.text.length - 4) == "cos(" ||
            displayText.text.substring(displayText.text.length - 4) == "tan(" ||
            displayText.text.substring(displayText.text.length - 4) == "log(") {
          displayText.text =
              displayText.text.substring(0, displayText.text.length - 4);
          equationText = equationText.substring(0, equationText.length - 4);
        } else if (displayText.text.substring(displayText.text.length - 5) ==
            "sqrt(") {
          displayText.text =
              displayText.text.substring(0, displayText.text.length - 5);
          equationText = equationText.substring(0, equationText.length - 5);
        } else if (displayText.text.substring(displayText.text.length - 2) ==
            'pi') {
          debugPrint("yes");
          displayText.text =
              displayText.text.substring(0, displayText.text.length - 2);
          equationText = equationText.substring(0, equationText.length - 2);
        } else if (displayText.text.isNotEmpty) {
          displayText.text =
              displayText.text.substring(0, displayText.text.length - 1);
          equationText = equationText.substring(0, equationText.length - 1);
        }
      });
    } catch (e) {
      if (displayText.text.isNotEmpty) {
        displayText.text =
            displayText.text.substring(0, displayText.text.length - 1);
        equationText = equationText.substring(0, equationText.length - 1);
      }
    }
    setState(() {
      answer = '';
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
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.calculate_outlined,
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
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 43, 8),
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
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: row1(),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: row2(),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: row3(),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: row4(),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: row5(),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: row6(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 25),
            child: row7(),
          ),
        ],
      ),
    );
  }

  Row row1() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(29),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                if (inverse) {
                  assertNum('$sinInv(', 'asin(');
                } else {
                  assertNum('sin(', 'sin(');
                }
              },
              child: inverse ? Text(sinInv) : const Text('sin')),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(1),
                fixedSize: const Size.fromRadius(29),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                if (inverse) {
                  assertNum('$cosInv(', 'acos(');
                } else {
                  assertNum('cos(', 'cos(');
                }
              },
              child: inverse ? Text(cosInv) : const Text('cos')),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(29),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                if (inverse) {
                  assertNum('$tanInv(', 'atan(');
                } else {
                  assertNum('tan(', 'tan(');
                }
              },
              child: inverse ? Text(tanInv) : const Text('tan')),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(29),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                // assertNum('rad', 'rad');
              },
              child: Text(
                'rad',
                style: TextStyle( color: Colors.orange.shade800),
              )),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(29),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                // assertNum('pi', 'pi');
              },
              child: const Text('deg')),
        ],
      );

  Row row2() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(29),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                if (inverse) {
                  assertNum('e^', 'e^');
                } else {
                  assertNum('log(', 'log(');
                }
              },
              child: inverse ? Text(logInv) : const Text('log')),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(29),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                assertNum('ln(', 'ln(');
              },
              child: const Text('ln')),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(29),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                assertNum('(', '(');
              },
              child: const Text('(')),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(29),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                assertNum(')', ')');
              },
              child: const Text(')')),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(29),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                setState(() {
                  inverse = !inverse;
                });
              },
              child: const Text('inv')),
        ],
      );

  Row row7() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size.fromRadius(29),
              shape: const CircleBorder(),
            ),
            onPressed: () {
              assertNum('e', 'e');
            },
            child: const Text('e')),
        Hero(
          tag: '00',
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(29),
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
                fixedSize: const Size.fromRadius(29),
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
                fixedSize: const Size.fromRadius(29),
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
                backgroundColor: Colors.orange.shade800,
                fixedSize: const Size.fromRadius(29),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                try {
                  setState(() {
                    answer = equationText.interpret().toString();
                    equalPressed = true;
                    if (answer == 'NaN') {
                      answer = '';
                    } else {
                      focus = true;
                    }
                  });
                } catch (e) {
                  debugPrint('$e');
                  setState(() {
                    answer = '';
                  });
                }
              },
              child: const Text(
                '=',
                style: TextStyle(fontSize: 30),
              )),
        )
      ],
    );
  }

  Row row6() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size.fromRadius(29),
              shape: const CircleBorder(),
            ),
            onPressed: () {
              assertNum('pi', 'pi');
            },
            child: const Text('π')),
        Hero(
          tag: '1',
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(29),
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
                fixedSize: const Size.fromRadius(29),
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
                fixedSize: const Size.fromRadius(29),
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
                fixedSize: const Size.fromRadius(29),
                shape: const CircleBorder(),
              ),
              onPressed: () {
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

  Row row5() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size.fromRadius(29),
              shape: const CircleBorder(),
            ),
            onPressed: () {
              if (inverse) {
                assertNum('^2', '^2');
              } else {
                assertNum('sqrt(', 'sqrt(');
              }
            },
            child: inverse ? Text(sqrtInv) : const Text('√')),
        Hero(
          tag: '4',
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(29),
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
                fixedSize: const Size.fromRadius(29),
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
                fixedSize: const Size.fromRadius(29),
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
                fixedSize: const Size.fromRadius(29),
                shape: const CircleBorder(),
              ),
              onPressed: () {
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

  Row row4() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size.fromRadius(29),
              shape: const CircleBorder(),
            ),
            onPressed: () {
              assertNum('^', '^');
            },
            child: const Text('^')),
        Hero(
          tag: '7',
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(29),
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
                fixedSize: const Size.fromRadius(29),
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
                fixedSize: const Size.fromRadius(29),
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
                fixedSize: const Size.fromRadius(29),
                shape: const CircleBorder(),
              ),
              onPressed: () {
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

  Row row3() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size.fromRadius(29),
              shape: const CircleBorder(),
            ),
            onPressed: () {
              assertNum('!', '!');
            },
            child: const Text('!')),
        Hero(
          tag: 'C',
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(29),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                clearAll();
                debugPrint('sqrt(4)'.interpret().toString());
              },
              child: const Text('C')),
        ),
        Hero(
          tag: '%',
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromRadius(29),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                setState(() {
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
                fixedSize: const Size.fromRadius(29),
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
                fixedSize: const Size.fromRadius(29),
                shape: const CircleBorder(),
              ),
              onPressed: () {
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
