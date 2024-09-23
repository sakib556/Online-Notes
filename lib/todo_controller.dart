import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:online_notes/auth_controller.dart';

class TodoController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Observable list of to-do items
  var todos = [].obs;

  // Fetch user's To-Dos from Firestore
  void fetchTodos(String userId) async {
    var result = await firestore
        .collection('todos')
        .where('userId', isEqualTo: userId)
        .get();
    todos.assignAll(result.docs.map((doc) => doc.data()));
  }

  // Add new To-Do
  Future<void> addTodo(String userId, String title, String description) async {
    await firestore.collection('todos').add({
      'userId': userId,
      'title': title,
      'description': description,
    });
    fetchTodos(userId);
  }

  // Update existing To-Do
  Future<void> updateTodo(
      String todoId, String title, String description) async {
    await firestore.collection('todos').doc(todoId).update({
      'title': title,
      'description': description,
    });
    fetchTodos(Get.find<AuthController>().currentUser!.uid);
  }

  // Delete To-Do
  Future<void> deleteTodo(String todoId) async {
    await firestore.collection('todos').doc(todoId).delete();
    fetchTodos(Get.find<AuthController>().currentUser!.uid);
  }
}
