import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/models/task.dart';
import '../bloc/create_task_bloc.dart';
import '../repository/repository.dart';

class SheetForm extends StatefulWidget {
  const SheetForm({super.key});

  @override
  State<SheetForm> createState() => _SheetFormState();
}

class _SheetFormState extends State<SheetForm> {
  late TextEditingController _controllerTitle;
  late TextEditingController _controllerDescription;
  bool isFavourite = false;
  final _form = GlobalKey<FormState>();
  @override
  void initState() {
    _controllerTitle = TextEditingController();
    _controllerDescription = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controllerDescription.dispose();
    _controllerTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;
    return SizedBox(
      height: device.height * 0.28,
      child: Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                  key: _form,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _controllerTitle,
                        autofocus: true,
                        minLines: 1,
                        maxLines: 2,
                        maxLength: 50,
                        cursorColor: const Color.fromRGBO(170, 245, 164, 96),
                        decoration: const InputDecoration(
                          hintText: "Tytuł np. spotkanie z Bartkiem o 11",
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Wpisz tytuł!";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _controllerDescription,
                        maxLength: 255,
                        minLines: 1,
                        maxLines: 5,
                        cursorColor: const Color.fromRGBO(170, 245, 164, 96),
                        decoration: const InputDecoration(
                            hintText: "Opis",
                            enabledBorder: InputBorder.none,
                            border: InputBorder.none),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      splashRadius: 20,
                      onPressed: () {
                        setState(() {
                          isFavourite = !isFavourite;
                        });
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: isFavourite
                            ? const Color.fromRGBO(138, 222, 157, 87)
                            : Colors.black,
                        size: 27,
                      ),
                    ),
                    IconButton(
                      splashRadius: 20,
                      onPressed: () {
                        final isValidForm = _form.currentState!.validate();
                        if (!isValidForm) {
                          return;
                        }
                        addTask(
                          _controllerTitle.text,
                          _controllerDescription.text,
                          DateTime.now(),
                        );
                      },
                      icon: const Icon(
                        Icons.arrow_upward_outlined,
                        color: Color.fromRGBO(138, 222, 157, 87),
                        size: 27,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addTask(String name, String description, DateTime date) {
    var repository = Repository.getInstance();
    int numberId;
    numberId = Random().nextInt(10000);
    while (repository!.listTask!.any((element) => element.id == numberId)) {
      numberId = Random().nextInt(10000);
    }
    context.read<TaskBloc>().add(
          TaskCreatedEvent(
            id: numberId.toString(),
            name: name,
            description: description,
            date: date,
            isFavourite: isFavourite,
          ),
        );
    Navigator.pop(context);
  }
}
