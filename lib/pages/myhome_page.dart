import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  String? _nomeLogado;
  String? _idUserLogado;
  String? _url;

  List<String> itensSelect = ['ItensConfiguracao'];

  final db = FirebaseFirestore.instance;
  _recupearDadosUser() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        _idUserLogado = '${user.uid}';

        await db
            .collection('usuarios')
            .doc(_idUserLogado)
            .snapshots()
            .listen((snapshot) {
          Map<String, dynamic>? dadosRecUser = snapshot.data();
          _url = dadosRecUser!['urlImagem'];

          if (dadosRecUser['urlImagem'] != null) {
            setState(() {
              _url = dadosRecUser['urlImagem'];
              _nomeLogado = dadosRecUser['nome'];
            });
          }
        });
      }
    });
  }

  Future _singOut() async {
    await auth.signOut();
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  void initState() {
    super.initState();
    _recupearDadosUser();

    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );
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
        title: Text(
          "WhatsApp",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          CircleAvatar(
            backgroundImage: NetworkImage(_url!),
          ),
          TextButton(onPressed: () {}, child: Text('$_nomeLogado')),
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
