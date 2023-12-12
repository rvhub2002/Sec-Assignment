import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Todo {
  String task;
  bool isCompleted;

  Todo({
    required this.task,
    this.isCompleted = false,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Ravi's To-Do List App",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Todo> todos = [];
  TextEditingController _todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ravi's To-Do List App"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                      hintText: 'Enter a task',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      String todoText = _todoController.text;
                      if (todoText.isNotEmpty) {
                        todos.add(Todo(task: todoText));
                        _todoController.clear();
                      }
                    });
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    todos[index].task,
                    style: TextStyle(
                      decoration: todos[index].isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  leading: Checkbox(
                    value: todos[index].isCompleted,
                    onChanged: (value) {
                      setState(() {
                        todos[index].isCompleted = value!;
                      });
                    },
                  ),
                  onLongPress: () {
                    setState(() {
                      todos.removeAt(index);
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
