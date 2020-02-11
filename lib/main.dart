import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(BlocApp());

class BlocApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter - Exemplo de BLoC',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MeuBloc bloc = MeuBloc();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter para Iniciantes - BLoC'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<int>(
                stream: bloc.minhaStream,
                initialData: 0,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Há um erro na Stream');
                  } else {
                    return Text(
                      '${snapshot.data}',
                      style: Theme.of(context).textTheme.display1,
                    );
                  }
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: bloc.incrementar,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class MeuBloc {
  // Variável inteira total e seu get
  int _total = 0;
  int get total => _total;

  // Variável final que inicializa o StreamController
  final _blocController = StreamController<int>();

  // Retorna a Stream para quem deseja observar seus eventos
  Stream<int> get minhaStream => _blocController.stream;

  // Incremente a variável total e adiciona à Stream
  void incrementar() {
    _total++;
    _blocController.sink.add(total);
  }

  // Fecha a Stream
  fecharStream() {
    _blocController.close();
  }
}
