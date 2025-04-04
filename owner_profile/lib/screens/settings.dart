import 'package:flutter/material.dart';
import 'package:pet_plus_new/main.dart';
import 'package:pet_plus_new/provider/user_provider.dart';
import 'package:pet_plus_new/screens/pet%20info/new_pet.dart';
import 'package:pet_plus_new/widgets/profile/edit_profile_dialog.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Default values - no loading from SharedPreferences
  bool _notificationsEnabled = true;
  bool _emailNotificationsEnabled = true;
  String _selectedLanguage = 'English';
  String _selectedCurrency = 'LKR';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'About',
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'PetPlus',
                applicationVersion: '1.0.0',
                applicationIcon: Image.asset(
                  'assets/pet.png',
                  width: 50,
                  height: 50,
                ),
                children: [
                  const Text(
                    'PetPlus is your all-in-one pet care solution in Sri Lanka.',
                  ),
                  const SizedBox(height: 10),
                  const Text('© 2025 PetPlus Team'),
                ],
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          // Profile card at the top
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    ClipOval(
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/pet.png',
                          image:
                              context
                                  .read<UserProvider>()
                                  .user!
                                  .profilePictureURL,
                          fit: BoxFit.cover,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error);
                          },
                          placeholderFit: BoxFit.cover,
                          fadeInDuration: const Duration(milliseconds: 500),
                          fadeInCurve: Curves.easeIn,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.read<UserProvider>().user!.username,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            context.read<UserProvider>().user!.email,
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          OutlinedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder:
                                    (context) => EditProfileDialog(
                                      user: null,
                                      onUpdate:
                                          (
                                            String username,
                                            String email,
                                            String phone,
                                            String about,
                                          ) {},
                                    ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text('Edit Profile'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          _buildSectionHeader('Account'),
          _buildAccountSettings(),

          _buildSectionHeader('Appearance'),
          _buildAppearanceSettings(),

          _buildSectionHeader('Location & Currency'),
          _buildLocationSettings(),

          _buildSectionHeader('Privacy & Security'),
          _buildPrivacySettings(),

          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Settings saved')));
              },
              icon: const Icon(Icons.save, color: Colors.white),
              label: const Text('Save Settings'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                backgroundColor: Color.fromARGB(255, 20, 32, 166),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: OutlinedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: const Text('Log Out'),
                        content: const Text(
                          'Are you sure you want to log out?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              context.read<UserProvider>().logout();
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const MyApp(),
                                ),
                                (route) => false,
                              );
                            },
                            child: const Text(
                              'Log Out',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                );
              },
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text('Log Out'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 10),
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _buildAccountSettings() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.pets),
            title: const Text('Manage Pets'),
            subtitle: const Text('Add, edit or remove your pet profiles'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PetListScreen()),
              );
            },
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }

  Widget _buildAppearanceSettings() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.text_fields),
            title: const Text('Text Size'),
            subtitle: const Text('Adjust text size for better readability'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Show text size adjustment dialog
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text('Text Size'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Sample Text',
                            style: TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Sample Text',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Sample Text',
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 16),
                          Slider(
                            value: 1.0,
                            min: 0.8,
                            max: 1.2,
                            divisions: 4,
                            label: 'Normal',
                            onChanged: (value) {
                              // Would adjust text scale factor
                            },
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Apply'),
                        ),
                      ],
                    ),
              );
            },
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('App Theme'),
            subtitle: const Text('Change the app\'s primary color'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
            onTap: () {
              // Show theme color picker
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSettings() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            subtitle: Text(_selectedLanguage),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              _showLanguageSelector();
            },
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.currency_exchange),
            title: const Text('Currency'),
            subtitle: Text(_selectedCurrency),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              _showCurrencySelector();
            },
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Default Location'),
            subtitle: const Text('Colombo, Sri Lanka'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Open location selector
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacySettings() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Privacy Policy'),
            subtitle: const Text('Read our privacy policy'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Show privacy policy
            },
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Terms of Service'),
            subtitle: const Text('Read our terms of service'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Show terms of service
            },
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Help & Support'),
            subtitle: const Text('Get help or contact support'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigate to help & support page
            },
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.delete_outline, color: Colors.red),
            title: const Text(
              'Delete Account',
              style: TextStyle(color: Colors.red),
            ),
            subtitle: const Text(
              'Permanently delete your account and data',
              style: TextStyle(color: Colors.grey),
            ),
            onTap: () {
              _showDeleteAccountDialog();
            },
          ),
        ],
      ),
    );
  }

  void _showLanguageSelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Language'),
              subtitle: const Text('Select your preferred language'),
            ),
            const Divider(),
            ListTile(
              title: const Text('English'),
              trailing:
                  _selectedLanguage == 'English'
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
              onTap: () {
                setState(() {
                  _selectedLanguage = 'English';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Sinhala'),
              trailing:
                  _selectedLanguage == 'Sinhala'
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
              onTap: () {
                setState(() {
                  _selectedLanguage = 'Sinhala';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Tamil'),
              trailing:
                  _selectedLanguage == 'Tamil'
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
              onTap: () {
                setState(() {
                  _selectedLanguage = 'Tamil';
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showCurrencySelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Currency'),
              subtitle: const Text('Select your preferred currency'),
            ),
            const Divider(),
            ListTile(
              title: const Text('Sri Lankan Rupee (LKR)'),
              trailing:
                  _selectedCurrency == 'LKR'
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
              onTap: () {
                setState(() {
                  _selectedCurrency = 'LKR';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('US Dollar (USD)'),
              trailing:
                  _selectedCurrency == 'USD'
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
              onTap: () {
                setState(() {
                  _selectedCurrency = 'USD';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Euro (EUR)'),
              trailing:
                  _selectedCurrency == 'EUR'
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
              onTap: () {
                setState(() {
                  _selectedCurrency = 'EUR';
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Account'),
            icon: const Icon(Icons.warning, color: Colors.red, size: 36),
            content: const Text(
              'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently lost.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Account deletion request submitted. You will receive an email confirmation.',
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }
}
