// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../model/usuario.dart';
import '../utils/appRoutes.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Configuracao extends StatefulWidget {
  const Configuracao({Key? key}) : super(key: key);

  @override
  State<Configuracao> createState() => _ConfiguracaoState();
}

class _ConfiguracaoState extends State<Configuracao> {
  final store = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  late File _imagem;
  late XFile _imagmSelecionada;
  final ImagePicker _picker = ImagePicker();
  TextEditingController _controllerNome = TextEditingController();
  bool _statusUpload = false;
  FirebaseStorage _storage = FirebaseStorage.instance;
  String? _urlImageRecupada;

  String? _idUserLogado;
  String _mensageErro = '';
  var _dadosRecUser;

  Future _recuperarImageCameraOrGallerr(bool isCamera) async {
    if (isCamera) {
      _imagmSelecionada = (await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 100,
      ))!;
    } else {
      _imagmSelecionada = (await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 100,
      ))!;
    }
    setState(() {
      _imagem = File(_imagmSelecionada.path);
      if (_imagem != null) {
        _statusUpload = true;
        _uploadImage();
      }
    });
  }

  _recupearDadosUser2() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? usuarioLogado = await auth.currentUser;
    String _idUsuarioLogado = usuarioLogado!.uid;
  }

  _recupearDadosUser() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        _idUserLogado = '${user.uid}';
        store.collection('usuarios').snapshots().listen((snapshot) {
          for (var item in snapshot.docs) {
            _dadosRecUser = item.data();
            _controllerNome.text = _dadosRecUser['nome'];
            _urlImageRecupada = _dadosRecUser['urlImagem'];
            if (_dadosRecUser['urlImagem'] != null) {
              setState(() {
                _urlImageRecupada = _dadosRecUser['urlImagem'];
                _controllerNome.text = _dadosRecUser['nome'];
              });
            }
          }
        });
      }
    });
  }

  Future _uploadImage() async {
    AsyncSnapshot<TaskSnapshot> asyncSnapshot; //referenciar o arquivo

    Reference pastaRaiz = _storage.ref();
    Reference arquivo =
        pastaRaiz.child('perfil').child('$_idUserLogado.jpg'); //fazer upload

    UploadTask task = arquivo.putFile(_imagem);
    task.snapshotEvents.listen((taskSnapshot) {
      if (taskSnapshot.state == TaskState.running) {
        setState(() {
          _statusUpload = true;
        });
      } else if (taskSnapshot.state == TaskState.success) {
        setState(() {
          _statusUpload = false;
        });
      }
      //_recuperarUrlImagem(taskSnapshot);
      task.whenComplete(() async => _recuperarUrlImagem(taskSnapshot));
    });
  }

  Future _recuperarUrlImagem(TaskSnapshot snapshot) async {
    String url = await snapshot.ref.getDownloadURL();
    _atualizarUrImageFirestone(url);

    setState(() {
      _urlImageRecupada = url;
    });
  }

  _atualizarUrImageFirestone(String url) {
    Map<String, dynamic> dadosAtualizar = {"urlImagem": url};
    store.collection('usuarios').doc(_idUserLogado).update(dadosAtualizar);
  }

  Future<void> _atualizarDocFirebase() async {
    store.collection('usuarios').doc(_idUserLogado).update({
      'nome': _controllerNome.text,
    });
  }

  @override
  void initState() {
    super.initState();
    _recupearDadosUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff075e54),
          title: Text(
            'Configurações',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.restorablePushNamedAndRemoveUntil(
                    context, RouteGenerator.ROTA_HOME, (_) => false);
              },
              icon: Icon(Icons.exit_to_app_sharp),
            )
          ],
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    _statusUpload ? CircularProgressIndicator() : Container(),
                    SizedBox(
                      height: 10,
                    ),
                    CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.grey,
                        backgroundImage: _urlImageRecupada != null
                            ? NetworkImage(_urlImageRecupada!)
                            : null),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            _recuperarImageCameraOrGallerr(true);
                          },
                          child: Text(
                            'Camera',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _recuperarImageCameraOrGallerr(false);
                          },
                          child: Text(
                            'Galeria',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 5),
                      child: TextField(
                        controller: _controllerNome,
                        autofocus: false,
                        keyboardType: TextInputType.name,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
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
                          _atualizarDocFirebase();
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
            ),
          ),
        ));
  }
}
