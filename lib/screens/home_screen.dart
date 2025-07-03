import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/deslocamento_ativo_screen.dart';
import '../screens/historico_screen.dart';
import '../screens/configuracoes_screen.dart';
import 'login_screen.dart'; // Adicione este import se ainda não estiver

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _origemController = TextEditingController();
  final _destinoController = TextEditingController();
  final _mensagemController = TextEditingController();

  String? _meioTransporte;

  void _compartilharDeslocamento() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DeslocamentoAtivoScreen(
            origem: _origemController.text,
            destino: _destinoController.text,
            transporte: _meioTransporte,
            mensagem: _mensagemController.text.isEmpty
                ? null
                : _mensagemController.text,
          ),
        ),
      );
    }
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');

    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
    );
  }

  @override
  void dispose() {
    _origemController.dispose();
    _destinoController.dispose();
    _mensagemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar Deslocamento"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _origemController,
                decoration: const InputDecoration(
                  labelText: "De onde você está saindo?",
                ),
                validator: (value) =>
                value == null || value.isEmpty ? 'Informe a origem' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _destinoController,
                decoration: const InputDecoration(
                  labelText: "Para onde você vai?",
                ),
                validator: (value) =>
                value == null || value.isEmpty ? 'Informe o destino' : null,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _meioTransporte,
                isExpanded: true,
                items: const [
                  DropdownMenuItem(value: 'Carro', child: Text('Carro')),
                  DropdownMenuItem(value: 'Ônibus', child: Text('Ônibus')),
                  DropdownMenuItem(value: 'Metrô', child: Text('Metrô')),
                  DropdownMenuItem(value: 'Bicicleta', child: Text('Bicicleta')),
                  DropdownMenuItem(value: 'A pé', child: Text('A pé')),
                ],
                onChanged: (value) => setState(() => _meioTransporte = value),
                decoration: const InputDecoration(
                  labelText: "Meio de Transporte (opcional)",
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _mensagemController,
                decoration: const InputDecoration(
                  labelText: "Mensagem adicional (opcional)",
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _compartilharDeslocamento,
                child: const Text("Compartilhar"),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HistoricoScreen()),
                ),
                child: const Text("Ver Histórico"),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ConfiguracoesScreen(),
                    ),
                  );
                },
                child: const Text("Configurações"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}