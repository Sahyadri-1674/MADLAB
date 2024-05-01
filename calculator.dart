import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
// import 'practice.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';

  void _onPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _expression = '';
      } else if (buttonText == '=') {
        _evaluateExpression();
      } else {
        _expression += buttonText;
      }
    });
  }

  void _evaluateExpression() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(_expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      _expression = eval.toString();
    } catch (e) {
      _expression = 'Error';
    }
  }

  Widget _buildButton(String buttonText, {Color? textColor, Color? buttonColor}) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () => _onPressed(buttonText),
        child: Text (
          buttonText,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: textColor ?? Colors.black,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor ?? Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(16.0),
              child: Text(
                _expression,
                style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Divider(),
          Row(
            children: <Widget>[
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('/', buttonColor: Colors.orange),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: <Widget>[
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('*', buttonColor: Colors.orange),
            ],
          ),
          SizedBox(height: 5,),
          Row(
            children: <Widget>[
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('-', buttonColor: Colors.orange),
            ],
          ),
          SizedBox(height: 5,),
          Row(
            children: <Widget>[
              _buildButton('C', textColor: Colors.red),
              _buildButton('0'),
              _buildButton('=', buttonColor: Colors.blue),
              _buildButton('+', buttonColor: Colors.orange),
            ],
          ),
        ],
      ),
    );
  }
}
