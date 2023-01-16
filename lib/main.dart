import 'package:dependency_injection_presentation/controllers/home_controller.dart';
import 'package:dependency_injection_presentation/presenter_with_package/pages/home_page_injection_with_package.dart';
import 'package:dependency_injection_presentation/service/http_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // este widget e seus providers pertencem ao package provider para controle de injeção de dependencias
    return MultiProvider(
      // o MultiProvider é inicializado como pai do nosso MaterialApp e nos possibilita
      // fazer todas nossas injeções passando na lista abaixo, com isso o provider
      // se encarrega de gerenciar nossas injeções de dependencias
      providers: [
        Provider<HomeController>(
            create: ((context) => HomeController(HttpService(Dio())))),
      ],
      //
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:
            const HomePageInjectionWithPackage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
