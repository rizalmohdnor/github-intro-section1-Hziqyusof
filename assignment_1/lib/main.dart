import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = ""; // To display the original equation
  String result = "0"; // To display the result
  String _output = "";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        if (_output.isNotEmpty) {
          _output = _output.substring(0, _output.length - 1); // Remove last character
          equation = _output;
        }
      } else if (buttonText == "AC") {
        // All Clear
        equation = "";
        result = "0";
        _output = "";
        num1 = 0.0;
        num2 = 0.0;
        operand = "";
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "×" || buttonText == "÷") {
        if (equation.isNotEmpty && RegExp(r'[+\-×÷]$').hasMatch(equation)) {
          return; // Avoid duplicate operators
        }

        num1 = double.tryParse(_output) ?? 0.0;
        operand = buttonText;
        _output = "";
        equation = "${num1.toStringAsFixed(2).replaceAll(RegExp(r'\.00$'), '')} $operand";
      } else if (buttonText == "=") {
        if (operand.isNotEmpty) {
          num2 = double.tryParse(_output) ?? 0.0;
          if (operand == "+") {
            result = (num1 + num2).toString();
          } else if (operand == "-") {
            result = (num1 - num2).toString();
          } else if (operand == "×") {
            result = (num1 * num2).toString();
          } else if (operand == "÷") {
            result = num2 != 0 ? (num1 / num2).toString() : "Error";
          }
          equation =
              "${num1.toStringAsFixed(2).replaceAll(RegExp(r'\.00$'), '')} $operand ${num2.toStringAsFixed(2).replaceAll(RegExp(r'\.00$'), '')}";
          operand = "";
          _output = ""; // Clear output after showing result
        }
      } else {
        _output += buttonText;
        equation += buttonText;
      }

      // Format the result as a clean number without trailing zeros
      if (result != "Error") {
        result = double.tryParse(result)?.toStringAsFixed(2).replaceAll(RegExp(r'\.00$'), '') ?? "0";
      }
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple Calculator"),
      ),
      body: Column(
        children: <Widget>[
          // Equation Display
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            child: Text(
              equation,
              style: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ),
          // Result Display
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            child: Text(
              result,
              style: const TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold, color: Colors.blue),
              textAlign: TextAlign.right,
            ),
          ),
          const Divider(),
          // Calculator Buttons
          Column(
            children: [
              Row(
                children: <Widget>[
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("÷"),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("×"),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("-"),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("."),
                  buildButton("0"),
                  buildButton("C"),
                  buildButton("+"),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("AC"), // New Clear Button
                  buildButton("="),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
