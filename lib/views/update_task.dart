import 'package:danish_backend/models/task.dart';
import 'package:danish_backend/services/task.dart';
import 'package:flutter/material.dart';

class UpdateTask extends StatefulWidget {
  final TaskModel model;
  const UpdateTask({super.key, required this.model});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    nameController = TextEditingController(
      text: widget.model.name.toString()
    );
    descriptionController = TextEditingController(
      text: widget.model.description.toString()
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Task"),
        backgroundColor: Colors.yellow,
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
            await TaskServices().updateTask(TaskModel(
                docId: widget.model.docId,
                name: nameController.text.toString(),
                description: descriptionController.text.toString(),
                isCompleted: false,
                createdAt: DateTime.now().millisecondsSinceEpoch
            )).then((value){
              isLoading = false;
              setState(() {});
              showDialog(context: context, builder: (BuildContext context) {
                return AlertDialog(
                  content: Text("Update Successfully"),
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
        }, child: Text("Update Task"))
      ],),
    );
  }
}
