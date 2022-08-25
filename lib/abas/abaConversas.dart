import 'package:flutter/material.dart';

import '../model/conversas.dart';

class AbaConversas extends StatefulWidget {
  @override
  _AbaConversasState createState() => _AbaConversasState();
}

class _AbaConversasState extends State<AbaConversas> {
  List<Conversa> _conversasList = [];

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
          subtitle: Text(
            conversa.message,
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ); //itemcCount:item.le,
      },
    );
  }
}
