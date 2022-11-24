import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/create_task_bloc.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/screens/welcomepage_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateTaskBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        routes: {
          '/': (_) => const HomePage(),
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void addTask(id, name, description, date) {
    var task = Task(id: id, name: name, description: description, date: date);
    Task.listTasks.add(task);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Strona główna"),
        actions: [
          IconButton(
              onPressed: () {
                context.read<CreateTaskBloc>().add(
                      TaskCreated(
                          id: "1",
                          name: "Test",
                          description: "Testowy opis",
                          date: "10.10.2022"),
                    );
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: const WelcomePage(),
    );
  }
}
