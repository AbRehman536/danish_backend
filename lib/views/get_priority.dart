import 'package:danish_backend/models/task.dart';
import 'package:danish_backend/services/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/priority.dart';

class GetPriority extends StatefulWidget {
  final PriorityModel model;
  const GetPriority({super.key, required this.model});

  @override
  State<GetPriority> createState() => _GetPriorityState();
}

class _GetPriorityState extends State<GetPriority> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("${widget.model.name} Priority Task"),
      ),
      body: StreamProvider.value(
          value: TaskServices().getTaskByPriorityID(widget.model.docId.toString()),
          initialData: [TaskModel()],
      builder: (context, child){
            List<TaskModel> taskList = context.watch<List<TaskModel>>();
            return ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (BuildContext context, int index){
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(taskList[index].name.toString()),
                subtitle: Text(taskList[index].description.toString()),
              );
            });
      },
      ),
    );
  }
}
