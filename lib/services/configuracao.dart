import 'package:flutter/material.dart';

import '../utils/appRoutes.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Configuracao extends StatefulWidget {
  const Configuracao({Key? key}) : super(key: key);

  @override
  State<Configuracao> createState() => _ConfiguracaoState();
}

class _ConfiguracaoState extends State<Configuracao> {
  TextEditingController _controllerNome = TextEditingController();

  Future _recuperarImagem() async {
    File _imageSelecionada;
    // if(_imageSelecionada ){

    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Configurações'),
        ),
        body: Center(
          child: Container(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 90,
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(
                            "https://firebasestorage.googleapis.com/v0/b/whatsapp-36cd8.appspot.com/o/perfil%2Fperfil1.jpg?alt=media&token=97a6dbed-2ede-4d14-909f-9fe95df60e30"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(onPressed: () {}, child: Text('Camera')),
                          TextButton(onPressed: () {}, child: Text('aleria'))
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: TextField(
                          controller: _controllerNome,
                          autofocus: false,
                          keyboardType: TextInputType.name,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(32, 16, 32, 16),
                              hintText: 'Nome',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                            primary: Colors.green,
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 20),
                            textStyle: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.restorablePushNamedAndRemoveUntil(context,
                                RouteGenerator.ROTA_HOME, (_) => false);
                          },
                          child: Text(
                            'Atualizar',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ));
  }
}
