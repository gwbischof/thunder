import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lemmy_api_client/pictrs.dart';
import 'package:lemmy_api_client/v3.dart';

import 'package:thunder/account/models/account.dart';
import 'package:thunder/core/auth/helpers/fetch_account.dart';
import 'package:thunder/core/models/post_view_media.dart';
import 'package:thunder/post/utils/post.dart';
import 'package:thunder/feed/utils/request.dart';
import 'package:thunder/utils/error_messages.dart';

part 'create_request_state.dart';

class CreateRequestCubit extends Cubit<CreateRequestState> {
  CreateRequestCubit() : super(const CreateRequestState(status: CreateRequestStatus.initial));

  Future<void> clearMessage() async {
    emit(state.copyWith(status: CreateRequestStatus.initial, message: null));
  }

  Future<void> uploadImage(String imageFile, {bool isRequestImage = false}) async {
    Account? account = await fetchActiveProfileAccount();
    if (account == null) return;

    PictrsApi pictrs = PictrsApi(account.instance!);

    isRequestImage
        ? emit(state.copyWith(status: CreateRequestStatus.postImageUploadInProgress))
        : emit(state.copyWith(status: CreateRequestStatus.imageUploadInProgress));

    try {
      PictrsUpload result = await pictrs.upload(filePath: imageFile, auth: account.jwt);
      String url = "https://${account.instance!}/pictrs/image/${result.files[0].file}";

      isRequestImage
          ? emit(state.copyWith(status: CreateRequestStatus.postImageUploadSuccess, imageUrl: url))
          : emit(state.copyWith(status: CreateRequestStatus.imageUploadSuccess, imageUrl: url));
    } catch (e) {
      isRequestImage
          ? emit(state.copyWith(
              status: CreateRequestStatus.postImageUploadFailure, message: e.toString()))
          : emit(state.copyWith(
              status: CreateRequestStatus.imageUploadFailure, message: e.toString()));
    }
  }

  /// Creates or edits a post. When successful, it emits the newly created/updated post in the form of a [RequestViewMedia]
  /// and returns the newly created post id.
  Future<int?> createOrEditRequest(
      {required int communityId,
      required String name,
      String? body,
      String? url,
      bool? nsfw,
      int? postIdBeingEdited,
      int? languageId}) async {
    emit(state.copyWith(status: CreateRequestStatus.submitting));

    try {
      PostView postView = await createRequest(
        communityId: communityId,
        name: name,
        body: body,
        url: url,
        nsfw: nsfw,
        postIdBeingEdited: postIdBeingEdited,
        languageId: languageId,
      );

      // Parse the newly created post
      List<PostViewMedia> postViewMedias = await parsePostViews([postView]);

      emit(state.copyWith(
          status: CreateRequestStatus.success, postViewMedia: postViewMedias.firstOrNull));
      return postViewMedias.firstOrNull?.postView.post.id;
    } catch (e) {
      emit(state.copyWith(status: CreateRequestStatus.error, message: getExceptionErrorMessage(e)));
    }

    return null;
  }
}
