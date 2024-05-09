import "package:firebase_auth/firebase_auth.dart";

class FirebaseAuthAPI {
  late FirebaseAuth auth;
  FirebaseAuthAPI() {
    auth = FirebaseAuth.instance;
  }

  Stream<User?> fetchUser() {
    return auth.authStateChanges();
  }

  User? getUser() {
    return auth.currentUser;
  }

  Future<void> signUp(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseException catch (e) {
      print("Firebase error: ${e.code} : ${e.message}");
    } catch (e) {
      print("Error $e");
    }
    return;
  }

  Future<String?> signIn(String email, String password) async {
    try {
      UserCredential credential =
          await auth.signInWithEmailAndPassword(email: email, password: password);
      print(credential);
      return "Success";
    } on FirebaseException catch (e) {
      return ("Firebase error: ${e.code} : ${e.message}");
    } catch (e) {
      return ("Error $e");
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
