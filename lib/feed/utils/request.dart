import 'package:lemmy_api_client/v3.dart';

import 'package:thunder/account/models/account.dart';
import 'package:thunder/core/auth/helpers/fetch_account.dart';
import 'package:thunder/core/singletons/lemmy_client.dart';

/// Logic to create a request
Future<PostView> createRequest(
    {required int communityId,
    required String name,
    String? body,
    String? url,
    bool? nsfw,
    int? postIdBeingEdited,
    int? languageId,
    String? pickupLocation,
    String? pickupTime,
    String? pickupNotes,
    String? pickupContact,
    String? dropoffLocation,
    String? dropoffTime,
    String? dropoffNotes,
    String? dropoffContact}) async {
  Account? account = await fetchActiveProfileAccount();
  LemmyApiV3 lemmy = LemmyClient.instance.lemmyApiV3;

  if (account?.jwt == null) throw Exception('User not logged in');

  PostResponse postResponse;
  if (postIdBeingEdited != null) {
    postResponse = await lemmy.run(EditRequest(
      auth: account!.jwt!,
      name: name,
      body: body,
      url: url?.isEmpty == true ? null : url,
      nsfw: nsfw,
      postId: postIdBeingEdited,
      languageId: languageId ?? 0,
      pickupLocation: pickupLocation,
      pickupTime: pickupTime,
      pickupNotes: pickupNotes,
      pickupContact: pickupContact,
      dropoffLocation: dropoffLocation,
      dropoffTime: dropoffTime,
      dropoffNotes: dropoffNotes,
      dropoffContact: dropoffContact,
    ));
  } else {
    postResponse = await lemmy.run(CreateRequest(
      auth: account!.jwt!,
      communityId: communityId,
      name: name,
      body: body,
      url: url?.isEmpty == true ? null : url,
      nsfw: nsfw,
      languageId: languageId ?? 0,
      pickupLocation: pickupLocation,
      pickupTime: pickupTime,
      pickupNotes: pickupNotes,
      pickupContact: pickupContact,
      dropoffLocation: dropoffLocation,
      dropoffTime: dropoffTime,
      dropoffNotes: dropoffNotes,
      dropoffContact: dropoffContact,
    ));
  }

  return postResponse.postView;
}