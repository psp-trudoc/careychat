import 'package:carey/bootstrap.dart';
import 'package:carey/features/carey_home/presentation/bloc/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppProviderScope extends StatelessWidget {
  final Widget child;

  const AppProviderScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<ChatConnectBloc>(),
        ),
      ],
      child: child,
    );
  }
}
