import 'package:flutter/material.dart';

import '../model/conversas.dart';

class AbaContatos extends StatefulWidget {
  @override
  _AbaContatosState createState() => _AbaContatosState();
}

class _AbaContatosState extends State<AbaContatos> {
  // ignore: prefer_final_fields
  List<Conversa> _conversasList = [
    Conversa("Celenny Cristhyne", "Olá tudo bem?",
        "https://firebasestorage.googleapis.com/v0/b/whatsapp-36cd8.appspot.com/o/perfil%2Fperfil1.jpg?alt=media&token=97a6dbed-2ede-4d14-909f-9fe95df60e30"),
    Conversa("Yzack", "Me manda o nome daquela série que falamos!",
        "https://firebasestorage.googleapis.com/v0/b/whatsapp-36cd8.appspot.com/o/perfil%2Fperfil2.jpg?alt=media&token=659622c6-4a5d-451a-89b9-05712c64b526"),
    Conversa(
      "Yzabele Tamara",
      "Vamos sair hoje?",
      "https://firebasestorage.googleapis.com/v0/b/whatsapp-36cd8.appspot.com/o/perfil%2Fperfil3.jpg?alt=media&token=99ad2441-7b1a-4940-879c-c62ae4535a01",
    ),
    Conversa(
      "Antnio Joaquim ",
      "Não vai acreditar no que tenho para te contar...",
      "https://console.firebase.google.com/project/whatsapp-7d84b/firestore/data/~2Fusuarios~2FfkMlmBkR9nefbS4xjbHcm7FRyiF2",
    ),
    Conversa("Jamilton Damasceno", "Curso novo!! depois dá uma olhada!!",
        "https://firebasestorage.googleapis.com/v0/b/whatsapp-36cd8.appspot.com/o/perfil%2Fperfil5.jpg?alt=media&token=f6fd2892-f8bd-47bc-b3fc-f0ba0a48fac5"),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _conversasList.length,
      itemBuilder: (contex, index) {
        Conversa conversa = _conversasList[index];
        return ListTile(
          contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          leading: CircleAvatar(
            maxRadius: 25,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(conversa.caminhoFoto),
          ),
          title: Text(
            conversa.nome,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ); //itemcCount:item.le,
      },
    );
  }
}
