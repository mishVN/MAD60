// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String userName;
  final String userProfileImage;

  const ProfileHeader({
    super.key,
    required this.userName,
    required this.userProfileImage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 70,
            backgroundColor: Color.fromARGB(255, 20, 32, 166),
            child: CircleAvatar(
              radius: 66,
              backgroundImage: AssetImage(userProfileImage),
              onBackgroundImageError: (_, __) {
                return;
              },
            ),
          ),
          const SizedBox(height: 16),
          Text(
            userName,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
