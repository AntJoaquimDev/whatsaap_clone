import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:my_whatsaap/pages/mensagens.dart';
import 'package:my_whatsaap/pages/myhome_page.dart';
import 'package:my_whatsaap/services/configuracao.dart';

import '../services/form_cadastro.dart';
import '../services/login.dart';

class RouteGenerator {
  static const String ROTA_LOGIN = '/login';
  static const String ROTA_HOME = '/myhome_page';
  static const String ROTA_CADASTRO = '/form_cadastro';
  static const String ROTA_CONFIGURACAO = '/configuracao';
  static const String ROTA_MENSAGEM = '/mensagens';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => Login());

      case ROTA_LOGIN:
        return MaterialPageRoute(builder: (_) => Login());

      case ROTA_HOME:
        return MaterialPageRoute(builder: (_) => MyHome());

      case ROTA_CADASTRO:
        return MaterialPageRoute(builder: (_) => FormCadastro());
      case ROTA_CONFIGURACAO:
        return MaterialPageRoute(builder: (_) => Configuracao());
      case ROTA_MENSAGEM:
        return MaterialPageRoute(builder: (_) => Mensagens());

      default:
        _erroRout();
    }
    return MaterialPageRoute(builder: (_) => Login());
  }

  static Route<dynamic> _erroRout() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Tela não encntrada!'),
        ),
        body: Center(
          child: Text('Tela não encntrada!'),
        ),
      );
    });
  }
}
