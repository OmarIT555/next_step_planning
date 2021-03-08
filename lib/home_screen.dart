import 'package:flutter/material.dart';
import 'package:next_step_planning/Settings.dart';
import 'package:next_step_planning/task_details_screen.dart';

// This this the home screen. It contains all of the tasks the user have created.
class MyHomePage extends StatefulWidget {
  //temp variable
  String taskName;
  MyHomePage({this.taskName});
  //MyHomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int count = 0;
  int botNavBarIndex = 0;
  List tasks = List<String>.generate(0, (index) => null);


  List taskAssign() {
    tasks = List<String>.generate(count, (index) => "Task " + (index + 1).toString());
    return tasks;
  }




  // Widget currentScreen = listViewBuilder(0);

  // Used with the Floating Action Button (For now) Keeps track of how many times it's pressed
  void _incrementCounter() {
    setState(() {
      count++;
      tasks = taskAssign();
    });
  }


  int _navigationIndex = 0;
  final List<Widget> _pages = [
    MyHomePage(),
    Settings(),
    Settings()
  ];

  //Builds The App
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks"),
      ),
      body:

      Center(
        child: listViewBuilder(count), //currentScreen //listViewBuilder(count),
        //TaskDetails(),
      ),

      //bottomSheet: _pages[_navigationIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navigationIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: [

          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home'),

          BottomNavigationBarItem(
              icon: Icon(Icons.sort),
              label: 'Sort'),

          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings'),
        ],
        onTap: (index){
          setState(() {
            _navigationIndex = index;
          });
        },

      ),

      floatingActionButton: FloatingActionButton(
        onPressed: addTask,
        tooltip: 'Add Task',
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),

    );
  }

  // Increment number of task(s) and navigate to the TaskDetails class
  void addTask() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskDetails()),
    );
    _incrementCounter();
  }

  // Used for creating and removing tasks
  ListView listViewBuilder(int num) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Dismissible(
          key: Key(task),
          onDismissed: (direction) {
            // Remove the task and decreases the count
            setState(() {
              tasks.removeAt(index);
              count--;
            });

            // Message confirming the removal of a task
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Task removed")));

          },
          child: ListTile(title: Text("Task " + (index + 1).toString()),
              subtitle: Text("Task is due by (insert date here)"),
            leading: Icon(Icons.assignment_outlined)),
        );
      },
    );
  }
}
