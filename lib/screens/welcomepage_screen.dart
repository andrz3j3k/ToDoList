import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todolist/bloc/create_task_bloc.dart';
import 'package:todolist/main.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({
    super.key,
  });

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
      child: BlocBuilder<CreateTaskBloc, CreateTaskState>(
        builder: (context, state) {
          if (state is CreateTaskInitial) {
            return const Center(
              child: Text("Brak nowych zadań!"),
            );
          } else if (state is CreateTaskLoaded) {
            var list = state.listTask;

            return SingleChildScrollView(
              child: ExpansionPanelList.radio(children: [
                ...list.map(
                  (e) => ExpansionPanelRadio(
                    canTapOnHeader: true,
                    value: e.id.toString(),
                    headerBuilder: (context, isExpanded) {
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: ListTile(
                          title: Text(e.name!),
                          trailing: Text(DateFormat("dd-MM-yyyy")
                              .format(e.date!)
                              .toString()),
                        ),
                      );
                    },
                    body: Container(
                      margin: const EdgeInsets.only(
                          bottom: 10, left: 10, right: 10),
                      child: Column(
                        children: [
                          ListTile(
                            subtitle: Text(e.description!),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    bool isDelete = false;
                                    await showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('Alert'),
                                        content: const Text(
                                            'Czy aby napewno chcesz to usunąć?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              isDelete = false;
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              'Nie',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              isDelete = true;
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Tak',
                                                style: TextStyle(
                                                    color: Colors.black)),
                                          ),
                                        ],
                                      ),
                                    );
                                    if (isDelete) {
                                      setState(() {
                                        list.removeWhere(
                                            (element) => element.id == e.id);
                                      });
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          e.isDone = !e.isDone;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.done,
                                        color: e.isDone
                                            ? const Color.fromRGBO(
                                                138, 222, 157, 87)
                                            : Colors.black,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          e.isFavourite = !e.isFavourite!;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.favorite,
                                        color: e.isFavourite!
                                            ? const Color.fromRGBO(
                                                138, 222, 157, 87)
                                            : Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
