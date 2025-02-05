part of 'bloc.dart';

class CareyUploadRxBloc extends Bloc<CareyUploadRxEvent, CareyUploadRxState> {
  final CareyUploadRxUseCase uploadRxUseCase;
  CancelToken? cancelToken;

  CareyUploadRxBloc(this.uploadRxUseCase) : super(UploadRxInitial()) {
    on<UploadFileSubmit>(_onSubmitted);
    on<UploadPrescriptionFailureRetry>(_onRetrySubmit);
  }

  void cancelUpload() async {
    cancelToken?.cancel("API WAS CANCELLED");
  }

  Future<void> _onRetrySubmit(
    UploadPrescriptionFailureRetry event,
    Emitter<CareyUploadRxState> emit,
  ) async {
    add(UploadFileSubmit(event.selectedFiles));
  }

  List<UploadRxData> removeNonexistentAndExtras(
      List<UploadRxData> listA, List<FileAttachmentModel?> listB) {
    final setBPaths = {for (var file in listB) file?.path ?? ""};

    final filteredA = listA.where((file) {
      return setBPaths.contains(file.link) == true;
    });

    final resultList = filteredA.take(listB.length).toList(growable: false);
    return resultList;
  }

  Future<void> _onSubmitted(
    UploadFileSubmit event,
    Emitter<CareyUploadRxState> emit,
  ) async {
    cancelToken = CancelToken();

    List<UploadRxData> removedItems = removeNonexistentAndExtras(
      state.uploadedFiles?.files ?? [],
      event.selectedFiles,
    );

    emit(UploadRxLoading(
      selectedFiles: event.selectedFiles,
      uploadedFiles: UploadRxModel(files: removedItems),
      uploadType: event.uploadModuleDocumentType,
      serviceType: event.uploadModuleServiceType,
    ));

    final failureOrUploadSuccess = await uploadRxUseCase.call(
      event.selectedFiles,
      (double progress) {
        emit(
          UploadRxLoading(
            progressLoading: progress,
            selectedFiles: event.selectedFiles,
            uploadedFiles: state.uploadedFiles,
            uploadType: state.uploadType,
            serviceType: state.serviceType,
          ),
        );
      },
      cancelToken,
      state.uploadType,
      state.serviceType,
    );

    emit(failureOrUploadSuccess.fold(
      (failure) => _handleFailure(failure),
      (data) => _handleSuccess(state, data),
    ));
  }

  _handleSuccess(CareyUploadRxState state, UploadRxModel data) {
    var previousUploadedFiles = state.uploadedFiles;
    data.files.addAll(previousUploadedFiles?.files ?? []);
    return UploadRxSuccess(uploadedFiles: data);
  }

  _handleFailure(Failure f) {
    if (f is BadRequestFailure) {
      return UploadRxFailure(
        f.message,
        uploadedFiles: state.uploadedFiles,
      );
    }
    return UploadRxFailure(
      f.toString(),
      uploadedFiles: state.uploadedFiles,
    );
  }
}
