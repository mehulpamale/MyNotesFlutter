import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/feature/domain/repositories/firebase_repository.dart';
import 'package:notes_app/feature/presentation/cubit/auth/auth_cubit.dart';
import 'package:notes_app/feature/presentation/cubit/notelist/note_cubit.dart';
import 'package:notes_app/feature/presentation/cubit/user/user_cubit.dart';
import 'package:notes_app/feature/presentation/pages/home_page.dart';
import 'package:notes_app/feature/presentation/pages/sign_in_page.dart';
import 'package:notes_app/on_generate_route.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) =>
        di.sl<AuthCubit>()
          ..appStarted()),
        BlocProvider(create: (_) => di.sl<UserCubit>()),
        BlocProvider(create: (_) => di.sl<NoteCubit>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        onGenerateRoute: OnGenerateRoute.route,
        routes: {
          '/': (c) {
            return BlocBuilder<AuthCubit, AuthState>(builder: (c, authState) {
              if (authState is Authenticated) {
                return HomePage(
                  uid: authState.uid,
                );
              } else if (authState is Unauthenticated) {
                return SignInPage();
              } else {
                return CircularProgressIndicator();
              }
            });
          }
        },
      ),
    );
  }
}
