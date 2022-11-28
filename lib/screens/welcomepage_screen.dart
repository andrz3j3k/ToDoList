import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todolist/bloc/create_task_bloc.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

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
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (ctx, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            "/task",
                            arguments: {"task": list.elementAt(index)},
                          );
                        },
                        child: ListTile(
                          title: Text(list.elementAt(index).name!),
                          subtitle: Text(list.elementAt(index).description!),
                          leading: Text(list.elementAt(index).id!),
                          trailing: Text(DateFormat("dd-MM-yyyy")
                              .format(list.elementAt(index).date!)
                              .toString()),
                        ),
                      );
                    },
                  ),
                ),
              ],
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
