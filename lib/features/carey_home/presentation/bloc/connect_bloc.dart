part of 'index.dart';

class ChatConnectBloc
    extends Bloc<ChatConnectEvent, ChatConnectState> {
  final ChatRegisterUserUseCase registerUserUseCase;

  ChatConnectBloc(this.registerUserUseCase)
      : super(ChatConnectInitial()) {
    on<CreateUserEvent>(_onGetLabTestDetails);
  }

  Future<void> _onGetLabTestDetails(
      CreateUserEvent event, Emitter<ChatConnectState> emit) async {
    emit(ChatConnectInProgress());
    // final failureOrUserStatus =
    // await getLabTestDetailsUseCase.call(event.labId, event.packageId);
    // emit(failureOrUserStatus.fold(
    //       (failure) => _handleFailure(failure),
    //       (data) => GetLabTestDetailsSuccess(data),
    // ));
  }

  // _handleFailure(Failure f) {
  //   if (f is BadRequestFailure) {
  //     return GetLabTestDetailsFailure(f.message);
  //   } else {
  //     return GetLabTestDetailsFailure(f.toString());
  //   }
  // }
}
