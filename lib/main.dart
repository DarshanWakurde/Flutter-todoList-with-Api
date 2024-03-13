import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:todolist/addTasks.dart';
import 'package:http/http.dart' as http;
import 'package:todolist/listpojo.dart';

List<Items> listdata=[];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home ePag'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


Future<void> delete(String id,BuildContext context) async{

var url=Uri.parse('https://api.nstack.in/v1/todos/$id');

final response=await http.delete(url);

if(response.statusCode==200){
listTodo();
ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Deleted"),backgroundColor: Colors.redAccent,));

}
else{
  print("not Sorry");
}

}

  @override
  Widget build(BuildContext context) {

      return Scaffold(

            appBar:  AppBar(

                title: const Text("Todo List"),
            
            ),


            body: Center(
              
              child:FutureBuilder(
                future: listTodo(),
                builder: (context, snapshot){

                    return ListView.builder(
                    itemBuilder: (context, index) {

                          

                       return Dismissible(
                         key:Key(listdata[index].sId.toString()),
                        background: Container(
                          color: Colors.redAccent,
                          child: const Icon(Icons.delete,color: Colors.white,),
                          alignment: Alignment.centerRight,
                        ),
                        onDismissed: (direction) {
                          delete(listdata[index].sId.toString(), context);
                        },
                        direction: DismissDirection.endToStart,
                         child: Card(child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                           children: [
                             Text(listdata[index].title.toString(),style: TextStyle(color: Colors.white),),
                             Container(width: 150,
                             height: 40,
                             child: ElevatedButton(
                              style: ButtonStyle(backgroundColor:MaterialStateColor.resolveWith((states) => Colors.white38)),
                              onPressed: (){
                                delete(listdata[index].sId.toString(),context);
                                setState(() {listdata; });
                                  // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>MyHomePage(title: "okk")));
                                print("deleted");
                              },
                              child: const Text("Delete",style: TextStyle(fontSize: 15,color: Color.fromARGB(255, 20, 14, 14)),)
                              ),)
                           ],
                         )),
                       );

                    },
                    itemCount: listdata.length,
                    );

                }, 
                ),
              
              
              ),

            floatingActionButton:FloatingActionButton(
              tooltip: "Add Task",
              isExtended: true,
              onPressed: (){
              
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>addTask()));
            },
            
            backgroundColor: Colors.teal,
            child: const Text("Add Task",textAlign: TextAlign.center,),
          
            ),




      );

  }
  

  
}




Future<List<Items>> listTodo() async{

var url=Uri.parse('https://api.nstack.in/v1/todos?page=1&limit=10');
final response=await http.get(url);

var    data=jsonDecode(response.body.toString());


print(response.statusCode);
if(response.statusCode==200){
 listdata.clear();
for(Map<String,dynamic> i in data['items']){
 
    listdata.add(Items.fromJson(i));

}


return listdata;
}else{
  print("Sorry");
  return listdata;
}
}






