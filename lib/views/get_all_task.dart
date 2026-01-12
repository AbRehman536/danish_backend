import 'package:danish_backend/models/task.dart';
import 'package:danish_backend/services/task.dart';
import 'package:danish_backend/views/create_task.dart';
import 'package:danish_backend/views/get_completed_task.dart';
import 'package:danish_backend/views/get_incompleted_task.dart';
import 'package:danish_backend/views/update_task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetAllTask extends StatelessWidget {
  const GetAllTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Task"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetCompletedTask()));
          }, icon: Icon(Icons.task_alt)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetInCompletedTask()));
          }, icon: Icon(Icons.incomplete_circle)),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateTask()));
      },child: Icon(Icons.add),),
      body: StreamProvider.value(
          value: TaskServices().getAllTask(),
          initialData: [TaskModel()],
        builder: (context, child){
            List<TaskModel> taskList = context.watch<List<TaskModel>>();
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(Icons.task),
                  title: Text(taskList[index].name.toString()),
                  subtitle: Text(taskList[index].description.toString()),
                  trailing: Row(
                    children: [
                      Checkbox(
                          value: taskList[index].isCompleted,
                          onChanged: (value)async{
                            try{
                              await TaskServices().markAsCompletedTask(
                                  taskID: taskList[index].docId.toString(),
                                  isCompleted: value!);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text("Mark As Completed")));
                            }catch(e){
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text(e.toString())));
                            }
                          }),
                      IconButton(onPressed: ()async{
                        try{
                          await TaskServices().deleteTask(taskList[index].docId.toString());
                        }catch(e){
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      },
                          icon: Icon(Icons.delete)),
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateTask(model: taskList[index])));
                      }, icon: Icon(Icons.edit))
                    ],
                  ),
                );
              },);
        },

      ),
    );
  }
}
