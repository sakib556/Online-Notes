import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String id;
  String userId;
  String title;
  String description;

  TodoModel(
      {required this.id,
      required this.userId,
      required this.title,
      required this.description});

  // Factory method to create a Todo from a Firestore document
  factory TodoModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return TodoModel(
      id: doc.id,
      userId: doc['userId'],
      title: doc['title'],
      description: doc['description'],
    );
  }

  // Method to convert Todo back to JSON for Firestore updates
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
      'description': description,
    };
  }
}
