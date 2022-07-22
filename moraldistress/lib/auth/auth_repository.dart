import 'dart:math';

import 'package:amplify_flutter/amplify_flutter.dart';

class AuthRepository {
  Future<String> fetchUserIdFromAttributes() async {
    try {
      final attributes = await Amplify.Auth.fetchUserAttributes().timeout(
        Duration(seconds: 5),
        onTimeout: () =>
            throw Exception('failed to fetch attributes in reasonable time'),
      );
      final subAttribute = attributes
          .firstWhere((element) => element.userAttributeKey.key == 'sub');
      final userId = subAttribute.value;
      return userId;
    } catch (e) {
      throw e;
    }
  }

  // Sign in
  Future<String> webSignIn() async {
    try {
      final result = await Amplify.Auth.signInWithWebUI();
      if (result.isSignedIn) {
        // get user id
        return await fetchUserIdFromAttributes();
      } else {
        throw Exception('could not sign in');
      }
    } catch (e) {
      throw e;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await Amplify.Auth.signOut();
    } catch (e) {
      throw e;
    }
  }

  // Auto sign in
  Future<String> attemptAutoSignIn() async {
    try {
      final session = await Amplify.Auth.fetchAuthSession();
      if (session.isSignedIn) {
        var x = await fetchUserIdFromAttributes();
        return x;
      } else {
        throw Exception('Not signed in');
      }
    } catch (e) {
      throw e;
    }
  }
}
