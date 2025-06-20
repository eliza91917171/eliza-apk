import 'package:flutter/material.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData.dark(),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';
  double? firstOperand;
  String? operator;

  void buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        input = '';
        firstOperand = null;
        operator = null;
      } else if (value == '=') {
        if (firstOperand != null && operator != null && input.isNotEmpty) {
          double second = double.parse(input);
          switch (operator) {
            case '+': input = (firstOperand! + second).toString(); break;
            case '-': input = (firstOperand! - second).toString(); break;
            case '×': input = (firstOperand! * second).toString(); break;
            case '÷': input = (firstOperand! / second).toString(); break;
          }
          firstOperand = null;
          operator = null;
        }
      } else if ('+-×÷'.contains(value)) {
        firstOperand = double.tryParse(input);
        operator = value;
        input = '';
      } else {
        input += value;
      }
    });
  }

  Widget buildButton(String value) {
    return ElevatedButton(
      onPressed: () => buttonPressed(value),
      child: Text(value, style: TextStyle(fontSize: 24)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.all(24),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                input.isEmpty ? '0' : input,
                style: TextStyle(fontSize: 48, color: Colors.white),
              ),
            ),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              for (var btn in ['7', '8', '9', '÷', '4', '5', '6', '×',
                              '1', '2', '3', '-', '0', '.', '=', '+', 'C'])
                SizedBox(
                  width: 80,
                  height: 80,
                  child: buildButton(btn),
                )
            ],
          ),
        ],
      ),
    );
  }
}
