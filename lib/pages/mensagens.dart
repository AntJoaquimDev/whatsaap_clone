// ignore_for_file: use_key_in_widget_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:my_whatsaap/main.dart';
import 'package:my_whatsaap/utils/appRoutes.dart';

import '../model/usuario.dart';

class Mensagens extends StatefulWidget {
  @override
  State<Mensagens> createState() => _MensagensState();
}

class _MensagensState extends State<Mensagens> {
  //static const String ROTA_MENSAGEM = '/mensagens';
  @override
  Widget build(BuildContext context) {
    final argsUser = ModalRoute.of(context)!.settings.arguments as Usuario;
    return Scaffold(
      appBar: AppBar(
        title: Text(argsUser.nome),
        actions: [
          CircleAvatar(
            maxRadius: 25,
            backgroundColor: Colors.grey,
            backgroundImage: argsUser.urlImage != null
                ? NetworkImage(argsUser.urlImage)
                : null,
          )
        ],
        backgroundColor: Colors.green,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text('ListView'),
                Text('Caixa de messagens'),
                //listview,
                //cixaMessaem
              ],
            ),
          ),
        ),
      ),
    );
  }
}
