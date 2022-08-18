import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:my_whatsaap/services/login.dart';
import 'package:my_whatsaap/utils/appRoutes.dart';

import '../abas/abaContatos.dart';
import '../abas/abaConversas.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  FirebaseAuth auth = FirebaseAuth.instance;
  late TabController _tabController;
  String? _emailLogado;
  List<String> itensSelect = ['ItensConfiguracao'];

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
    await auth.signOut();
    //Navigator.of(context).pushReplacementNamed(AppRoutes.LOGIN);
    // Navigator.push(
    //   context,
    Navigator.pushReplacementNamed(context, '/');
    // );
  }

  @override
  void initState() {
    super.initState();
    _getlogado();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  _onSelected(String itensSelect) {
    print('item escolhido $itensSelect');
  }

  _onConfig() {
    Navigator.restorablePushNamedAndRemoveUntil(
        context, RouteGenerator.ROTA_CONFIGURACAO, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("WhatsApp"),
        actions: [
          CircleAvatar(
            child: Image.asset(
              'assets/images/usuario.png',
              fit: BoxFit.cover,
            ),
          ),
          TextButton(onPressed: _getlogado, child: Text('$_emailLogado')),
          // IconButton(
          //   onPressed: _singOut,
          //   icon: Icon(Icons.exit_to_app_outlined),
          // ),
          PopupMenuButton(
              //onSelected: _onSelected,
              itemBuilder: (context) {
            return itensSelect.map((String item) {
              return PopupMenuItem(
                value: item,
                child: Column(
                  children: [
                    TextButton(
                      onPressed: _onConfig,
                      child: Text('Configuração'),
                    ),
                    TextButton(
                      onPressed: _singOut,
                      child: Text('Sair'),
                    ),
                  ],
                ), //Text(item),
              );
            }).toList();
          }),
        ],
        bottom: TabBar(
          indicatorWeight: 4,
          labelStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(
              text: 'Conversas',
            ),
            Tab(
              text: 'Contatos',
            ),
          ],
        ),
      ),
      body: Container(
        color: Color.fromARGB(253, 242, 242, 237),
        child: TabBarView(
          controller: _tabController,
          children: [
            AbaConversas(),
            AbaContatos(),
          ],
        ),
      ),
    );
  }
}
/** actions: [
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
        ),
      ], */