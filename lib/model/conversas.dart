class Conversa {
  String _nome;
  String _message;
  String _caminhoFoto;

  Conversa(
    this._nome,
    this._message,
    this._caminhoFoto,
  );

  String get nome => this._nome;

  set nome(String value) => this._nome = value;

  String get message => this._message;

  set message(value) => this._message = value;

  String get caminhoFoto => this._caminhoFoto;

  set caminhoFoto(value) => this._caminhoFoto = value;
}
