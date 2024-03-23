part of 'create_request_cubit.dart';

enum CreateRequestStatus {
  initial,
  loading,
  submitting,
  error,
  success,
  postImageUploadInProgress,
  postImageUploadSuccess,
  postImageUploadFailure,
  imageUploadInProgress,
  imageUploadSuccess,
  imageUploadFailure,
  unknown,
}

class CreateRequestState extends Equatable {
  const CreateRequestState({
    this.status = CreateRequestStatus.initial,
    this.postViewMedia,
    this.imageUrl,
    this.message,
  });

  /// The status of the current cubit
  final CreateRequestStatus status;

  /// The result of the created or edited post
  final PostViewMedia? postViewMedia;

  /// The url of the uploaded image
  final String? imageUrl;

  /// The info or error message to be displayed as a snackbar
  final String? message;

  CreateRequestState copyWith({
    required CreateRequestStatus status,
    PostViewMedia? postViewMedia,
    String? imageUrl,
    String? message,
  }) {
    return CreateRequestState(
      status: status,
      postViewMedia: postViewMedia ?? this.postViewMedia,
      imageUrl: imageUrl ?? this.imageUrl,
      message: message ?? this.message,
    );
  }

  @override
  List<dynamic> get props => [status, postViewMedia, imageUrl, message];
}
