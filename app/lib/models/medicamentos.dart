import 'package:atividade04/models/lembrete.dart';

class Medicamento {
  int id;
  String nome;
  String descricao;
  List<Lembrete> lembretes;
  String forma;
  int intervalo;
  int quantidade;
  String dataInicio;
  String dataFim;
  String procedimento;
  String dosagem;

  Medicamento({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.lembretes,
    required this.forma,
    required this.intervalo,
    required this.quantidade,
    required this.dataInicio,
    required this.dataFim,
    required this.procedimento,
    required this.dosagem,
  });

  factory Medicamento.fromJson(Map<String, dynamic> json) {
    return Medicamento(
      id: json['id'],
      nome: json['nome'],
      descricao: json['descricao'],
      lembretes: [],
      forma: json['forma'],
      intervalo: json['intervalo'],
      quantidade: json['quantidade'],
      dataInicio: json['dataInicio'],
      dataFim: json['dataFim'],
      procedimento: json['procedimento'],
      dosagem: json['dosagem'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'lembretes': lembretes.map((e) => e.toJson()).toList(),
      'forma': forma,
      'intervalo': intervalo,
      'quantidade': quantidade,
      'dataInicio': dataInicio,
      'dataFim': dataFim,
      'procedimento': procedimento,
    };
  }
}
