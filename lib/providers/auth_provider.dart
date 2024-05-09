import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "../api/firebase_auth_api.dart";

class UserAuthProvider with ChangeNotifier {
  late FirebaseAuthAPI authService;
  late Stream<User?> _userStream;

  Stream<User?> get userStream => _userStream;
  User? get user => authService.getUser();

  UserAuthProvider() {
    authService = FirebaseAuthAPI();
    fetchUser();
  }

  void fetchUser() {
    _userStream = authService.fetchUser();
  }

  Future<void> signUp(String email, String password) async {
    await authService.signUp(email, password);
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    await authService.signIn(email, password);
    notifyListeners();
  }

  Future<void> signOut() async {
    await authService.signOut();
    notifyListeners();
  }
}
