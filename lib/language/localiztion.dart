import 'package:ecommerce/component/my_string.dart';
import 'package:ecommerce/language/ar.dart';
import 'package:ecommerce/language/en.dart';
import 'package:ecommerce/language/fr.dart';
import 'package:get/route_manager.dart';
class Localiztion extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        eng: en,
        arb: ar,
        frn: fr,
      };
}
