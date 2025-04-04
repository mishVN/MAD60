import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pet_plus_new/const.dart';
import 'package:pet_plus_new/provider/appoinment_provider.dart';
import 'package:pet_plus_new/provider/cart_provider.dart';
import 'package:pet_plus_new/provider/doctor_provider.dart';
import 'package:pet_plus_new/provider/hospital_provider.dart';
import 'package:pet_plus_new/provider/patient_provider.dart';
import 'package:pet_plus_new/provider/user_provider.dart';
import 'package:pet_plus_new/screens/authentication/login.dart';
import 'package:pet_plus_new/screens/homescreen.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  await _setup();
  runApp(const MyApp());
}

Future<void> _setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Stripe.publishableKey = publishableKey;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => AppoinmentProvider()),
        ChangeNotifierProvider(create: (context) => PatientProvider()),
        ChangeNotifierProvider(create: (context) => HospitalProvider()),
        ChangeNotifierProvider(create: (context) => DoctorProvider()),
      ],
      child: MaterialApp(
        title: 'Pet Plus',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromARGB(255, 20, 32, 166),
          ),
          useMaterial3: true,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              return const Homescreen();
            }
            return LoginScreen(); // LoginScreen();
          },
        ),
      ),
    );
  }
}
