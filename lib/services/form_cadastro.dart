// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_whatsaap/model/usuario.dart';
import 'package:my_whatsaap/pages/myhome_page.dart';
import 'package:my_whatsaap/utils/appRoutes.dart';

class FormCadastro extends StatefulWidget {
  const FormCadastro({Key? key}) : super(key: key);

  @override
  State<FormCadastro> createState() => _FormCadastroState();
}

class _FormCadastroState extends State<FormCadastro> {
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _mensageErro = '';

  _validarCampos() {
    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;
    Usuario usuario = Usuario();

    if (nome.isNotEmpty && nome.length >= 3) {
      if (email.isNotEmpty && email.contains('@')) {
        if (senha.isNotEmpty && senha.length >= 6) {
          setState(() {
            _mensageErro = '';
          });

          usuario.nome = nome;
          usuario.email = email;
          usuario.senha = senha;
          _cadastrarUser(usuario);
        } else {
          setState(() {
            _mensageErro =
                'Senha não pode  ser vazio e Ter mais que 5 caracteres. ';
          });
        }
      } else {
        setState(() {
          _mensageErro = 'E-mail não pode ser vazio ou nao é válido. ';
        });
      }
    } else {
      setState(() {
        _mensageErro =
            'Nome não pode ser vazio e deve ter mais que 3 caracteres. ';
      });
    }
  }

  Future<void> _cadastrarUser(Usuario usuario) async {
    auth
        .createUserWithEmailAndPassword(
      email: usuario.email,
      password: usuario.senha,
    )
        .then((auth) {
      final db = FirebaseFirestore.instance;

      db.collection('usuarios').doc(auth.user!.uid).set(
            usuario.toMap(),
          );
      Navigator.restorablePushNamedAndRemoveUntil(
          context, RouteGenerator.ROTA_HOME, (_) => false);
    }).catchError((error) {
      setState(() {
        _mensageErro =
            'Erro ao cadastrar usuário,verifique os campos e tente novament';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro Usuário'),
        backgroundColor: Color(0xff075e54),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Color(0xff075E54)),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: deviceSize.width * 0.35,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Image.asset(
                      'assets/images/usuario.png',
                      width: 200,
                      height: 150,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
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
                    padding: EdgeInsets.only(bottom: 8),
                    child: TextField(
                      controller: _controllerEmail,
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          hintText: 'E-mail',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32))),
                    ),
                  ),
                  TextField(
                    controller: _controllerSenha,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: 'Senha',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        textStyle: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        _validarCampos();

                        Navigator.restorablePushNamedAndRemoveUntil(
                            context, RouteGenerator.ROTA_HOME, (_) => false);
                        setState(() {
                          _mensageErro = 'Usuário cadastrado com Sucesso';
                        });
                      },
                      child: Text(
                        'Cadastrar',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      _mensageErro,
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
