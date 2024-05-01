import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'marks.dart';

class Info extends StatefulWidget {
  final String email;
  const Info({Key? key, required this.email}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  TextEditingController rollnoController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  List<String> departments = ['IT', 'Computer', 'Electronics'];
  List<String> genders = ['Male', 'Female'];
  final _formKey = GlobalKey<FormState>();

  String? rollNumber;
  String? name;
  String? selectedBranch;
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info Page'),
      ),
      body: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: rollnoController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      labelText: "Enter you roll number",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your roll number";
                      }
                      return null;
                    },
                    onSaved: (value) => rollNumber = value,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Enter you name",
                      border: OutlineInputBorder(),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z]+$'))
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                    onSaved: (value) => name = value,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedBranch,
                    onChanged: (value) {
                      setState(() {
                        selectedBranch = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Select your branch",
                      border: OutlineInputBorder(),
                    ),
                    items: departments.map((dept) {
                      return DropdownMenuItem<String>(
                        value: dept,
                        child: Text(dept),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your branch';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Gender',
                        style: TextStyle(fontSize: 16),
                      ),
                      ...genders.map((gender) {
                        return RadioListTile<String>(
                          title: Text(gender),
                          value: gender,
                          groupValue: selectedGender,
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value;
                            });
                          },
                        );
                      }).toList(),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _formKey.currentState?.reset();
                              rollnoController.clear();
                              nameController.clear();
                              setState(() {
                                selectedBranch = null;
                                selectedGender = null;
                              });
                            },
                            child: Text('Clear'),
                          ),
                          ElevatedButton(
                            onPressed: () {
          
                              Navigator.push(context,MaterialPageRoute(builder: (context) => MyMarks(
                                  email: widget.email,
                                  name:nameController.text,
                                  rollno: rollnoController.text,
                                  branch: selectedBranch!,
                                  gender: selectedGender!
                              )));
                            },
                            child: Text('Submit'),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ))),
    );
  }
}
