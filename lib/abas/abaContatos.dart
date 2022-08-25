// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_whatsaap/model/usuario.dart';
import 'package:my_whatsaap/utils/appRoutes.dart';

// ignore: unused_import
import '../model/conversas.dart';

class AbaContatos extends StatefulWidget {
  @override
  _AbaContatosState createState() => _AbaContatosState();
}

class _AbaContatosState extends State<AbaContatos> {
  // ignore: prefer_final_fields

  //final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

  final db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  String? _idUsuarioLogado;
  String? _emailUsuarioLogado;
  var dados;
  List<Usuario> listaUsuarios = [];

  Future<List<Usuario>> _recuperarContatos() async {
    QuerySnapshot querySnapshot = await db.collection("usuarios").get();

    List<Usuario> listaUsuarios = [];
    for (DocumentSnapshot item in querySnapshot.docs) {
      dados = item.data();
      if (dados['email'] == _emailUsuarioLogado) continue;

      Usuario usuario = Usuario();
      usuario.email = dados["email"];
      usuario.nome = dados["nome"];
      usuario.urlImage = dados["urlImagem"];

      listaUsuarios.add(usuario);
    }

    return listaUsuarios;
  }

  _recuperarDadosUsuario() async {
    User? userLogado = await auth.currentUser;
    if (userLogado != null) {
      _idUsuarioLogado = userLogado.uid;
      _emailUsuarioLogado = userLogado.email;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _recuperarDadosUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Usuario>>(
      future: _recuperarContatos(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Column(
                children: [
                  Text('Carregando...'),
                  CircularProgressIndicator(),
                ],
              ),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (contex, index) {
                  List<Usuario> listaItens = snapshot.data!;
                  Usuario usuario = listaItens[index];

                  return ListTile(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteGenerator.ROTA_MENSAGEM,
                        arguments: usuario,
                      );
                    },
                    contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    leading: CircleAvatar(
                        maxRadius: 25,
                        backgroundColor: Colors.grey,
                        backgroundImage: usuario.urlImage != null
                            ? NetworkImage(usuario.urlImage)
                            : null //firebasestorage.googleapis.com/v0/b/whatsapp-36cd8.appspot.com/o/perfil%2Fperfil1.jpg?alt=media&token=97a6dbed-2ede-4d14-909f-9fe95df60e30"),
                        ),
                    title: Text(
                      usuario.nome,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ); //itemcCount:item.le,
                });
            break;
        }
      },
    );
  }
}
