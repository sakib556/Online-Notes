import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:online_notes/auth_controller.dart';
import 'package:online_notes/todo_model.dart';

class TodoController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Observable list of to-do items using the Todo model
  var todos = <TodoModel>[].obs;

  // Fetch user's To-Dos from Firestore and store them as Todo models
  void fetchTodos(String userId) async {
    try {
      var result = await firestore
          .collection('todos')
          .where('userId', isEqualTo: userId)
          .get();
      todos.assignAll(result.docs
          .map((doc) => TodoModel.fromDocumentSnapshot(doc))
          .toList());
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch todos: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // Add new To-Do
  Future<void> addTodo(String userId, String title, String description) async {
    try {
      await firestore.collection('todos').add({
        'userId': userId,
        'title': title,
        'description': description,
      });
      fetchTodos(userId);
    } catch (e) {
      Get.snackbar("Error", "Failed to add todo: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // Update existing To-Do
  Future<void> updateTodo(
      String todoId, String title, String description) async {
    try {
      await firestore.collection('todos').doc(todoId).update({
        'title': title,
        'description': description,
      });
      fetchTodos(Get.find<AuthController>().currentUser!.uid);
    } catch (e) {
      Get.snackbar("Error", "Failed to update todo: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // Delete To-Do
  Future<void> deleteTodo(String todoId) async {
    try {
      await firestore.collection('todos').doc(todoId).delete();
      fetchTodos(Get.find<AuthController>().currentUser!.uid);
    } catch (e) {
      Get.snackbar("Error", "Failed to delete todo: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
