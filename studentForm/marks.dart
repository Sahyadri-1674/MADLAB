import 'package:flutter/material.dart';

class MyMarks extends StatefulWidget {
  String email;
  String name;
  String branch;
  String gender;
  String rollno;

  MyMarks(
      {Key? key,
      required this.email,
      required this.rollno,
      required this.name,
      required this.branch,
      required this.gender})
      : super(key: key);

  @override
  State<MyMarks> createState() => _MyMarksState();
}

class _MyMarksState extends State<MyMarks> {
  final _formKey = GlobalKey<FormState>();

  List<String> subjects = [
    'Wireless Technology',
    'Image Processing',
    'Data Mining and Business Intelligence',
    'WebX',
    'Artificial Intelligence and Data Science'
  ];
  Map<String, TextEditingController> marksController = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (String subject in subjects) {
      marksController[subject] = TextEditingController();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    for (TextEditingController controller in marksController.values) {
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Marks", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              for (String subject in subjects)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(subject,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: marksController[subject],
                      decoration: InputDecoration(
                        labelText: "Marks",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the marks";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        _formKey.currentState!.reset();
                        for (TextEditingController controller
                            in marksController.values) {
                          controller.clear();
                        }
                      },
                      child: Text("Clear")),
                  ElevatedButton(
                      onPressed: () {
                        _submitForm();
                      },
                      child: Text("Submit"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    Map<String, String> marksMap = {};

    for (String subject in subjects) {
      marksMap[subject] = marksController[subject]!.text;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return FinalPage(
          email: widget.email,
          name: widget.name,
          branch: widget.branch,
          rollno: widget.rollno,
          gender: widget.gender,
          marksMap: marksMap,
        );
      }),
    );
  }
}

class FinalPage extends StatelessWidget {
  final String email;
  final String name;
  final String branch;
  final String rollno;
  final String gender;
  final Map<String, String> marksMap;

  const FinalPage({
    Key? key,
    required this.email,
    required this.name,
    required this.branch,
    required this.rollno,
    required this.gender,
    required this.marksMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Final Page"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email: $email', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Name: $name', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Gender: $gender', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Branch: $branch', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('RollNo: $rollno', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: marksMap.entries.map((entry) {
                  return Card(
                    margin: EdgeInsets.only(bottom: 10),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(entry.key, style: TextStyle(fontSize: 16,)),
                          Text(entry.value, style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        ));
  }
}
