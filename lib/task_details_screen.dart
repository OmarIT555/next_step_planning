import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Task.dart';
import 'customColorPicker.dart';

class TaskDetails extends StatelessWidget {
  // Access the TextField texts
  var nameController = TextEditingController();
  var dateController = TextEditingController();
  var descriptionController = TextEditingController();

  String taskName, dateCreated, dueDate, taskDescription;
  Color taskColor;
  bool isCompleted;
  List<bool> isSelected = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            leadingWidth: 5,
            automaticallyImplyLeading: false,
            title: Text(
              "Task Details",
              style: TextStyle(),
            ),
            actions: <Widget>[
              Container(
                margin: const EdgeInsets.only(
                    top: 15.0, bottom: 15.0, right: 5.0, left: 5.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF2E7D32),
                  ),
                  child: Text("Save"),
                  onPressed: () {
                    returnHome(context);
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    top: 15.0, bottom: 15.0, right: 5.0, left: 5.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                  ),
                  child: Text("Cancel"),
                  onPressed: () {
                    returnHome(context);
                  },
                ),
              ),
            ]),
        body: Center(
            child: Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("TASK NAME:"),                               //Task name
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Study, Clean up, etc.",
                ),
                controller: nameController,
                onChanged: (name) {
                  taskName = name;
                },
              ),
              Container(                                        //Due by
                padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: Text("DUE BY:"),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "(MM/DD/YYYY)",
                ),
                keyboardType: TextInputType.number,
                controller: dateController,
                onChanged: (date) {
                  dueDate = date;
                },
              ),
              Container(                                         //Task Color
                padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: Text("TASK COLOR:"),
              ),
              MyCustomColorPicker(),
              Container(                                        //Task difficulty
                padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: Text("TASK DIFFICULTY:"),
              ),
              ToggleButtons(
                renderBorder: false,
                fillColor: Colors.grey,
                selectedColor: Colors.white,
                color: Colors.black,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                      child: Text("Low"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                      child: Text("Medium"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                      child: Text("High"),
                  ),
                ],
                onPressed: (int index) {},
                isSelected: isSelected,
              ),
              Container(                                        //Task Description
                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Text("TASK DESCRIPTION:"),
              ),
              TextField(
                controller: descriptionController,
                onChanged: (description) {
                  taskDescription = description;
                },
              ),
            ],
          ),
        )));
  }

  //Navigate back to home screen
  void returnHome(BuildContext context) {

    Navigator.pop(context, createTask());
  }

  Task createTask(){
    taskName = nameController.text;
    dueDate = dateController.text;
    taskDescription = descriptionController.text;

    var task = Task();

    task.taskName = taskName;
    task.dueDate = dueDate;
    task.taskDescription = taskDescription;

    //!!! Validate task before returning !!!
    return task;
  }
}
