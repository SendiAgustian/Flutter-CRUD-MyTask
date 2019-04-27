import 'package:crud/pages/page_addTask.dart';
import 'package:crud/pages/page_editTask.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyTask extends StatefulWidget {
  @override
  _MyTaskState createState() => _MyTaskState();
}

List dataTask;

class _MyTaskState extends State<MyTask> {

  void _deleteTask(final index){
    Firestore.instance.runTransaction((Transaction transaction) async{
      DocumentSnapshot snapshot =
      await transaction.get(index);
      await transaction.delete(snapshot.reference);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Task"),
        backgroundColor: Colors.indigo,
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('task').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Text('Loading...');
          return ListView(
              children: snapshot.data.documents.map((document) {
            return Column(
              children: <Widget>[
                GestureDetector(
                  child: ListTile(
                      leading: Text(
                        document['duedate'].day.toString() +"/"+ document['duedate'].month.toString()+"/" + document['duedate'].year.toString(),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      title: Text(
                        document['title'] ?? '',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        document['note'] ?? '',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      trailing: Column(
                        children: <Widget>[
                          InkWell(
                            child: Icon(Icons.edit, size: 20,),
                            onTap: (){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) => EditTask(
                                    index: document.reference,
                                    title: document['title'],
                                    note: document['note'],
                                    duedate: document['duedate']
                                  ),
                                ),
                              );
                            },
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 10)),
                          InkWell(
                            child: Icon(Icons.delete, size: 20),
                            onTap: (){
                              final index = document.reference;
                              _deleteTask(index);
                            },
                          ),
                        ],
                      )
                    ),
                ),
                Divider(color: Colors.grey[800], indent:0.0,),
              ],
            );
          }).toList());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) => AddTask()));
        },
        backgroundColor: Colors.indigo,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 20,
        color: Colors.indigo,
        child: ButtonBar(
          children: <Widget>[],
        ),
      ),
    );
  }
}
