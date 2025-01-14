import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:carey/app_provider_scope.dart';
import 'package:carey/core/loggers/app_logger.dart';
import 'package:carey/core/network/api_client.dart';
import 'package:carey/core/network/connection_cubit.dart';
import 'package:carey/core/network/dio_client.dart';
import 'package:carey/core/utils/app_pref_service.dart';
import 'package:carey/core/widgets/refresh_widget_tree.dart';
import 'package:carey/features/carey_home/data/datasource/chat_data_source.dart';
import 'package:carey/features/carey_home/data/repository/chat_connect_repository_imp.dart';
import 'package:carey/features/carey_home/domain/repository/chat_connect_repository.dart';
import 'package:carey/features/carey_home/domain/usecase/chat_register_use_case.dart';
import 'package:carey/features/carey_home/presentation/bloc/index.dart';
import 'package:carey/features/carey_home/presentation/pages/carey_home_page.dart';
import 'package:carey/flavor/flavors.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';

import 'core/config/app_config.dart';

final getIt = GetIt.instance;

Future<void> setupScreenSettings() async {
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
}

Future<void> setupInjections() async {
  print("setupInjections");
 // await setupFlavorConfig();
  // Bloc.observer = const AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  EasyLocalization.ensureInitialized();
  await setupDateTime();
  await setupSharedPrefsInjections();
  // await setupHydratedStorage();
  await setupSystemSingletons();
  // await setupFirebase();
  // await setupFirebaseMessaging();
  await setupAppHelpers();
  await setupNetworking();
  await setupScreenSettings();
  await setupDataSource();
  await setupUseCases();
  await setupBlocs();
  await configureAmplify();
}

Future<void> setupAppHelpers() async {
  // getIt.registerSingleton<AppInfo>(AppInfo());
  // getIt.registerSingleton<LoginHelper>(LoginHelper(getIt()));
  // getIt.registerSingleton<OmronBleHelper>(OmronBleHelper());
  // getIt.registerSingleton<ForaBleHelper>(ForaBleHelper());
  // getIt.registerSingleton<BleHelper>(BleHelper());
  // getIt.registerSingleton<BluetoothUtil>(BluetoothUtil());
}

Future<void> setupFlavorConfig() async {
  print("setupFlavorConfig 1");
  print(F.envName);
  await AppConfig.loadEnv(F.envName);
  print("setupFlavorConfig 2");
}

Future<void> setupSharedPrefsInjections() async {
  getIt.registerFactory<AppPreferenceService>(() => AppPreferenceService());
  print("setupSharedPrefsInjections");
}

Future<void> setupNetworking() async {
  final dioClient = DioHelper.configureDio();
  getIt.registerSingleton<APIClient>(APIClient(dioClient));
  getIt.registerLazySingleton(() => Connectivity());
  getIt.registerFactory(() => ConnectionCubit(getIt()));
  print("setupNetworking");
}

Future<void> setupFirebase() async {}

Future<void> setupSystemSingletons() async {}

Future<void> setupUseCases() async {
  getIt.registerLazySingleton(() => ChatRegisterUserUseCase(getIt()));
}

Future<void> setupBlocs() async {
  print("setupBlocs");
  getIt.registerFactory<ChatConnectBloc>(() => ChatConnectBloc(getIt()));
}

Future<void> setupDataSource() async {
  getIt.registerLazySingleton<ChatConnectRepository>(
    () => ChatConnectRepositoryImp(getIt()),
  );
  getIt.registerLazySingleton<ChatDataSource>(
    () => ChatDataSourceImpl(getIt()),
  );
}

Future<void> setupDateTime() async {
  // timeago.setLocaleMessages('en_short', CustomShortMessages());
  // timeago.setLocaleMessages('en', CustomMessages());
  // timeago.setLocaleMessages('ar_short', CustomShortMessages());
  // timeago.setLocaleMessages('ar', CustomMessages());
  // DateFormat.useNativeDigitsByDefaultFor("ar", false);
}

Future<void> configureAmplify() async {
  try {
    // Load the JSON file
    final configString =
        await rootBundle.loadString('assets/aws/awsconfiguration.json');
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

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MainApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return AppProviderScope(
      child: RefreshWidgetTree(
        child: ScreenUtilInit(
          designSize: const Size(2160, 1440),
          minTextAdapt: true,
          splitScreenMode: true,
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const CareyHomePage(),
          ),
          // builder: (context, __) =>
          //     BlocListener<ConnectionCubit, InternetState>(
          //         listenWhen: (previous, current) => previous != current,
          //         listener: (context, internet) =>
          //             checkInternet(internet, context),
          //         child: )
          // PiPMaterialApp.router(
          //   debugShowCheckedModeBanner: kDebugMode,
          //   localizationsDelegates: context.localizationDelegates,
          //   supportedLocales: context.supportedLocales,
          //   locale: context.locale,
          //   themeMode: ThemeMode.light,
          //   theme: AppTheme.lightTheme,
          //   darkTheme: AppTheme.darkTheme,
          // )),
        ),
      ),
    );
  }

  void checkInternet(InternetState internet, BuildContext context) {
    // if (internet.status == ConnectionStatus.offline) {
    //   getIt<NotificationService>().showMessage(
    //     LocaleKeys.snack_bar_message_please_check_your_internet.tr(),
    //     type: MessageType.error,
    //     actionText: LocaleKeys.snack_bar_message_retry.tr(),
    //     duration: const Duration(seconds: 5),
    //     onAction: () {
    //       final state = context.read<ConnectionCubit>().state;
    //       if (state.status == ConnectionStatus.offline) {
    //         checkInternet(state, context);
    //       }
    //     },
    //   );
    // }
    // if (internet.status == ConnectionStatus.online) {
    //   getIt<NotificationService>().showMessage(
    //     LocaleKeys.snack_bar_message_connection_successful.tr(),
    //     type: MessageType.success,
    //   );
    // }
  }
}

bool _globalErrorHandler(Object error, StackTrace stackTrace) {
  log(error.toString());
  AppLogger.error(
    "AppRoot",
    error.toString(),
    [stackTrace],
  );
  return true;
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  await setupInjections();
  FlutterError.onError = AppLogger.fatalError;
  // Pass all uncaught asynchronous  errors that aren't handled by the Flutter framework to logger
  PlatformDispatcher.instance.onError = _globalErrorHandler;
  runApp(await builder());
}
