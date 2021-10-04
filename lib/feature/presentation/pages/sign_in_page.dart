import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/app_constants.dart';
import 'package:notes_app/common.dart';
import 'package:notes_app/feature/domain/entities/user_entity.dart';
import 'package:notes_app/feature/presentation/cubit/auth/auth_cubit.dart';
import 'package:notes_app/feature/presentation/cubit/user/user_cubit.dart';

import 'home_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: BlocConsumer<UserCubit, UserState>(
        builder: (context, userState) {
          if (userState is UserSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(builder: (c, authState) {
              if (authState is Authenticated) {
                return HomePage(uid: authState.uid);
              } else
                return _bodyWidget();
            });
          }
          return _bodyWidget();
        },
        listener: (context, userState) {
          if (userState is UserSuccess) {
            print('user su');
            BlocProvider.of<AuthCubit>(context).loggedIn();
          } else if (userState is UserFailure) {
            snackBarError('invalid mail', _globalKey);
          }
        },
      ),
    );
  }

  _bodyWidget() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'enter email'),
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'enter password'),
          ),
          ElevatedButton(onPressed: _signIn, child: Text('Sign In')),
          ElevatedButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context, PageConst.signUpPage, (route) => false),
              child: Text('Sign Up')),
        ],
      ),
    );
  }

  void _signIn() {
    if (_passwordController.text.isNotEmpty &&
        _emailController.text.isNotEmpty) {
      BlocProvider.of<UserCubit>(context).submitSignIn(UserEntity(
          email: _emailController.text, password: _passwordController.text));
    }
  }
}
