import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracoesScreen extends StatefulWidget {
  const ConfiguracoesScreen({super.key});

  @override
  State<ConfiguracoesScreen> createState() => _ConfiguracoesScreenState();
}

class _ConfiguracoesScreenState extends State<ConfiguracoesScreen> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  bool _notificacoesAtivadas = true;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nomeController.text = prefs.getString('nome') ?? '';
      _emailController.text = prefs.getString('email') ?? '';
      _notificacoesAtivadas = prefs.getBool('notificacoes') ?? true;
    });
  }

  Future<void> _salvarConfiguracoes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nome', _nomeController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setBool('notificacoes', _notificacoesAtivadas);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Configurações salvas com sucesso!")),
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Configurações")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text("Editar Perfil",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextFormField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: "Nome"),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "E-mail ou telefone"),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            const Text("Notificações",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SwitchListTile(
              title: const Text("Receber notificações"),
              value: _notificacoesAtivadas,
              onChanged: (value) {
                setState(() {
                  _notificacoesAtivadas = value;
                });
              },
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            const Text("Política de Privacidade",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(
              "Seus dados não serão compartilhados com terceiros. "
                  "O uso do app está sujeito aos termos de privacidade da aplicação.",
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _salvarConfiguracoes,
              child: const Text("Salvar Configurações"),
            ),
          ],
        ),
      ),
    );
  }
}
