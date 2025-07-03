import 'package:flutter/material.dart';
import '../models/deslocamento.dart';
import '../models/deslocamento_manager.dart';
import 'home_screen.dart';

class DeslocamentoAtivoScreen extends StatelessWidget {
  final String origem;
  final String destino;
  final String? transporte;
  final String? mensagem;

  const DeslocamentoAtivoScreen({
    super.key,
    required this.origem,
    required this.destino,
    this.transporte,
    this.mensagem,
  });

  void _finalizarDeslocamento(BuildContext context) {
    final deslocamento = Deslocamento(
      origem: origem,
      destino: destino,
      transporte: transporte,
      mensagem: mensagem,
      inicio: DateTime.now(),
    );

    DeslocamentoManager().adicionarDeslocamento(deslocamento);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Deslocamento Ativo")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.navigation, size: 80, color: Color(0xFF001F54)),

              const SizedBox(height: 20),

              Text(
                "Deslocamento em andamento",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),

              const SizedBox(height: 30),

              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _infoRow("Origem", origem),
                      const SizedBox(height: 12),
                      _infoRow("Destino", destino),
                      if (transporte != null) ...[
                        const SizedBox(height: 12),
                        _infoRow("Transporte", transporte!),
                      ],
                      if (mensagem != null && mensagem!.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        _infoRow("Mensagem", mensagem!),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _finalizarDeslocamento(context),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    "Finalizar Deslocamento",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label: ",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
