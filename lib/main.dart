
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'AddTask.dart';
import 'UpdateTask.dart';

void main()
{
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home()
  ));
}
class Home extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }

}
class HomeState extends State<Home> {
  String task='';
  bool Completed=false;
  int task_id=2;
  var result;
int i=1;
String url = 'http://192.168.1.85:8000/ToDo/';
  @override
  void initState()
  {
    super.initState();
    this._makeGetRequest();
    //this._makePostRequest()

  }
  Map<String,dynamic> map;
  List data;
   Future <List> _makeGetRequest() async {
    // make GET request

    http.Response response = await http.get(url);
     map=json.decode(response.body);
     setState(() {
       data=map['ToDo'];
     });

    return data;
    // print(data);


  }
  Future<List> makePutRequest(int j) async {
    // set up PUT request arguments
    String url1='http://192.168.1.85:8000/ToDo/'+"$j"+'/';
    String task2=task;
    int id1=task_id;
    bool Comp1=Completed;
    print(task2);
    print(id1);
    print(Comp1);
    Map<String, String> headers = {"Content-type": "application/json"};
    String json ='{"title":"${task2}","completed":"${Comp1}","task_id":"${id1}","date":"2020-04-30T16:59:09.166100Z"}';
    // make PUT request
    http.Response response = await http.put(url1, headers: headers, body: json);
    // check the status code for the result
    int statusCode = response.statusCode;
    // this API passes back the updated item with the id added
    String body = response.body;
    print(body);
    data=_makeGetRequest() as List;
    return data;

  }
 Future<List> _makeDeleteRequest(int j) async {
  // post 1
  // make DELETE request
   String url1='http://192.168.1.85:8000/ToDo/'+"$j"+'/';
   print(url1);
  http.Response response = await http.delete(url1);
  print(response.body);
  data=_makeGetRequest() as List;
  return data;
}
Future<List> _makePostRequest() async {
  // set up POST request arguments
print(task);
print(Completed);
print(task_id);
String task1=task;
int id=task_id;
bool Comp=Completed;
  Map<String, String> headers = {"Content-type": "application/json"};
  String json ='{"title":"${task1}","completed":"${Comp}","task_id":"${id}","date":"2020-04-30T16:59:09.166100Z"}';
  // make POST request
  http.Response response = await http.post(url, headers: headers, body: json);
  // check the status code for the result
  int statusCode = response.statusCode;
  // this API passes back the id of the new item added to the body
  String body = response.body;
  print(body);
  data=_makeGetRequest() as List;
  return data;
  print(body);
}


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
     backgroundColor: Colors.amberAccent,
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://images.all-free-download.com/images/graphiclarge/beautiful_color_of_the_background_color_vector_158815.jpg",
                  ),
                  fit: BoxFit.fill,
                )
              ),
            ),
            ListView(
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[


                      Padding(
                        padding: EdgeInsets.all(20),
                        child:Text(
                          "Hello Aditya", style: TextStyle(color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                        ),),

                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 500,
                  width: double.infinity,
                  child: ListView.builder(
                      itemCount: data.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,i){
                        return(
                            Padding(

                              padding: EdgeInsets.all(10),
                              child: Container(
                                height: 500,
                                width: 250,
                                decoration:BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(
                                              12,12
                                          ),
                                          color: Colors.black38

                                      )
                                    ]
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(25),
                                          child: Text("TASK NO ${data[i]['task_id']}",style: TextStyle(fontWeight: FontWeight.bold),),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Text("Completed : ${data[i]['completed']}",style: TextStyle(fontWeight: FontWeight.bold),),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 90,
                                    ),
                                    Center(
                                      child: Text(data[i]['title'],style: TextStyle(fontSize: 34,fontWeight: FontWeight.bold),),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                 Container(
                                   width:170,
                                    height:40,
                                    decoration:BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(10,10),
                                      color: Colors.grey
                                    )
                                  ]
                               ),
                                    child:MaterialButton(


                                      child: Center(
                                        child: Text("Tap To Delete"),
                                      ),
                                      color: Colors.amberAccent,
                                     onPressed:()
                                        {
                                            setState(() {

                                              data=_makeDeleteRequest(data[i]['id']) as List;
                                            });
                                        }
                                    )
                                 ),
                                  SizedBox(
                                    height: 70,
                                  )  ,
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                        child:Text("Date Created: ${data[i]['date']}",style: TextStyle(fontWeight: FontWeight.bold),)
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Center(
                                      child: Container(
                                        height: 40,
                                        width: 170,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(10,10),
                                              color: Colors.grey,
                                            ),

                                          ],

                                        ),
                                        child: MaterialButton(
                                         onPressed: () async
                                          {
                                            result= await Navigator.push( context, MaterialPageRoute(builder: (context)=>UpPage()));
                                            task=result[0];
                                            task_id=int.parse(result[2]) ;
                                            if(result[1]=='yes')
                                              Completed=true;
                                            else
                                              Completed=false;
                                            //print(task);
                                            //print(Completed);
                                            //print(task_id);
                                            setState(() {
                                              data =makePutRequest(data[i]['id']) as List;
                                            });
                                          },
                                          color:Colors.orange,
                                          child: Center(
                                            child: Text("Tap To Update",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),
                                        ),
                                      ),
                                    )

                                  ],


                                ),


                              ),
                            )
                        );
                      }),
                ),
                SizedBox(height: 10,),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 120,
                    ),
                    Container(
                      width: 180,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(10,10),
                            color: Colors.black38
                          )
                        ]
                      ),
                      child: MaterialButton(
                        onPressed: ()
                        async {
                       result= await Navigator.push( context, MaterialPageRoute(builder: (context)=>AddPage()));
                       task=result[0];
                       task_id=int.parse(result[2]) ;
                       if(result[1]=='yes')
                         Completed=true;
                       else
                         Completed=false;
                       //print(task);
                       //print(Completed);
                       //print(task_id);
                        setState(() {
                          data =_makePostRequest() as List;
                        });

                       },

                        child: Row(
                          children: <Widget>[
                            Icon(Icons.add,color: Colors.amberAccent,size: 34 ,),
                            Padding(
                              padding: EdgeInsets.all(6),
                            ),
                            Text("Add Task",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 17),)

                          ],
                        ),
                      ),
                    )
                  ],
                )
                    ]
                ),

              ],
            )

        );
  }
}