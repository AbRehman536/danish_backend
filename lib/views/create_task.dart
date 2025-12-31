import 'package:danish_backend/models/task.dart';
import 'package:danish_backend/services/task.dart';
import 'package:flutter/material.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Task"),
        backgroundColor: Colors.blue,
      ),
      body: Column(children: [
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            label: Text("Name")
          ),
        ),
        TextField(
          controller: descriptionController,
          decoration: InputDecoration(
            label: Text("Description")
          ),
        ),
        isLoading ? Center(child: CircularProgressIndicator(),)
        :ElevatedButton(onPressed: ()async{
          try{
            isLoading = true;
            setState(() {});
            await TaskServices().createTask(TaskModel(
              name: nameController.text.toString(),
              description: descriptionController.text.toString(),
              isCompleted: false,
              createdAt: DateTime.now().millisecondsSinceEpoch
            )).then((value){
              isLoading = false;
              setState(() {});
              showDialog(context: context, builder: (BuildContext context) {
                return AlertDialog(
                  content: Text("Create Successfully"),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }, child: Text("Okay"))
                  ],
                );
              }, );
            });
          }catch(e){
            isLoading = false;
            setState(() {});
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
          }
        }, child: Text("Create Task"))
      ],),
    );
  }
}
