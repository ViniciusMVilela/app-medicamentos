class Lembrete {
  int id;
  DateTime horario;
  String mensagem;
  int medicamentoId;

  Lembrete({
    required this.id,
    required this.horario,
    required this.mensagem,
    required this.medicamentoId,
  });

  factory Lembrete.fromJson(Map<String, dynamic> json) {
    return Lembrete(
      id: json['id'],
      horario: DateTime.parse(json['horario']),
      mensagem: json['mensagem'],
      medicamentoId: json['medicamentoId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'horario': horario.toIso8601String(),
      'mensagem': mensagem,
      'medicamentoId': medicamentoId,
    };
  }
}
