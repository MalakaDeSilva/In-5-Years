import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final FacebookLogin _facebookLogin = new FacebookLogin();

class Auth {
  FirebaseUser _user;

  Future<FirebaseUser> handleSignInEmail(String email, String password) async {
    AuthResult result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    final FirebaseUser user = result.user;

    assert(user != null);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await auth.currentUser();
    assert(user.uid == currentUser.uid);

    print('signInEmail succeeded: $user');

    return user;
  }

  Future<FirebaseUser> handleSignUp(email, password) async {
    AuthResult result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final FirebaseUser user = result.user;

    assert(user != null);
    assert(await user.getIdToken() != null);

    return user;
  }

  Future<bool> loginWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount account = await googleSignIn.signIn();
      if (account == null) return false;
      AuthResult res =
          await auth.signInWithCredential(GoogleAuthProvider.getCredential(
        idToken: (await account.authentication).idToken,
        accessToken: (await account.authentication).accessToken,
      ));
      if (res.user == null) return false;
      _user = res.user;

      return true;
    } catch (e) {
      print(e.message);
      print("Error logging with google");
      return false;
    }
  }

  // FacebookSignIn Firebase
  Future<bool> facebookSignedIn() async {
    final FacebookLoginResult facebookLoginResult =
        await _facebookLogin.logIn(['email', 'public_profile']);
    FacebookAccessToken facebookAccessToken = facebookLoginResult.accessToken;
    AuthCredential authCredential = FacebookAuthProvider.getCredential(
        accessToken: facebookAccessToken.token);
    FirebaseUser fbUser;
    fbUser = (await auth.signInWithCredential(authCredential)).user;
    print("Error logging with google : " + fbUser.uid);
    if (fbUser.uid == null) {
      return false;
    } else {
      _user = fbUser;
      return true;
    }
  }

  FirebaseUser getUser(){
    return _user;
  }
}
