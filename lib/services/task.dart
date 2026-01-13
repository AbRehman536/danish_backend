import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task.dart';

class TaskServices{
  String taskCollection = "TaskCollection";
  ///Create Task
  Future createTask(TaskModel model)async{
    DocumentReference documentReference = await FirebaseFirestore.instance
    .collection(taskCollection)
    .doc();
    return await FirebaseFirestore.instance
        .collection(taskCollection)
        .doc(documentReference.id)
        .set(model.toJson(documentReference.id));
  }
  ///Update Task
  Future updateTask(TaskModel model)async{
    return await FirebaseFirestore.instance
        .collection(taskCollection)
        .doc(model.docId)
        .update({"name" : model.name, "description": model.description});
  }
  ///Delete Task
  Future deleteTask(String taskID)async{
    return await FirebaseFirestore.instance
        .collection(taskCollection)
        .doc(taskID)
        .delete();
  }
  ///Mark As Completed
  Future markAsCompletedTask({required String taskID, required bool isCompleted})async{
    return await FirebaseFirestore.instance
        .collection(taskCollection)
        .doc(taskID)
        .update({"isCompleted" : isCompleted,});
  }
  ///Get All Task
  Stream<List<TaskModel>> getAllTask(){
    return FirebaseFirestore.instance
        .collection(taskCollection)
        .snapshots()
        .map((taskList)=> taskList.docs
        .map((taskJson) => TaskModel.fromJson(taskJson.data())).toList(),
    );
  }
  ///Get InCompleted Task
  Stream<List<TaskModel>> getInCompletedTask(){
    return FirebaseFirestore.instance
        .collection(taskCollection)
        .where("isCompleted" , isEqualTo: false)
        .snapshots()
        .map((taskList)=> taskList.docs
        .map((taskJson) => TaskModel.fromJson(taskJson.data())).toList(),
    );
  }
  ///Get Completed Task
  Stream<List<TaskModel>> getCompletedTask(){
    return FirebaseFirestore.instance
        .collection(taskCollection)
        .where("isCompleted" , isEqualTo: true)
        .snapshots()
        .map((taskList)=> taskList.docs
        .map((taskJson) => TaskModel.fromJson(taskJson.data())).toList(),
    );
  }

  ///get task by priorityID
  Stream<List<TaskModel>> getTaskByPriorityID(String priorityID){
    return FirebaseFirestore.instance
        .collection(taskCollection)
        .where("priorityID" , isEqualTo: priorityID)
        .snapshots()
        .map((taskList)=> taskList.docs
        .map((taskJson) => TaskModel.fromJson(taskJson.data())).toList()
    );
  }
}