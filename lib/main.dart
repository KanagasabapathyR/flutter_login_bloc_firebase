import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_bloc_firebase/src/auth/bloc/auth_bloc.dart';
import 'package:flutter_login_bloc_firebase/src/auth/data/repositories/auth_repository.dart';
import 'package:flutter_login_bloc_firebase/src/auth/presentation/Dashboard/dashboard.dart';
import 'package:flutter_login_bloc_firebase/src/auth/presentation/SingIn/sing_in.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: 'AIzaSyD7xP3LWSaYUAQLO7KrLaSV2fdBpDvhjdM',
        appId: '1:328791391620:android:cce46c1fbec62c344bb1d1',
        messagingSenderId: '328791391620',
        projectId: '328791391620')
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(
          authRepository: RepositoryProvider.of<AuthRepository>(context),
        ),
        child: MaterialApp(
          home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                // If the snapshot has user data, then they're already signed in. So Navigating to the Dashboard.
                if (snapshot.hasData) {
                  return const Dashboard();
                }
                // Otherwise, they're not signed in. Show the sign in page.
                return SignIn();
              }),
        ),
      ),
    );
  }
}