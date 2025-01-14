part of 'index.dart';

class ChatConnectBloc extends Bloc<ChatConnectEvent, ChatConnectState> {
  final ChatRegisterUserUseCase registerUserUseCase;

  ChatConnectBloc(this.registerUserUseCase) : super(ChatConnectInitial()) {
    on<CreateUserEvent>(_onRegisterUser);
    on<GetMetaDataEvent>(_onGetConversationMetaData);
  }

  Future<void> _onRegisterUser(
      CreateUserEvent event, Emitter<ChatConnectState> emit) async {
    emit(ChatConnectInProgress());
    final failureOrUserStatus =
        await registerUserUseCase.register(event.userId, event.name);

    await failureOrUserStatus.fold(
      (failure) async {
        emit(_handleFailure(failure));
      },
      (userData) async {
        // Step 2: Fetch token after user registration succeeds
        final failureOrToken =
            await registerUserUseCase.createConversation(userData.token ?? "");

        // Handle token fetch result
        emit(failureOrToken.fold(
          (failure) => _handleFailure(failure),
          (token) => ChatConnectSuccess(token),
        ));
      },
    );
  }

  Future<void> _onGetConversationMetaData(
      GetMetaDataEvent event, Emitter<ChatConnectState> emit) async {
    emit(ChatConnectSyncMetaDataInProgress());
    final failureOrUserStatus =
        await registerUserUseCase.getConversationMetaData();

    emit(failureOrUserStatus.fold(
      (failure) => _handleFailure(failure),
      (data) => ChatConnectSyncMetaDataSuccess(data),
    ));
  }

  _handleFailure(Failure f) {
    if (f is BadRequestFailure) {
      return ChatConnectFailure(f.message);
    } else {
      return ChatConnectFailure(f.toString());
    }
  }
}
