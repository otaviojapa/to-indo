import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'alterar_senha_screen.dart';

class ConfiguracoesScreen extends StatefulWidget {
  const ConfiguracoesScreen({super.key});

  @override
  State<ConfiguracoesScreen> createState() => _ConfiguracoesScreenState();
}

class _ConfiguracoesScreenState extends State<ConfiguracoesScreen> {
  final _nomeController  = TextEditingController();
  final _emailController = TextEditingController();
  bool  _notificacoesAtivadas = true;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nomeController.text        = prefs.getString('nome')         ?? '';
      _emailController.text       = prefs.getString('email')        ?? '';
      _notificacoesAtivadas       = prefs.getBool('notificacoes')   ?? true;
    });
  }

  Future<void> _salvarConfiguracoes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nome',  _nomeController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setBool  ('notificacoes', _notificacoesAtivadas);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Configurações salvas com sucesso!')),
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  OutlineInputBorder _roundedBorder() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // ---------- Perfil ----------
          const Text(
            'Editar Perfil',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          TextFormField(
            controller: _nomeController,
            decoration: InputDecoration(
              labelText: 'Nome',
              prefixIcon: const Icon(Icons.person),
              border: _roundedBorder(),
            ),
          ),
          const SizedBox(height: 12),

          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'E‑mail ou telefone',
              prefixIcon: const Icon(Icons.email),
              border: _roundedBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 28),
          const Divider(),

          // ---------- Senha ----------
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Alterar senha'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AlterarSenhaScreen()),
              );
            },
          ),

          const Divider(),

          // ---------- Notificações ----------
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Receber notificações',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            activeColor: Theme.of(context).primaryColor,
            value: _notificacoesAtivadas,
            onChanged: (v) => setState(() => _notificacoesAtivadas = v),
          ),

          const Divider(),

          // ---------- Privacidade ----------
          const Text(
            'Política de Privacidade',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            'Seus dados não serão compartilhados com terceiros. '
                'O uso do app está sujeito aos termos de privacidade da aplicação.',
            style: TextStyle(color: Colors.grey[700]),
          ),

          const SizedBox(height: 32),

          // ---------- Botão Salvar ----------
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _salvarConfiguracoes,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Salvar Configurações',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
