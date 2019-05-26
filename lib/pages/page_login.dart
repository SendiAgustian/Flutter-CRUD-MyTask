import 'package:crud/pages/page_task.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controller1 = new TextEditingController();
  TextEditingController controller2 = new TextEditingController();

  final Firestore _database = Firestore.instance;
  String nama, username, password;

  _getLogin() {
    _database.collection('users').getDocuments().then((docs) {
      for (int i = 0; i < docs.documents.length; i++) {
        _initData(docs.documents[i].data, docs.documents[i].documentID);
      }
    });
  }

  _initData(data, dokId) {
    if (username == data['username'] && password == data['password']) {
      setState(() {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyTask(
                    nama: data['nama'],
                    username: data['username'],
                    password: data['password'],
                    dataId: dokId,
                  ),
            ));
      });
    }
  }

  // _login(username, password){

  // }

  @override
  void initState() {
    super.initState();
    // _getLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.indigo,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('images/ic_launcher.png'),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                TextField(
                  controller: controller1,
                  decoration: new InputDecoration(
                    labelText: "Username",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                TextField(
                  controller: controller2,
                  decoration: new InputDecoration(
                    labelText: "Password",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  padding: EdgeInsets.all(9.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.input, color: Colors.white),
                      SizedBox(width: 10.0),
                      Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          // fontFamily:'Comfortaa',
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    username = controller1.text;
                    password = controller2.text;
                    // _login(username, password);
                    _getLogin();
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Belum punya akun? ',
                      style: TextStyle(
                          color: Colors.black
                        ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text(
                        'Daftar disini!',
                        style: TextStyle(
                          color: Colors.blue
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}