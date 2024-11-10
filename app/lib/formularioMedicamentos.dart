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
  final _procedimentoController = TextEditingController();
  final _formaController = TextEditingController();
  final _intervaloController = TextEditingController();
  final _quantidadeController = TextEditingController();
  final _dosagemController = TextEditingController();
  final _dataInicioController = TextEditingController();
  final _dataFimController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.medicamento != null) {
      _nomeController.text = widget.medicamento!.nome;
      _descricaoController.text = widget.medicamento!.descricao;
      _procedimentoController.text = widget.medicamento!.procedimento;
      _formaController.text = widget.medicamento!.forma;
      _intervaloController.text = widget.medicamento!.intervalo.toString();
      _quantidadeController.text = widget.medicamento!.quantidade.toString();
      _dosagemController.text = widget.medicamento!.dosagem.toString();
      _dataInicioController.text = widget.medicamento!.dataInicio.toString();
      _dataFimController.text = widget.medicamento!.dataFim.toString();
    }
  }

  void _salvarMedicamento() {
    if (_formKey.currentState!.validate()) {
      final novoMedicamento = Medicamento(
        id: widget.medicamento?.id ?? Random().nextInt(1000),
        nome: _nomeController.text,
        descricao: _descricaoController.text,
        procedimento: _procedimentoController.text,
        lembretes: [],
        forma: _formaController.text,
        intervalo: int.parse(_intervaloController.text),
        quantidade: int.parse(_quantidadeController.text),
        dosagem: _dosagemController.text,
        dataInicio: _dataInicioController.text,
        dataFim: _dataFimController.text,
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
              TextFormField(
                controller: _procedimentoController,
                decoration: const InputDecoration(labelText: 'Procedimento'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o procedimento do medicamento';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _formaController,
                decoration: const InputDecoration(labelText: 'Forma'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a forma do medicamento';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _intervaloController,
                decoration: const InputDecoration(labelText: 'Intervalo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o intervalo do medicamento';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _quantidadeController,
                decoration: const InputDecoration(labelText: 'Quantidade'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a quantidade do medicamento';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dosagemController,
                decoration: const InputDecoration(labelText: 'Dosagem'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a dosagem do medicamento';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dataInicioController,
                decoration: const InputDecoration(labelText: 'Data de Início'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a data de início do medicamento';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dataFimController,
                decoration: const InputDecoration(labelText: 'Data de Fim'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a data de fim do medicamento';
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
