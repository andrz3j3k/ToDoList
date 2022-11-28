import 'package:flutter/material.dart';

class TaskPage extends StatelessWidget {
  static const routeName = "/task";

  const TaskPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final task = args["task"];
    return Scaffold(
      appBar: AppBar(
        title: Text(task.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(task.description),
            task.isFavourite
                ? const Icon(Icons.favorite_outlined)
                : Container(),
          ],
        ),
      ),
    );
  }
}
