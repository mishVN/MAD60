// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:pet_plus_new/widgets/profile/profile_header.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final Map<String, String> _adminData = {
    'name': 'Kasun Sajana',
    'ownedPets': '2',
    'email': 'kota@grocify.com',
    'phone': '+94 77 123 4567',
    'joinDate': 'March 10, 2023',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Admin Profile',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Color.fromARGB(255, 20, 32, 166),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit profile page
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            children: [
              ProfileHeader(
                userName: 'Kasun Sajana',
                userProfileImage: 'assets/kawya.jpg',
              ),
              const SizedBox(height: 20),
              _buildAdminDetails(),
              const SizedBox(height: 30),
              // Logout button
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 24),
                child: ElevatedButton(
                  onPressed: () {
                    print("Developed by WorkSync");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.red, width: 1.5),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Log Out",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdminDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personal Information',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 20),
        _buildDetailItem(
          icon: Icons.person_outline,
          title: 'Name',
          value: _adminData['name'] ?? 'Not provided',
        ),
        _buildDetailItem(
          icon: Icons.pets_outlined,
          title: 'Owned Pets',
          value: _adminData['ownedPets'] ?? 'Not provided',
        ),
        _buildDetailItem(
          icon: Icons.phone_outlined,
          title: 'Contact Number',
          value: _adminData['phone'] ?? 'Not provided',
        ),
        _buildDetailItem(
          icon: Icons.email_outlined,
          title: 'Email',
          value: _adminData['email'] ?? 'Not provided',
        ),
        _buildDetailItem(
          icon: Icons.calendar_today_outlined,
          title: 'Joined Date',
          value: _adminData['joinDate'] ?? 'Not provided',
        ),
      ],
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 20, 32, 166).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: Color.fromARGB(255, 20, 32, 166),
              size: 22,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
