import 'dart:io';

class Usuario {
  late String _nome;
  late String _email;
  late String _senha;
  File? _storedImage;

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

  set nome(String value) {
    _nome = value;
  }

  File get storedImage => _storedImage!;
  set storedImage(File image) {
    _storedImage = image;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'nome': this.nome,
      'email': this.email,
      'storedImage': this.storedImage,
    };
    return map;
  }
}
