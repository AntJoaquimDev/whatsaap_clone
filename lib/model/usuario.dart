// ignore_for_file: unnecessary_getters_setters

import 'dart:io';

class Usuario {
  late String _nome;
  late String _email;
  late String _senha;
  late String _urlImage;

  String get urlImage => this._urlImage;

  set urlImage(String urlImage) => this._urlImage = urlImage;

  Usuario();

  String get senha => _senha;

  set senha(String value) {
    _senha = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get nome => _nome;

  set nome(String nome) {
    _nome = nome;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'nome': this._nome,
      'email': this._email,
      'senha': this._senha,
      'urlImage': this._urlImage,
    };
    return map;
  }
}
