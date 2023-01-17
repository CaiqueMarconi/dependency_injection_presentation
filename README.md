# dependency_injection_presentation

# Oque é injeção de dependencia

```A injeção de dependência(DI) é um padrão de projeto cujo objetivo é manter um baixo acoplamento 
entre diferentes módulos de um sistema. Assim ao realizar a injeção de dependência estamos fornecendo 
aos objetos do nosso sistema outros objetos dos quais eles dependem com baixo acoplamento.


# vantagens da injeção de dependencias

Reutilização de classes e dissociação de dependências: é mais fácil trocar implementações de uma dependência. 
A reutilização de código é aprimorada devido à inversão de controle, e as classes não controlam mais como 
as dependências são criadas. Em vez disso, funcionam com qualquer configuração.

Facilidade de refatoração: as dependências se tornam uma parte verificável da superfície da API para que 
possam ser verificadas no momento da criação do objeto ou no momento da compilação, em vez de serem ocultadas 
como detalhes de implementação.

Facilidade de testes: uma classe não gerencia as próprias dependências. Portanto, ao fazer um teste, 
você pode transmitir diferentes implementações para verificar todos os diferentes casos.

# exemplo acoplado sem injeção de dependencia

class HttpService implements IHttpService {
  @override
  Future<void> getHtpp() async {
    try {
      var response = await Dio().get('http://www.google.com');
      if (kDebugMode) {
        print(response);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

// dessa forma além do codigo ficar muito acoplado, tambem não conseguimos testar o nosso metodo,
// pois eu n consigo passar meu dio pra dentro do metodo no test.


# neste app simples vou mostrar algumas formas de se utilizar injeção de dependencias

1. sem uso de package e injetando via parametro
exemplo: 

class HttpService implements IHttpService {
  @override
  Future<void> getHtpp(Dio http) async {
    try {
      var response = await http.get('http://www.google.com');
      if (kDebugMode) {
        print(response);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

// neste exemplo podemos ver que o Dio é pedido via parametro fazendo com que quem chamar o meu metodo
tenha que injetar a minha dependencia do Dio.

2. passando por construtor que é a forma mais comum de injeção de dependencia

class HttpService implements IHttpService {
  final Dio http;

  HttpService(this.http);
  @override
  Future<void> getHtpp() async {
    try {
      var response = await http.get('http://www.google.com');
      if (kDebugMode) {
        print(response);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

// eu peço o meu service por construtor aproveitando o principio de imutabilidade com final.
// com isso eu consigo testar meu metodo, pois posso criar uma instancia do meu DIO com mock.

# observação: em nosso arquivo HomePageInjectionWithoutPackage podemos visualizar a utilização deste service 
# injetado dentro do HomeController

 

# certo até aqui vimos oque é, vantagens e exemplos de injeção de dependencias,
# mas agora vamos utilizar um package para melhor gerenciar nossas injeções de dependencias

# Realizaremos nossas injeções de dependencias com o package provider

para sua utlização é necessario apenas inserir o package no nosso pubspec.yaml e
passar o Widget MultiProvider como pai do nosso MaterialApp, por sua vez o MultiProvider
vai requerir a implementação do atributo providers que é uma lista de nossas classes
e então ficará como no exemplo abaixo.

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<HomeController>(
            create: ((context) => HomeController(HttpService(Dio()))))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePageInjectionWithPackage(
            title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

como podemos ver na linha 92 realizamos a criação do nosso provider<HomeController>
e injetamos suas dependencias, agora aonde quisermos recuperar o nosso HomeController
passamos apenas o seguinte Provider.of<HomeController>(context) e tambem podemos atribuir
isto a uma variavel e utilizar todos os metodos e variaveis da nossa classe HomeController,
como foi feito no arquivo 'HomePageInjectionWithPackage'.
```