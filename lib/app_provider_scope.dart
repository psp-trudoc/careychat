import 'package:carey/bootstrap.dart';
import 'package:carey/features/carey_home/presentation/bloc/get_messages_bloc/index.dart';
import 'package:carey/features/carey_home/presentation/bloc/index.dart';
import 'package:carey/features/carey_home/presentation/bloc/send_message_bloc/index.dart';
import 'package:carey/features/upload_rx/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CareyAppProviderScope extends StatelessWidget {
  final Widget child;

  const CareyAppProviderScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<ChatConnectBloc>(),
        ),
        BlocProvider(
          create: (_) => getIt<SendMessageBloc>(),
        ),
        BlocProvider(
          create: (_) => getIt<GetMessagesBloc>(),
        ),
        BlocProvider(
          create: (_) => getIt<UploadRxBloc>(),
        ),
      ],
      child: child,
    );
  }
}
