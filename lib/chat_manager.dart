import 'package:carey/bootstrap.dart';
import 'package:carey/core/config/app_config.dart';
import 'package:carey/core/network/api_client.dart';
import 'package:carey/core/network/connection_cubit.dart';
import 'package:carey/core/network/dio_client.dart';
import 'package:carey/core/utils/app_pref_service.dart';
import 'package:carey/features/carey_home/data/datasource/chat_data_source.dart';
import 'package:carey/features/carey_home/data/repository/chat_connect_repository_imp.dart';
import 'package:carey/features/carey_home/domain/repository/chat_connect_repository.dart';
import 'package:carey/features/carey_home/domain/usecase/chat_message_use_case.dart';
import 'package:carey/features/carey_home/domain/usecase/chat_register_use_case.dart';
import 'package:carey/features/carey_home/presentation/bloc/get_messages_bloc/index.dart';
import 'package:carey/features/carey_home/presentation/bloc/index.dart';
import 'package:carey/features/carey_home/presentation/bloc/send_message_bloc/index.dart';
import 'package:carey/features/upload_rx/data/datasources/upload_rx_remote_data_source.dart';
import 'package:carey/features/upload_rx/data/repositories/upload_rx_repository_impl.dart';
import 'package:carey/features/upload_rx/domain/repositories/upload_rx_repository.dart';
import 'package:carey/features/upload_rx/domain/usecases/upload_rx_usecase.dart';
import 'package:carey/features/upload_rx/presentation/bloc/bloc.dart';
import 'package:carey/flavor/flavors.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatManager {
  static final ChatManager _instance = ChatManager._internal();

  factory ChatManager() => _instance;

  ChatManager._internal();

  bool _isInitialized = false;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  BuildContext? get moduleContext => scaffoldMessengerKey.currentContext;

  Future<void> initialize() async {
    if (_isInitialized) return;

    print("Initializing Chat Module...");

    // Initialize dependencies
    await setupInjections();

    _isInitialized = true;
  }

  attachmentSelected(List<FileAttachmentModel> files) {
    print("media callback received");

    final chatContext = moduleContext;

    if (chatContext != null) {
      chatContext.read<CareyUploadRxBloc>().add(UploadFileSubmit(files));

      // chatContext.read<UploadRxBloc>().add(UploadMediaFileEvent(
      //     fileName: files.first.path, filePath: files.first.name));
    }
  }

  Future<void> setupInjections() async {
    WidgetsFlutterBinding.ensureInitialized();
    EasyLocalization.ensureInitialized();
    await setupDateTime();
    await initializeDateFormatting();
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

  Future<void> setupScreenSettings() async {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  }

  Future<void> setupAppHelpers() async {
    // getIt.registerSingleton<AppInfo>(AppInfo());
  }

  Future<void> setupFlavorConfig() async {
    await AppConfig.loadEnv(F.envName);
  }

  Future<void> setupSharedPrefsInjections() async {
    getIt.registerFactory<AppPreferenceService>(() => AppPreferenceService());
    print("setupSharedPrefsInjections");
  }

  Future<void> setupNetworking() async {
    final dioClient = DioHelper.configureDio();
    getIt.registerSingleton<APIClient>(APIClient(dioClient));
    if (!getIt.isRegistered<Connectivity>()) {
      getIt.registerLazySingleton(() => Connectivity());
    }
    getIt.registerFactory(() => ConnectionCubit(getIt()));
  }

  Future<void> setupFirebase() async {}

  Future<void> setupSystemSingletons() async {}

  Future<void> setupUseCases() async {
    getIt.registerLazySingleton(() => ChatRegisterUserUseCase(getIt()));
    getIt.registerLazySingleton(() => ChatMessageUseCase(getIt()));
    getIt.registerLazySingleton(() => CareyUploadRxUseCase(getIt()));
  }

  Future<void> setupBlocs() async {
    getIt.registerFactory<ChatConnectBloc>(() => ChatConnectBloc(getIt()));
    getIt.registerFactory<SendMessageBloc>(() => SendMessageBloc(getIt()));
    getIt.registerFactory<GetMessagesBloc>(() => GetMessagesBloc(getIt()));
    getIt.registerFactory<CareyUploadRxBloc>(() => CareyUploadRxBloc(getIt()));
  }

  Future<void> setupDataSource() async {
    getIt.registerLazySingleton<ChatConnectRepository>(
      () => ChatConnectRepositoryImp(getIt()),
    );
    getIt.registerLazySingleton<CareyUploadRxRepository>(
      () => UploadRxRepositoryImpl(getIt()),
    );
    getIt.registerLazySingleton<ChatDataSource>(
      () => ChatDataSourceImpl(getIt()),
    );
    getIt.registerLazySingleton<CareyUploadRxDataSource>(
      () => CareyUploadRxDataSourceImpl(getIt()),
    );
  }

  Future<void> setupDateTime() async {
    // timeago.setLocaleMessages('en_short', CustomShortMessages());
    // timeago.setLocaleMessages('en', CustomMessages());
    // timeago.setLocaleMessages('ar_short', CustomShortMessages());
    // timeago.setLocaleMessages('ar', CustomMessages());
    // DateFormat.useNativeDigitsByDefaultFor("ar", false);
  }
}

class FileAttachmentModel {
  String name;
  String path;
  String? link;
  bool isUploaded;

  FileAttachmentModel({
    required this.name,
    required this.path,
    this.link,
    this.isUploaded = true,
  });
}
