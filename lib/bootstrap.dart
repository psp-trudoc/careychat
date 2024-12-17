import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:carey/core/loggers/app_locale.dart';
import 'package:carey/core/loggers/app_logger.dart';
import 'package:carey/core/network/connection_cubit.dart';
import 'package:carey/core/theme/app_theme.dart';
import 'package:carey/core/widgets/pip/pip_material_app.dart';
import 'package:carey/core/widgets/refresh_widget_tree.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';

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
  await setupFlavorConfig();
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
  // await AppConfig.loadEnv(F.envName);
}

Future<void> setupSharedPrefsInjections() async {}

Future<void> setupNetworking() async {}

Future<void> setupFirebase() async {}

Future<void> setupSystemSingletons() async {}

Future<void> setupUseCases() async {}

Future<void> setupBlocs() async {
  // getIt.registerFactory<LanguageCubit>(() => LanguageCubit(getIt()));
}

Future<void> setupDataSource() async {
  // getIt.registerLazySingleton<UserDataSource>(
  //       () => UserDataSourceImpl(getIt()),
  // );
}

Future<void> setupDateTime() async {
  // timeago.setLocaleMessages('en_short', CustomShortMessages());
  // timeago.setLocaleMessages('en', CustomMessages());
  // timeago.setLocaleMessages('ar_short', CustomShortMessages());
  // timeago.setLocaleMessages('ar', CustomMessages());
  // DateFormat.useNativeDigitsByDefaultFor("ar", false);
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MainApp> with WidgetsBindingObserver {
  void _startBleReadingsService() async {
    // WidgetsFlutterBinding.ensureInitialized();
    // FlutterForegroundTask.initCommunicationPort();
    // FlutterForegroundTask.addTaskDataCallback(onReceiveTaskData);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   requestPermissions();
    //   initService();
    //   _startService();
    // });
  }

  void onReceiveTaskData(Object data) {
    // final context = getIt<AppRouter>().navigatorKey.currentContext;
    // if (context != null) {
    //   startReading(context);
    //   getIt<BleHelper>().readingStream.listen((event) {
    //     if (event is GlucoseRecordModel) {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => const
    //           VitalsLoggingDetailsPage(
    //               logType: VitalsLoggingTypes.bloodSugar),
    //         ),
    //       );
    //     }
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      key: widget.key,
      supportedLocales: [AppLocale.en.instance, AppLocale.ar.instance],
      fallbackLocale: AppLocale.en.instance,
      useFallbackTranslations: true,
      saveLocale: true,
      path: languagePath,
      child: RefreshWidgetTree(
        child: ScreenUtilInit(
          designSize: const Size(2160, 1440),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, __) =>
              BlocListener<ConnectionCubit, InternetState>(
                  listenWhen: (previous, current) => previous != current,
                  listener: (context, internet) =>
                      checkInternet(internet, context),
                  child: PiPMaterialApp.router(
                    debugShowCheckedModeBanner: kDebugMode,
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    themeMode: ThemeMode.light,
                    theme: AppTheme.lightTheme,
                    darkTheme: AppTheme.darkTheme,

                  )),
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
