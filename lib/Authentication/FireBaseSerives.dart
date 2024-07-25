import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  final auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  // dont't gorget to add firebasea auth and google sign in package
  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        print(googleSignInAuthentication);
        print(googleSignInAccount.displayName);
        print(googleSignInAccount.email);

        addUser(googleSignInAccount.displayName, googleSignInAccount.email);
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        print(authCredential);
        await auth.signInWithCredential(authCredential);
      } else {}
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchUser(email) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    DocumentSnapshot snapshot = await users.doc('some_user_id').get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      print('User data: $data');
    } else {
      print('No such document!');
    }
  }

  Future<void> addUser(name, email) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.add({'name': name, 'email': email});
    print('User added!');
  }
}
