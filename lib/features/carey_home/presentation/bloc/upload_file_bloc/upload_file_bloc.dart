part of 'index.dart';

class UploadFileBloc extends Bloc<UploadFileEvent, UploadFileState> {
  final ChatMessageUseCase msgUseCase;

  UploadFileBloc(this.msgUseCase) : super(UploadFileInitialState()) {
    on<UploadMediaFileEvent>(_onUploadMedia);
  }

  Future<void> _onUploadMedia(
      UploadMediaFileEvent event, Emitter<UploadFileState> emit) async {
    emit(UploadFileStateInProgress());

    emit(UploadFileStateSuccess(event.filePath));

    // final failureOrUserStatus = await msgUseCase.sendMessage(event.msg);
    //
    // emit(failureOrUserStatus.fold(
    //       (failure) => _handleFailure(failure),
    //       (data) => SendMessageSuccess(),
    // ));
  }

  _handleFailure(Failure f) {
    if (f is BadRequestFailure) {
      return UploadFileStateFailure(f.message);
    } else {
      return UploadFileStateFailure(f.toString());
    }
  }
}
