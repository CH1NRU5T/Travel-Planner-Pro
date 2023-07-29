import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'BASEURL', obfuscate: true)
  static String baseUrl = _Env.baseUrl;
}
