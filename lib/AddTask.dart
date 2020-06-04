

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddPage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddPageState();
  }

}
class AddPageState extends State<AddPage>
{String task;
 String completed;
 String task_id;
  TextEditingController _controller=TextEditingController();
  TextEditingController _controller1=TextEditingController();
TextEditingController _controller2=TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
     body:ListView(
       children: <Widget>[
         SizedBox(
           height: 30,
         ),
         Container(
           height:100,
           child: Center(
             child: Text(
               "Create A New Task ",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),
             ),
           ),
         ),
        TextField(

           controller: _controller,
           decoration: InputDecoration(

             hintText: "Enter the name of task",
             labelText: "Task",
             border: OutlineInputBorder(
               borderRadius: BorderRadius.circular(13),
             )

           ),
        autocorrect: true,
        autofocus: true,
        onChanged: (text)
          {
            task=_controller.text;
          },
        ),
         
         SizedBox(
           height: 20,
         ),
         TextField(

           controller: _controller1,
           decoration: InputDecoration(

               hintText: "Enter yes or no",
               labelText: "Completed",
               border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(13),
               )

           ),
           autocorrect: true,
           autofocus: true,
           onChanged: (text)
           {
             completed=_controller1.text ;
           },
         ),
         SizedBox(
           height: 20,
         ),
         TextField(

           controller: _controller2,
           decoration: InputDecoration(

               hintText: "Enter the Task id",
               labelText: "Id",
               border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(13),
               )

           ),
           autocorrect: true,
           autofocus: true,
           onChanged: (text)
           {
             task_id=_controller2.text;
           },
         ),
         SizedBox(
           height:30 ,
         ),
         Padding(
           padding: EdgeInsets.only(left: 100,right: 100),
         child:RaisedButton(
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(17),
           ),
           child: Center(
             child: Text("Add Task",style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
           ),
           onPressed: ()
           {
            // print(task);
             //print(task_id);
             //print(completed);
           var send=[task ,completed,task_id];
           //print(send[0]);

             Navigator.pop(context,send);
           },
         )
         ),




       ],
     )
    );
  }

}