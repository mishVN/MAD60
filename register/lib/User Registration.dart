import 'package:firebase_auth/firebase_auth.dart';

Future<String?> registerUser(String email, String password) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return "User registered: ${userCredential.user!.email}";
  } catch (e) {
    return "Error: $e";
  }
}
