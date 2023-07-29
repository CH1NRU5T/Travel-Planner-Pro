import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'BASEURL', obfuscate: true)
  static String baseUrl = _Env.baseUrl;
  @EnviedField(varName: 'KEY', obfuscate: true)
  static String key = _Env.key;
}
