import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_notes/auth_controller.dart';
import 'package:online_notes/todo_controller.dart';

class HomeScreen extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    String userId = authController.currentUser!.uid;
    todoController.fetchTodos(userId); // Fetch todos for the current user

    return Scaffold(
      appBar: AppBar(
        title: Text("My To-Dos"),
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
            var todo = todoController.todos[index];
            return ListTile(
              title: Text(todo['title']),
              subtitle: Text(todo['description']),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _editTodoDialog(
                        todo['id'], todo['title'], todo['description']),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => todoController.deleteTodo(todo['id']),
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTodoDialog(),
        child: Icon(Icons.add),
      ),
    );
  }

  _addTodoDialog() {
    String title = '';
    String description = '';
    Get.defaultDialog(
      title: 'Add To-Do',
      content: Column(
        children: [
          TextField(
            onChanged: (value) => title = value,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            onChanged: (value) => description = value,
            decoration: InputDecoration(labelText: 'Description'),
          ),
        ],
      ),
      textConfirm: 'Add',
      onConfirm: () {
        todoController.addTodo(
            authController.currentUser!.uid, title, description);
        Get.back();
      },
      textCancel: 'Cancel',
    );
  }

  _editTodoDialog(
      String todoId, String currentTitle, String currentDescription) {
    String title = currentTitle;
    String description = currentDescription;
    Get.defaultDialog(
      title: 'Edit To-Do',
      content: Column(
        children: [
          TextField(
            onChanged: (value) => title = value,
            decoration:
                InputDecoration(labelText: 'Title', hintText: currentTitle),
          ),
          TextField(
            onChanged: (value) => description = value,
            decoration: InputDecoration(
                labelText: 'Description', hintText: currentDescription),
          ),
        ],
      ),
      textConfirm: 'Update',
      onConfirm: () {
        todoController.updateTodo(todoId, title, description);
        Get.back();
      },
      textCancel: 'Cancel',
    );
  }
}
