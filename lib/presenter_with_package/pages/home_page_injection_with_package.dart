import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/home_controller.dart';

class HomePageInjectionWithPackage extends StatefulWidget {
  const HomePageInjectionWithPackage({super.key, required this.title});
  final String title;

  @override
  State<HomePageInjectionWithPackage> createState() =>
      _HomePageInjectionWithPackageState();
}

class _HomePageInjectionWithPackageState
    extends State<HomePageInjectionWithPackage> {
  @override
  Widget build(BuildContext context) {
    // com provider inicializamos nosso package como pai do nosso MaterialApp e então
    // podemos recuperar a instancia de nossas injeções com Provider.of<HomeController>(context)
    final controller = Provider.of<HomeController>(context);
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
