import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = "0";
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "×" || buttonText == "÷") {
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
    } else if (buttonText == "=") {
      num2 = double.parse(output);

      if (operand == "+") {
        _output = (num1 + num2).toString();
      } else if (operand == "-") {
        _output = (num1 - num2).toString();
      } else if (operand == "×") {
        _output = (num1 * num2).toString();
      } else if (operand == "÷") {
        _output = (num1 / num2).toString();
      }

      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else {
      _output = _output + buttonText;
    }

    setState(() {
      output = double.parse(_output).toStringAsFixed(2).replaceAll(RegExp(r'\.00$'), '');
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
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
            child: Text(
              output,
              style: const TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
          ),
          const Expanded(
            child: Divider(),
          ),
          Column(
            children: [
              Row(children: <Widget>[
                buildButton("7"),
                buildButton("8"),
                buildButton("9"),
                buildButton("÷"),
              ]),
              Row(children: <Widget>[
                buildButton("4"),
                buildButton("5"),
                buildButton("6"),
                buildButton("×"),
              ]),
              Row(children: <Widget>[
                buildButton("1"),
                buildButton("2"),
                buildButton("3"),
                buildButton("-"),
              ]),
              Row(children: <Widget>[
                buildButton("."),
                buildButton("0"),
                buildButton("C"),
                buildButton("+"),
              ]),
              Row(children: <Widget>[
                buildButton("="),
              ]),
            ],
          )
        ],
      ),
    );
  }
}
