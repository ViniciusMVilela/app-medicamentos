import 'package:atividade04/listaMedicamentos.dart';
import 'package:flutter/material.dart';

class AppMedicametos extends StatelessWidget {
  const AppMedicametos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Medicações',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ListaMedicamentosPage(),
    );
  }
}
