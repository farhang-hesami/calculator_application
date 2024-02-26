import 'package:flutter/material.dart';
import 'package:flutter_application_calculator2/constants.dart';

import 'package:math_expressions/math_expressions.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var inputUser = "";
  var result = "";

  void buttonPressed(String text) {
    setState(() {
      inputUser = inputUser + text;
    });
  }

  Widget getRow(String text1, String text2, String text3, String text4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          style: TextButton.styleFrom(
              minimumSize: Size(77, 77),
              maximumSize: Size(77, 77),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
                side: BorderSide(width: 0, color: Colors.transparent),
              ),
              backgroundColor:
                  text1 == "AC" ? Colors.grey : getBackgroundColor(text1)),
          onPressed: () {
            if (text1 == "AC") {
              setState(() {
                inputUser = "";
                result = "";
              });
            } else {
              buttonPressed(text1);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              text1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
              minimumSize: Size(77, 77),
              maximumSize: Size(77, 77),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
                side: BorderSide(width: 0, color: Colors.transparent),
              ),
              backgroundColor:
                  text2 == "CE" ? Colors.grey : getBackgroundColor(text2)),
          onPressed: () {
            if (text2 == "CE") {
              setState(() {
                if (inputUser.length > 0) {
                  inputUser = inputUser.substring(0, inputUser.length - 1);
                }
              });
            } else {
              buttonPressed(text2);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              text2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
              minimumSize: Size(77, 77),
              maximumSize: Size(77, 77),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
                side: BorderSide(width: 0, color: Colors.transparent),
              ),
              backgroundColor:
                  text3 == "%" ? Colors.grey : getBackgroundColor(text3)),
          onPressed: () {
            buttonPressed(text3);
          },
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              text3,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
              minimumSize: Size(77, 77),
              maximumSize: Size(77, 77),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
                side: BorderSide(width: 0, color: Colors.transparent),
              ),
              backgroundColor: getBackgroundColor(text4)),
          onPressed: () {
            if (text4 == "=") {
              Parser parser = Parser();
              Expression expression = parser.parse(inputUser);
              ContextModel contextModel = ContextModel();

              double eval =
                  expression.evaluate(EvaluationType.REAL, contextModel);

              setState(() {
                result = eval.toString();
              });
            } else {
              buttonPressed(text4);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              text4,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.black,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          inputUser,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          result,
                          style: TextStyle(
                            fontSize: 62.0,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  color: Colors.black,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      getRow("AC", "CE", "%", "/"),
                      getRow("7", "8", "9", "*"),
                      getRow("4", "5", "6", "-"),
                      getRow("1", "2", "3", "+"),
                      getRow("00", "0", ".", "="),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isOperator(String text) {
    var List = ["/", "*", "-", "+", "="];
    for (var item in List) {
      if (text == item) {
        return true;
      }
    }
    return false;
  }

  Color getBackgroundColor(String text) {
    if (isOperator(text)) {
      return Colors.blue;
    } else {
      return backgroundGrey;
    }
  }
}
