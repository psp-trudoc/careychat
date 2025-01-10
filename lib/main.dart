import 'dart:convert';

import 'package:carey/features/carey_home/presentation/pages/carey_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures Flutter is properly initialized before any async operations.
  await configureAmplify(); // Call the Amplify configuration here.
  runApp(const MyApp());
}

Future<void> configureAmplify() async {
  try {
    // Load the JSON file
    final configString = await rootBundle.loadString('assets/aws/awsconfiguration.json');
    final amplifyConfig = jsonDecode(configString);

    // Add Amplify plugins
    final apiPlugin = AmplifyAPI();
    await Amplify.addPlugins([apiPlugin]);

    // Configure Amplify using the loaded config
    // await Amplify.configure(jsonEncode(amplifyConfig));
    print('Amplify configured successfully');
  } catch (e) {
    print('Failed to configure Amplify: $e');
  }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CareyHomePage(),
    );
  }
}
