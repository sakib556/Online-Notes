import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_notes/auth_controller.dart';
import 'package:online_notes/todo_controller.dart';
import 'package:online_notes/todo_model.dart';

class HomeScreen extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Online Notes"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => authController.logout(),
          ),
        ],
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: todoController.todos.length,
          itemBuilder: (context, index) {
            TodoModel todo = todoController.todos[index];
            return ListTile(
              title: Text(todo.title),
              subtitle: Text(todo.description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _editTodoDialog(
                        context, todo.id, todo.title, todo.description),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => todoController.deleteTodo(todo.id),
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTodoDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _addTodoDialog(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    Get.defaultDialog(
      title: 'Add To-Do',
      content: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
          ),
        ],
      ),
      textConfirm: 'Add',
      onConfirm: () {
        if (titleController.text.isNotEmpty &&
            descriptionController.text.isNotEmpty) {
          todoController.addTodo(authController.currentUser!.uid,
              titleController.text, descriptionController.text);
          // titleController.dispose();
          // descriptionController.dispose();
          Get.back();
        }
      },
      textCancel: 'Cancel',
      onCancel: () {
        // titleController.dispose();
        // descriptionController.dispose();
      },
    );
  }

  void _editTodoDialog(BuildContext context, String todoId, String currentTitle,
      String currentDescription) {
    TextEditingController titleController =
        TextEditingController(text: currentTitle);
    TextEditingController descriptionController =
        TextEditingController(text: currentDescription);

    Get.defaultDialog(
      title: 'Edit Note',
      content: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
                labelText: 'Title', hintText: 'Enter new title'),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
                labelText: 'Description', hintText: 'Enter new description'),
          ),
        ],
      ),
      textConfirm: 'Update',
      onConfirm: () {
        todoController.updateTodo(
            todoId, titleController.text, descriptionController.text);
        // titleController.dispose();
        // descriptionController.dispose();
        Get.back();
      },
      textCancel: 'Cancel',
      onCancel: () {
        // titleController.dispose();
        // descriptionController.dispose();
      },
    );
  }
}
