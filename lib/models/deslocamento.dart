class Deslocamento {
  final String origem;
  final String destino;
  final String? transporte;
  final String? mensagem;
  final DateTime inicio;
  DateTime? fim;

  Deslocamento({
    required this.origem,
    required this.destino,
    this.transporte,
    this.mensagem,
    required this.inicio,
    this.fim,
  });
}
