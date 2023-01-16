import 'package:dependency_injection_presentation/service/i_http_service.dart';

class HomeController {
  final IHttpService _httpService;

  HomeController(this._httpService);

  Future<void> callHttp() async {
    await _httpService.getHtpp();
  }
}
