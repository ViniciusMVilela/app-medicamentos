import 'package:atividade04/formularioMedicamentos.dart';
import 'package:atividade04/service/api_service.dart';
import 'package:flutter/material.dart';
import '../models/medicamentos.dart';

class ListaMedicamentosPage extends StatefulWidget {
  const ListaMedicamentosPage({super.key});

  @override
  _ListaMedicamentosPageState createState() => _ListaMedicamentosPageState();
}

class _ListaMedicamentosPageState extends State<ListaMedicamentosPage> {
  List<Medicamento> _medicamentos = [];
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _carregarMedicamentos();
  }

  void _carregarMedicamentos() async {
    try {
      final medicamentos = await _apiService.fetchMedicamentos();
      setState(() {
        _medicamentos = medicamentos;
      });
    } catch (e) {
      print('Erro ao carregar medicamentos: $e');
    }
  }

  void _editarMedicamento(Medicamento medicamento) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            FormularioMedicamentoPage(medicamento: medicamento),
      ),
    );

    if (result != null) {
      setState(() {
        int index = _medicamentos.indexWhere((med) => med.id == medicamento.id);
        if (index != -1) {
          _medicamentos[index] = result;
        }
      });
    }
  }

  void _removerMedicamento(int id) async {
    try {
      await _apiService.deleteMedicamento(id);
      setState(() {
        _medicamentos.removeWhere((med) => med.id == id);
      });
    } catch (e) {
      print('Erro ao remover medicamento: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Medicamentos'),
      ),
      body: _medicamentos.isEmpty
          ? const Center(child: Text('Nenhum medicamento encontrado'))
          : ListView.builder(
              itemCount: _medicamentos.length,
              itemBuilder: (context, index) {
                final medicamento = _medicamentos[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(medicamento.nome),
                    subtitle: Text(medicamento.descricao),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editarMedicamento(medicamento),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _removerMedicamento(
                              int.parse(medicamento.id as String)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
