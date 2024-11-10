import 'dart:convert';
import 'package:atividade04/models/lembrete.dart';
import 'package:atividade04/models/medicamentos.dart';
import 'package:atividade04/service/api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {
  void main() {
    group('ApiService', () {
      late ApiService apiService;
      late MockClient mockClient;

      setUp(() {
        mockClient = MockClient();
        apiService = ApiService();
      });

      test(
          'fetchMedicamentos retorna uma lista de Medicamento se a resposta for 200 OK',
          () async {
        when(mockClient.get(Uri.parse('http://localhost:3000/medicamentos')))
            .thenAnswer((_) async => http.Response(
                  json.encode([
                    {"id": 1, "nome": "Medicamento A", "dosagem": "10mg"},
                    {"id": 2, "nome": "Medicamento B", "dosagem": "20mg"}
                  ]),
                  200,
                ));

        var medicamentos = await apiService.fetchMedicamentos();

        expect(medicamentos, isA<List<Medicamento>>());
        expect(medicamentos.length, 2);
        expect(medicamentos[0].nome, 'Medicamento A');
      });

      test(
          'fetchMedicamentos lança uma exceção se a resposta for diferente de 200',
          () async {
        when(mockClient.get(Uri.parse('http://localhost:3000/medicamentos')))
            .thenAnswer((_) async => http.Response('Erro', 500));

        expect(() => apiService.fetchMedicamentos(), throwsException);
      });

      test(
          'fetchLembretes retorna uma lista de Lembrete se a resposta for 200 OK',
          () async {
        when(mockClient.get(Uri.parse('http://localhost:3000/lembretes')))
            .thenAnswer((_) async => http.Response(
                  json.encode([
                    {"id": 1, "mensagem": "Lembrete 1", "data": "2024-01-01"},
                    {"id": 2, "mensagem": "Lembrete 2", "data": "2024-02-01"}
                  ]),
                  200,
                ));

        var lembretes = await apiService.fetchLembretes();

        expect(lembretes, isA<List<Lembrete>>());
        expect(lembretes.length, 2);
        expect(lembretes[0].mensagem, 'Lembrete 1');
      });

      test('addMedicamento faz uma requisição POST com sucesso', () async {
        var medicamento = Medicamento(
            id: 1,
            nome: "Medicamento C",
            dosagem: "30mg",
            procedimento: '',
            descricao: '',
            lembretes: [],
            forma: 'Oral',
            intervalo: 8,
            quantidade: 10,
            dataInicio: '2024-01-01',
            dataFim: '2024-01-10');
        when(mockClient.post(
          Uri.parse('http://localhost:3000/medicamentos'),
          headers: {"Content-Type": "application/json"},
          body: json.encode(medicamento.toJson()),
        )).thenAnswer((_) async => http.Response('', 201));

        expect(() async => await apiService.addMedicamento(medicamento),
            returnsNormally);
      });

      test('addMedicamento lança exceção se a resposta não for 201', () async {
        var medicamento = Medicamento(
            id: 1,
            nome: "Medicamento D",
            dosagem: "40mg",
            procedimento: '',
            descricao: '',
            lembretes: [],
            forma: 'Oral',
            intervalo: 8,
            quantidade: 10,
            dataInicio: '2024-01-01',
            dataFim: '2024-01-10');
        when(mockClient.post(
          Uri.parse('http://localhost:3000/medicamentos'),
          headers: {"Content-Type": "application/json"},
          body: json.encode(medicamento.toJson()),
        )).thenAnswer((_) async => http.Response('Erro', 400));

        expect(() async => await apiService.addMedicamento(medicamento),
            throwsException);
      });

      test('addLembrete lança exceção se a resposta não for 201', () async {
        var lembrete = Lembrete(
            id: 1,
            mensagem: "Lembrete 2",
            medicamentoId: 1,
            horario: DateTime.parse("2024-02-01"));
        when(mockClient.post(
          Uri.parse('http://localhost:3000/lembretes'),
          headers: {"Content-Type": "application/json"},
          body: json.encode(lembrete.toJson()),
        )).thenAnswer((_) async => http.Response('Erro', 400));

        expect(() async => await apiService.addLembrete(lembrete),
            throwsException);
      });

      test('deleteMedicamento deleta com sucesso se a resposta for 200 OK',
          () async {
        when(mockClient
                .delete(Uri.parse('http://localhost:3000/medicamentos/1')))
            .thenAnswer((_) async => http.Response('', 200));

        expect(
            () async => await apiService.deleteMedicamento(1), returnsNormally);
      });

      test('deleteMedicamento lança exceção se a resposta não for 200',
          () async {
        when(mockClient
                .delete(Uri.parse('http://localhost:3000/medicamentos/1')))
            .thenAnswer((_) async => http.Response('Erro', 400));

        expect(
            () async => await apiService.deleteMedicamento(1), throwsException);
      });
    });
  }
}
