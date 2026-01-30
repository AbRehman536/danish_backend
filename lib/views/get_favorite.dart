import 'package:danish_backend/models/task.dart';
import 'package:danish_backend/services/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user.dart';

class GetFavorite extends StatelessWidget {
  const GetFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Favorite"),
      ),
      body: StreamProvider.value(
          value: TaskServices().getFavoriteTask(userProvider.getUser().docId.toString()),
          initialData: [TaskModel()],
      builder: (context, child){
            List<TaskModel> taskList = context.watch<List<TaskModel>>();
            return ListView.builder(itemBuilder: (BuildContext context, int index) {
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
