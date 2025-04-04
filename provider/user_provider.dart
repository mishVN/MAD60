import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_plus_new/model/user_model.dart';
import 'package:pet_plus_new/services/firebase_services.dart';

class UserProvider extends ChangeNotifier {
  UserModel? user;
  File? profileImage;
  bool isLoading = false;
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  final FirebaseService _firebaseService = FirebaseService();

  Future<void> captureImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 25,
      maxWidth: 1024,
      maxHeight: 1024,
    );

    if (photo != null) {
      profileImage = File(photo.path);
      notifyListeners();
    }
  }

  Future<void> clearImage() async {
    profileImage = null;
    notifyListeners();
  }

  Future<void> registerUser(UserModel newUser, String password) async {
    try {
      isLoading = true;
      notifyListeners();
      final authResult = await _auth.createUserWithEmailAndPassword(
        email: newUser.email,
        password: password,
      );

      String userId = authResult.user!.uid;

      String profilePictureURL = await _firebaseService.uploadImage(
        profileImage!,
        "Users",
        userId,
      );

      user = UserModel(
        uid: authResult.user!.uid,
        username: newUser.username,
        email: newUser.email,
        contactNumber: newUser.contactNumber,
        profilePictureURL: profilePictureURL,
      );

      await _firebaseService.uploadDocument("Users", user!, user!.uid);
    } catch (error) {
      print("Error registering user: $error");
      throw error;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();

      final userCredential = await auth.FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final userDoc =
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(userCredential.user!.uid)
              .get();

      if (userDoc.exists) {
        user = UserModel.fromMap(userDoc);
        notifyListeners();
      } else {
        throw Exception("User profile data not found");
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      isLoading = true;
      notifyListeners();

      await _auth.signOut();

      user = null;
      profileImage = null;

      print("User logged out successfully");
    } catch (error) {
      print("Error logging out: $error");
      throw error;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getUserData() async {
    try {
      isLoading = true;
      notifyListeners();

      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception("No user is logged in");
      }

      final userDoc = await _firebaseService.getDocumentDetails(
        "Users",
        currentUser.uid,
      );

      if (userDoc.exists) {
        user = UserModel.fromMap(userDoc);
      } else {
        throw Exception("User profile data not found");
      }
    } catch (error) {
      print("Error fetching user data: $error");
      throw error;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
