import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:todolist/main.dart';



var title=TextEditingController();
var description=TextEditingController();
class addTask extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return addTaskState();
  }

}


class addTaskState extends State<addTask>{
  @override
  Widget build(BuildContext context) {
  return Scaffold(

appBar: AppBar(
  title: const Text("Add Task Screen"),
),

body: Center(
  
  child:SingleChildScrollView(
    physics: const NeverScrollableScrollPhysics(),
    child: Container(
      child: Column(
        children: [
    
              Container(
    
                    width: 350,
                    height: 60,
    
                child: TextField(
                  style: TextStyle(fontSize: 15),
                  controller:title,
                  maxLines: 6,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    hintText: "Titile Here",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Colors.blueAccent)
                    )        
                  ),
                  ),
              ),
    
        const   Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 5)),
    
                    Container(
                      width: 300,
                      
                      child: TextField(
                                    minLines: 5,
                                    maxLines: 8,
                                    controller:description,
                                    decoration: InputDecoration(
                                        hintText: "Description  Here",
                                      focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Colors.blueAccent)
                                      )        
                                    ),
                                    ),
                    ),
  const   Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 5)),
                  Container(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(onPressed: (){



                      postData(title.text.toString(), description.text.toString(), context);
                      
                    }, child: const Text("Add task"))
                  )
    
    
        ]
        
        ),
      ),
  ) 
  
  ),



  );
  }

}




Future<int> postData(String title,String description,BuildContext context)async{

final uri=Uri.parse('https://api.nstack.in/v1/todos');


  var body={
  "title": title,
  "description": description,
  "is_completed": 'false'
};

final response= await http.post(uri,body: body);

print(response.statusCode);

if(response.statusCode==201){
   print(response.statusCode.toString());
   ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(title+" "+description),backgroundColor: Colors.blueAccent,));



Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: 'okk',)));

  return response.statusCode;
 
}
else{
     ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("Sorry Error"),backgroundColor: Colors.redAccent,));

  return response.statusCode;
}


}