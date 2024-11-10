import 'dart:math';

import 'package:atividade04/service/api_service.dart';
import 'package:flutter/material.dart';
import '../models/medicamentos.dart';

class FormularioMedicamentoPage extends StatefulWidget {
  final Medicamento? medicamento;

  const FormularioMedicamentoPage({super.key, this.medicamento});

  @override
  _FormularioMedicamentoPageState createState() =>
      _FormularioMedicamentoPageState();
}

class _FormularioMedicamentoPageState extends State<FormularioMedicamentoPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.medicamento != null) {
      _nomeController.text = widget.medicamento!.nome;
      _descricaoController.text = widget.medicamento!.descricao;
    }
  }

  void _salvarMedicamento() {
    if (_formKey.currentState!.validate()) {
      final novoMedicamento = Medicamento(
        id: widget.medicamento?.id ?? Random().nextInt(1000).toString(),
        nome: _nomeController.text,
        descricao: _descricaoController.text,
        procedimento: '',
        lembretes: [],
        forma: '',
        intervalo: '',
        quantidade: '',
        dosagem: '',
        dataInicio: '',
        dataFim: '',
      );
      final apiService = ApiService();
      apiService.addMedicamento(novoMedicamento).then((_) {
        Navigator.pop(context);
      }).catchError((e) {
        print("Erro ao salvar medicamento: $e");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.medicamento == null
            ? 'Novo Medicamento'
            : 'Editar Medicamento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration:
                    const InputDecoration(labelText: 'Nome do Medicamento'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do medicamento';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição do medicamento';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarMedicamento,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
