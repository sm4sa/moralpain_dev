import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class CognitoAuthenticationRepository {
  Future<String> fetchUserIdFromAttributes() async {
    try {
      final attributes = await Amplify.Auth.fetchUserAttributes().timeout(
        Duration(seconds: 15),
        onTimeout: () =>
            throw Exception('failed to fetch attributes in reasonable time'),
      );
      final subAttribute = attributes
          .firstWhere((element) => element.userAttributeKey.key == 'sub');
      final userId = subAttribute.value;
      return userId;
    } on NotAuthorizedException catch (e) {
      throw e;
    } catch (e) {
      print('unexpected exception ${e}');
      throw e;
    }
  }

  // Proxy for verifying authorization - should hit /userInfo with an
  // access token.
  Future<bool> isAuthorized() async {
    try {
      final attributes = await Amplify.Auth.fetchUserAttributes()
          .timeout(Duration(seconds: 15), onTimeout: () => List.empty());
      return attributes.isNotEmpty;
    } on NotAuthorizedException {
      return false;
    } catch (e) {
      print('unexpected exception ${e}');
      throw e;
    }
  }

  Future<bool> isAuthenticated() async {
    try {
      // NB (nphair): We need
      final session = await Amplify.Auth.fetchAuthSession(
        options: CognitoSessionOptions(getAWSCredentials: true),
      );
      return session.isSignedIn;
    } on SessionExpiredException {
      return false;
    } on SignedOutException {
      return false;
    } catch (e) {
      print('unexpected exception ${e}');
      throw e;
    }
  }

  Future<bool> signIn() async {
    final result = await Amplify.Auth.signInWithWebUI();
    return result.isSignedIn;
  }

  Future<void> signOut() async {
    try {
      await Amplify.Auth.signOut();
    } catch (e) {
      throw e;
    }
  }
}
