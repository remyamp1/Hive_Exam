import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
class TODO extends StatefulWidget {
  

  @override
  State<TODO> createState() => _TODOState();
}

class _TODOState extends State<TODO> {
  late Box box;
  TextEditingController list=TextEditingController();
  List <String> todoitems=[];
  @override
  void initState(){
    super.initState();
    box=Hive.box('mybox');
    _loadtodoit();
  }
  _loadtodoit()async{
List<String>? task=box.get('todoitems')?.cast <String>();{
  if(task !=null){
    setState(() {
      todoitems=task;
    });
  }
}
  }
  _savetodoitem(){
    setState(() {
      box.put('todoitems', todoitems);
    });
  }
   void _addtodoitem(String item){
    setState(() {
      if (item.isNotEmpty){
        todoitems.add(list.text);
      list.clear();
      }
    });
    _savetodoitem();
    
  }
void _removetodoitem(int index){
  setState(() {
    todoitems.removeAt(index);
  });
  _savetodoitem();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TODO With HIVE'),
      backgroundColor: Colors.yellow,),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
        SizedBox(
          height: 60,
          width: 300,
          child: TextField(
            controller: list,
            decoration: InputDecoration(border: OutlineInputBorder()),)),
        SizedBox(height: 10),
        ElevatedButton(onPressed: (){
          _addtodoitem(list.text);
        }, child: Text('Add')),
        Expanded(child: ListView.builder(
          itemCount: todoitems.length,
          itemBuilder: (context,index){
          return ListTile(
            title: Text(todoitems[index],
          ),
          trailing: GestureDetector(
            onTap: () {
        setState(() {
          _removetodoitem(index);
          
        },);
            },child: Icon(Icons.delete,color: Colors.red,)
          ),
          );
        }))
        
            ],
          ),
        ),
      ),
    );
  }
}