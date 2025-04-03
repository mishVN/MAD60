import 'package:flutter/material.dart';
import 'package:pet_plus_new/model/user_model.dart';
import 'package:pet_plus_new/provider/user_provider.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _aboutController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      final userProvider = context.read<UserProvider>();
      if (userProvider.profileImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please select a profile image',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Color.fromARGB(186, 20, 32, 166),
          ),
        );
        return;
      }

      context.read<UserProvider>().isLoading = true;

      try {
        final newUser = UserModel(
          uid: '',
          username: _usernameController.text,
          email: _emailController.text,
          contactNumber: _aboutController.text,
          profilePictureURL: '',
        );

        await userProvider.registerUser(newUser, _passwordController.text);

        Navigator.of(context).pop();
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: ${error.toString()}')),
        );
      } finally {
        context.read<UserProvider>().isLoading = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: SizedBox(
                height: screenSize.height - 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      spacing: 16,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/pet.png",
                          width: screenSize.width * 0.2,
                        ),
                        const Text(
                          'Registration',
                          style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 20, 32, 166),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Column(
                      spacing: 16,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: SizedBox(
                                child: CircleAvatar(
                                  radius: 84,
                                  backgroundColor: Color.fromARGB(
                                    255,
                                    20,
                                    32,
                                    166,
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: const Color.fromARGB(
                                      205,
                                      255,
                                      255,
                                      255,
                                    ),
                                    radius: 78.0,
                                    backgroundImage:
                                        context
                                                    .watch<UserProvider>()
                                                    .profileImage ==
                                                null
                                            ? const AssetImage('assets/pet.png')
                                            : Image.file(
                                              context
                                                  .watch<UserProvider>()
                                                  .profileImage!,
                                            ).image,
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: GestureDetector(
                                        onTap: () {},
                                        child:
                                            context
                                                        .watch<UserProvider>()
                                                        .profileImage ==
                                                    null
                                                ? IconButton(
                                                  onPressed: () {
                                                    context
                                                        .read<UserProvider>()
                                                        .captureImage();
                                                  },
                                                  icon: const Icon(
                                                    Icons.add_a_photo_rounded,
                                                  ),
                                                  iconSize: 30,
                                                  padding: const EdgeInsets.all(
                                                    10,
                                                  ),
                                                  color: Colors.white,
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        WidgetStateProperty.all<
                                                          Color
                                                        >(
                                                          Color.fromARGB(
                                                            255,
                                                            20,
                                                            32,
                                                            166,
                                                          ),
                                                        ),
                                                  ),
                                                )
                                                : IconButton(
                                                  onPressed: () {
                                                    context
                                                        .read<UserProvider>()
                                                        .clearImage();
                                                  },
                                                  icon: const Icon(
                                                    Icons.cancel_outlined,
                                                  ),
                                                  iconSize: 30,
                                                  padding: const EdgeInsets.all(
                                                    10,
                                                  ),
                                                  color: Colors.white,
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        WidgetStateProperty.all<
                                                          Color
                                                        >(
                                                          Color.fromARGB(
                                                            255,
                                                            20,
                                                            32,
                                                            166,
                                                          ),
                                                        ),
                                                  ),
                                                ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hoverColor: Color.fromARGB(255, 20, 32, 166),
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: Color.fromARGB(100, 0, 0, 0),
                            ),
                            prefixIcon: Icon(Icons.email),
                            prefixIconColor: Color.fromARGB(255, 20, 32, 166),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(186, 20, 32, 166),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 20, 32, 166),
                                width: 2,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            // Add email format validation
                            bool emailValid = RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                            ).hasMatch(value);
                            if (!emailValid) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(
                              color: Color.fromARGB(100, 0, 0, 0),
                            ),
                            prefixIcon: Icon(Icons.person),
                            prefixIconColor: Color.fromARGB(255, 20, 32, 166),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(186, 20, 32, 166),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 20, 32, 166),
                                width: 2,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a username';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _aboutController,
                          decoration: const InputDecoration(
                            labelText: 'Contact Number',
                            labelStyle: TextStyle(
                              color: Color.fromARGB(100, 0, 0, 0),
                            ),
                            prefixIcon: Icon(Icons.phone),
                            prefixIconColor: Color.fromARGB(186, 20, 32, 166),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(186, 20, 32, 166),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 20, 32, 166),
                                width: 2,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your contact number';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                              color: Color.fromARGB(100, 0, 0, 0),
                            ),
                            prefixIcon: const Icon(Icons.lock),
                            prefixIconColor: Color.fromARGB(255, 20, 32, 166),
                            border: const OutlineInputBorder(),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(186, 20, 32, 166),
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 20, 32, 166),
                                width: 2,
                              ),
                            ),
                            suffixIconColor: Color.fromARGB(255, 20, 32, 166),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        ElevatedButton(
                          onPressed:
                              userProvider.isLoading ? null : _handleSubmit,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            fixedSize: Size(screenSize.width, 58),
                            backgroundColor: Color.fromARGB(255, 20, 32, 166),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            disabledBackgroundColor: Color.fromARGB(
                              186,
                              20,
                              32,
                              166,
                            ),
                          ),
                          child:
                              userProvider.isLoading
                                  ? SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                  : const Text(
                                    'Register',
                                    style: TextStyle(fontSize: 16),
                                  ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      height: 2,
                      width: screenSize.width,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 20, 32, 166),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(text: "Already have an account? "),
                            TextSpan(
                              text: "Login",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Text(
                      "By registering you agree to our\nTerms & Privacy Policy",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
