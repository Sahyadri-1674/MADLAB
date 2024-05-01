import 'package:flutter/material.dart';
import 'info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App!!',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Student App',
              style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: Login(),
      ),
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool? terms = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                child: Text('LoginForm',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w500,
                        fontSize: 40))),
            SizedBox(
              height: 20,
            ),
            Container(
                alignment: Alignment.center,
                child: Text('Sign in',
                    style:
                        TextStyle(fontWeight: FontWeight.w200, fontSize: 20))),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Enter your email",
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter your email';
                } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return 'Enter a valid Email';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              obscuringCharacter: '*',
              decoration: InputDecoration(
                labelText: "Enter the password",
                prefixIcon: Icon(Icons.password_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter your password';
                } else if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$')
                    .hasMatch(value)) {
                  return 'Password must contain one uppercase letter, one lowercase letter and one digit';
                }
                return null;
              },
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Checkbox(
                  value: terms,
                  onChanged: (value) {
                    setState(() {
                      terms = value ?? false;
                    });
                  },
                ),
                Text("Agree all terms and conditions"),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Info(
                      email: emailController.text,
                    ),
                  ),
                );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
