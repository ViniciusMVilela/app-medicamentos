import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/medicamentos.dart';
import '../models/lembrete.dart';

class ApiService {
  final String baseUrl = "http://localhost:3000";
  final String _medicamentosRecurso = "medicamentos";
  final String _lembretesRecurso = "lembretes";

  Future<List<Medicamento>> fetchMedicamentos() async {
    final response =
        await http.get(Uri.parse('$baseUrl/$_medicamentosRecurso'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Medicamento.fromJson(data)).toList();
    } else {
      throw Exception('Falha ao carregar medicamentos');
    }
  }

  Future<List<Lembrete>> fetchLembretes() async {
    final response = await http.get(Uri.parse('$baseUrl/$_lembretesRecurso'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Lembrete.fromJson(data)).toList();
    } else {
      throw Exception('Falha ao carregar lembretes');
    }
  }

  Future<void> addMedicamento(Medicamento medicamento) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$_medicamentosRecurso'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(medicamento.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Erro ao adicionar medicamento');
    }
  }

  Future<void> addLembrete(Lembrete lembrete) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$_lembretesRecurso'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(lembrete.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Erro ao adicionar lembrete');
    }
  }

  Future<void> deleteMedicamento(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$_medicamentosRecurso/$id'),
    );
    if (response.statusCode != 200) {
      throw Exception('Erro ao remover medicamento');
    }
  }
}
