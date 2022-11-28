import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/create_task_bloc.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/screens/task_page_screen.dart';
import 'package:todolist/screens/welcomepage_screen.dart';
import 'package:todolist/widgets/form.dart';

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
          primaryColor: const Color.fromRGBO(170, 245, 164, 96),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromRGBO(170, 245, 164, 96),
          ),
        ),
        routes: {
          '/': (_) => const HomePage(),
          TaskPage.routeName: (_) => const TaskPage(),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Strona główna"),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  context: context,
                  builder: (context) {
                    return const SheetForm();
                  },
                );
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: const WelcomePage(),
    );
  }
}
