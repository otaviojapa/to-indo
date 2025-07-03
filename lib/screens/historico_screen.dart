import 'package:flutter/material.dart';
import '../models/deslocamento_manager.dart';
import '../models/deslocamento.dart';
import 'package:intl/intl.dart';

class HistoricoScreen extends StatelessWidget {
  const HistoricoScreen({super.key});

  String _formatarData(DateTime data) {
    final formatter = DateFormat('dd/MM/yyyy – HH:mm');
    return formatter.format(data);
  }

  @override
  Widget build(BuildContext context) {
    final List<Deslocamento> historico = DeslocamentoManager().getHistorico();

    return Scaffold(
      appBar: AppBar(title: const Text("Histórico de Deslocamentos")),
      body: historico.isEmpty
          ? const Center(
        child: Text(
          "Nenhum deslocamento salvo ainda.",
          style: TextStyle(fontSize: 16),
        ),
      )
          : ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: historico.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final d = historico[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Color(0xFF001F54)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "${d.origem} → ${d.destino}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 20, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text(
                        _formatarData(d.inicio),
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  if (d.transporte != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.directions_transit, size: 20, color: Colors.grey),
                        const SizedBox(width: 6),
                        Text(
                          d.transporte!,
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                  if (d.mensagem != null && d.mensagem!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.message, size: 20, color: Colors.grey),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            d.mensagem!,
                            style: const TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
