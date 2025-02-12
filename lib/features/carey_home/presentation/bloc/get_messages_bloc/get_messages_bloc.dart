part of 'index.dart';

class GetMessagesBloc extends Bloc<GetMessagesEvent, GetMessagesState> {
  final ChatMessageUseCase chatUserUseCase;

  GetMessagesBloc(this.chatUserUseCase) : super(GetMessagesInitial()) {
    on<GetLatestMessagesEvent>(_onGetLatestMessages);
    on<GetPreviousMessagesEvent>(_onGetPreviousMessages);
    on<ReceivedNewMessage>(_onNewMessage);
  }

  Future<void> _onGetLatestMessages(
      GetLatestMessagesEvent event, Emitter<GetMessagesState> emit) async {
    emit(GetMessagesInProgress());
    final failureOrUserStatus = await chatUserUseCase.getLatestMessages();

    emit(failureOrUserStatus.fold(
      (failure) => _handleFailure(failure),
      (data) => GetMessagesSuccess(data),
    ));
  }

  Future<void> _onGetPreviousMessages(
      GetPreviousMessagesEvent event, Emitter<GetMessagesState> emit) async {
    emit(GetMessagesInProgress());
    final failureOrUserStatus =
        await chatUserUseCase.getPreviousMessages(event.messageId);

    emit(failureOrUserStatus.fold(
      (failure) => _handleFailure(failure),
      (data) => GetMessagesSuccess(data),
    ));
  }

  Future<void> _onNewMessage(
      ReceivedNewMessage event, Emitter<GetMessagesState> emit) async {
    emit(ReceivedNewMessageState(event.message));
  }

  _handleFailure(Failure f) {
    if (f is BadRequestFailure) {
      return GetMessagesFailure(f.message);
    } else {
      return GetMessagesFailure(f.toString());
    }
  }
}
