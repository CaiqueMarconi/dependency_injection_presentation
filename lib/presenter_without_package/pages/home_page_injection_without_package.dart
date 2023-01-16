import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../service/http_service.dart';
import '../../controllers/home_controller.dart';

class HomePageInjectionWithoutPackage extends StatefulWidget {
  const HomePageInjectionWithoutPackage({super.key, required this.title});
  final String title;

  @override
  State<HomePageInjectionWithoutPackage> createState() =>
      _HomePageInjectionWithoutPackageState();
}

class _HomePageInjectionWithoutPackageState
    extends State<HomePageInjectionWithoutPackage> {
  // aqui vemos que possui uma camada e o HttpService esta sendo injetado
  // quando passamos algo por parametro chamamos de injeção de dependencia
  // neste caso aqui fica simples o entendimento e facil injetar a dependencia
  // que o home controller pede, mais imagine se fossem diversas injeções neste HomeController

  final controller = HomeController(
    HttpService(Dio()),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await controller.callHttp();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
