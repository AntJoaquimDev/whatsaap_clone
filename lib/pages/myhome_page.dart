import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_whatsaap/services/login.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String? _emailLogado;

  Future<void> _getlogado() async {
    await FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          _emailLogado = '${user.email}';
        });
      }
    });
  }

  Future _singOut() async {
    auth.signOut();
    print('tetset');
    Navigator.push(context, MaterialPageRoute(builder: (_) => Login()));
  }

  @override
  void initState() {
    super.initState();
    _getlogado();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff075e54),
        title: Text('WhatsAap'),
        actions: [
          CircleAvatar(
            child: Image.asset(
              'assets/images/usuario.png',
              fit: BoxFit.cover,
            ),
          ),
          TextButton(onPressed: _getlogado, child: Text('$_emailLogado')),
          IconButton(
            onPressed: _singOut,
            icon: Icon(Icons.exit_to_app_outlined),
          )
        ],
      ),
      body: Container(child: Text("E-mail Logado :${_emailLogado}")),
    );
  }
}
