import 'deslocamento.dart';

class DeslocamentoManager {
  static final DeslocamentoManager _instance = DeslocamentoManager._internal();
  factory DeslocamentoManager() => _instance;
  DeslocamentoManager._internal();

  final List<Deslocamento> _historico = [];

  void adicionarDeslocamento(Deslocamento deslocamento) {
    _historico.insert(0, deslocamento); // último no topo
  }

  List<Deslocamento> getHistorico() => List.unmodifiable(_historico);
}
