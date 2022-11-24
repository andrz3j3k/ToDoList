import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/create_task_bloc.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<CreateTaskBloc, CreateTaskState>(
            builder: (context, state) {
              if (state is CreateTaskInitial) {
                return const Center(
                  child: Text("Brak nowych zadań!"),
                );
              } else if (state is CreateTaskLoaded) {
                var list = state.listTask;
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (ctx, index) {
                    return ListTile(
                      title: Text(list.elementAt(index).name!),
                      subtitle: Text(list.elementAt(index).description!),
                      leading: Text(list.elementAt(index).id!),
                      trailing: Text(list.elementAt(index).date!),
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        )
      ],
    );
  }
}
