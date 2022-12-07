import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/create_task_bloc.dart';
import 'package:todolist/repository/repository.dart';
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
      create: (context) => TaskBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromRGBO(170, 245, 164, 96),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromRGBO(170, 245, 164, 96),
          ),
        ),
        routes: {
          '/': (_) => HomePage(),
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  SortType sortType = SortType.during;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String namePage(SortType sortType) {
    switch (sortType) {
      case SortType.during:
        return "W trakcie";
      case SortType.allTasks:
        return "Wszystkie";
      case SortType.favouriteTasks:
        return "Ulubione";
      case SortType.doneTasks:
        return "Ukończone";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(namePage(widget.sortType)),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: const SheetForm(),
                    );
                  },
                );
              },
              icon: const Icon(Icons.add)),
        ],
        leading: PopupMenuButton<SortType>(
            // Callback that sets the selected popup menu item.
            onSelected: (SortType type) {
              context.read<TaskBloc>().add(TaskSortedEvent(type));
              widget.sortType = type;
              setState(() {});
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<SortType>>[
                  const PopupMenuItem<SortType>(
                    value: SortType.during,
                    child: Text('W trakcie'),
                  ),
                  const PopupMenuItem<SortType>(
                    value: SortType.allTasks,
                    child: Text('Wszystkie'),
                  ),
                  const PopupMenuItem<SortType>(
                    value: SortType.favouriteTasks,
                    child: Text('Ulubione'),
                  ),
                  const PopupMenuItem<SortType>(
                    value: SortType.doneTasks,
                    child: Text('Ukończone'),
                  ),
                ]),
      ),
      body: WelcomePage(sortType: widget.sortType),
    );
  }
}
