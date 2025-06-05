import 'package:flutter/material.dart';
import 'package:gym_app/_comum/minhas_cores.dart';
import 'package:gym_app/modelo/exercicio_modelo.dart';
import 'package:gym_app/modelo/sentimento_modelo.dart';

class ExercicioTela extends StatelessWidget {
  ExercicioTela({super.key});

  final ExercicioModelo exercicioModelo = ExercicioModelo(
    id: 'EX001',
    nome: 'Remada Baixa Supinada',
    treino: 'Treino A',
    comoFazer: 'Segura a barra e puxa',
  );

  final List<SentimentoModelo> listaSentimentos = [
    SentimentoModelo(
      id: 'SE001',
      sentindo: 'Pouca ativação hoje',
      data: '2025-06-04',
    ),
    SentimentoModelo(
      id: 'SE002',
      sentindo: 'Já senti alguma ativação hoje',
      data: '2025-06-05',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              exercicioModelo.nome,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            Text(exercicioModelo.treino, style: TextStyle(fontSize: 15)),
          ],
        ),
        centerTitle: true,
        backgroundColor: MinhasCores.azulEscuro,
        elevation: 0,
        toolbarHeight: 72,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.vertical(
            bottom: Radius.circular(32),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('FAB FOI CLICADO!');
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListView(
          children: [
            SizedBox(
              height: 250,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: () {}, child: Text('Enviar Foto')),
                  ElevatedButton(onPressed: () {}, child: Text('Tirar Foto')),
                ],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Como Fazer?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(exercicioModelo.comoFazer),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(color: Colors.black),
            ),
            Text(
              'Como estou me sentindo?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(listaSentimentos.length, (index) {
                SentimentoModelo sentimentoAgora = listaSentimentos[index];
                return ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(sentimentoAgora.sentindo),
                  subtitle: Text(sentimentoAgora.data),
                  leading: Icon(Icons.double_arrow),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      print('DELETAR ${sentimentoAgora.sentindo}');
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
