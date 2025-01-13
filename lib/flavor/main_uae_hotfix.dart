import 'flavors.dart';

import '../main.dart' as runner;

Future<void> main() async {
  F.appFlavor = Flavor.uaeHotfix;
  await runner.main();
}
