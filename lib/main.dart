import 'package:carey/bootstrap.dart';

Future<void> main() async {
  bootstrap(
    () => const MainApp(),
  );
}

Future<void> bootstrapModule() async {
  bootstrap(
        () => const MainApp(),
  );
}
