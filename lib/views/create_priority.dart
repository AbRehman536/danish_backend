import 'package:danish_backend/models/priority.dart';
import 'package:danish_backend/services/priority.dart';
import 'package:flutter/material.dart';

class CreatePriority extends StatefulWidget {
  final PriorityModel model;
  final bool isUpdateMode;
  const CreatePriority({super.key, required this.model, required this.isUpdateMode});

  @override
  State<CreatePriority> createState() => _CreatePriorityState();
}

class _CreatePriorityState extends State<CreatePriority> {
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    if(widget.isUpdateMode == true){
    nameController = TextEditingController(
        text: widget.model.name.toString()
    );}
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isUpdateMode ? "Update Priority" : "Create Priority" ),
        backgroundColor: widget.isUpdateMode ? Colors.yellow : Colors.blue,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          TextField(controller: nameController,),
          isLoading ? Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
                try{
                  isLoading = true;
                  setState(() {});
                  if(widget.isUpdateMode == true){
                    await PriorityServices().updatePriority(
                      PriorityModel(
                        name: nameController.text.toString(),
                        docId: widget.model.docId,
                        createdAt: DateTime.now().millisecondsSinceEpoch
                      )
                    ).then((val){
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
                  }else{
                    await PriorityServices().createPriority(
                        PriorityModel(
                            name: nameController.text.toString(),
                            createdAt: DateTime.now().millisecondsSinceEpoch
                        )
                    ).then((val){
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
                  }
                }catch(e){
                  isLoading = false;
                  setState(() {});
                  ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.toString())));
                }
          },child: Text(widget.isUpdateMode ? "Update Priority" : "Create Priority"),)
        ],
      ),
    );
  }
}
