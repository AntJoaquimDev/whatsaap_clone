import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_whatsaap/services/form_cadastro.dart';

import '../model/usuario.dart';
import '../pages/myhome_page.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _controllerEmail =
      TextEditingController(text: 'abc@gmail.com');
  TextEditingController _controllerSenha =
      TextEditingController(text: '123456');
  String _mensageErro = '';

  _validarCampos() {
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;
    Usuario usuario = Usuario();

    if (email.isNotEmpty && email.contains('@')) {
      if (senha.isNotEmpty) {
        setState(() {
          _mensageErro = '';
        });

        usuario.email = email;
        usuario.senha = senha;
        _logarUser(usuario);
      } else {
        setState(() {
          _mensageErro = 'Esqueceu a senha? Se não faça o seu cadastro.  ';
        });
      }
    } else {
      setState(() {
        _mensageErro = 'E-mail não pode ser vazio ou nao é válido. ';
      });
    }
  }

  Future<void> _logarUser(Usuario usuario) async {
    auth
        .signInWithEmailAndPassword(
      email: usuario.email,
      password: usuario.senha,
    )
        .then((auth) {
      setState(() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHome()));
      });
    }).catchError((error) {
      setState(() {
        _mensageErro =
            'Erro ao tentar logar usuário, verifique os campos e tente novamente';
      });
    });
  }

  Future<void> _verivarUserLogad() async {
    User? user = await auth.currentUser;
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MyHome(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _verivarUserLogad();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Color(0xff075E54)),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              //width: 390,
              width: deviceSize.width * 0.35,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 200,
                      height: 150,
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
                    keyboardType: TextInputType.visiblePassword,
                    controller: _controllerSenha,
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
                      onPressed: _validarCampos,
                      child: Text(
                        'Entrar',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                        child: Text(
                          'Não tem Conta? cadastre-se!',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          _validarCampos();
                          setState(() {
                            _mensageErro;
                          });
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (ctx) => FormCadastro()),
                          );
                        }

                        //Navigator.pushNamed(context, '/FormCadastro'),

                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 10),
                    child: Center(
                      child: Text(
                        _mensageErro,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
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
/*
onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ScreenServico()),
                      ),*/