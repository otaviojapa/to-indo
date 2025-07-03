import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlterarSenhaScreen extends StatefulWidget {
  const AlterarSenhaScreen({super.key});

  @override
  State<AlterarSenhaScreen> createState() => _AlterarSenhaScreenState();
}

class _AlterarSenhaScreenState extends State<AlterarSenhaScreen> {
  final _senhaAtualController = TextEditingController();
  final _novaSenhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();

  Future<void> _alterarSenha() async {
    final prefs = await SharedPreferences.getInstance();
    final senhaSalva = prefs.getString('senha') ?? '1234';

    if (_senhaAtualController.text != senhaSalva) {
      _mostrarErro('Senha atual incorreta.');
      return;
    }

    if (_novaSenhaController.text != _confirmarSenhaController.text) {
      _mostrarErro('As senhas não coincidem.');
      return;
    }

    await prefs.setString('senha', _novaSenhaController.text);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Senha alterada com sucesso!')),
    );
    Navigator.pop(context);
  }

  void _mostrarErro(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red),
    );
  }

  @override
  void dispose() {
    _senhaAtualController.dispose();
    _novaSenhaController.dispose();
    _confirmarSenhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alterar Senha')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextFormField(
              controller: _senhaAtualController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Senha atual',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _novaSenhaController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Nova senha',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _confirmarSenhaController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirmar nova senha',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _alterarSenha,
                child: const Text('Salvar nova senha'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
