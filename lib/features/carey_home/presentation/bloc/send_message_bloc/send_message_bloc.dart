part of 'index.dart';

class SendMessageBloc extends Bloc<SendMessageEvent, SendMessageState> {
  final ChatMessageUseCase msgUseCase;

  SendMessageBloc(this.msgUseCase) : super(SendMessageInitial()) {
    on<SendTextMessage>(_onSendMessage);
  }

  Future<void> _onSendMessage(
      SendTextMessage event, Emitter<SendMessageState> emit) async {

    emit(SendMessageInProgress());
    final failureOrUserStatus = await msgUseCase.sendMessage(event.msg);

    emit(failureOrUserStatus.fold(
      (failure) => _handleFailure(failure),
      (data) => SendMessageSuccess(),
    ));
  }

  _handleFailure(Failure f) {
    if (f is BadRequestFailure) {
      return SendMessageFailure(f.message);
    } else {
      return SendMessageFailure(f.toString());
    }
  }
}
