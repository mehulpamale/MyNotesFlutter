import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/app_constants.dart';
import 'package:notes_app/feature/domain/entities/user_entity.dart';
import 'package:notes_app/feature/presentation/cubit/auth/auth_cubit.dart';
import 'package:notes_app/feature/presentation/cubit/user/user_cubit.dart';

import '../../../common.dart';
import '../../../widget_extensions.dart';
import 'home_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: BlocConsumer<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(builder: (c, authState) {
              if (authState is Authenticated) {
                return HomePage(uid: authState.uid);
              } else {
                return _bodyWidget();
              }
            });
          }
          return _bodyWidget();
        },
        listener: (context, state) {
          if (state is UserSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          } else if (state is UserFailure) {
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
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'enter username'),
          ),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'enter email'),
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'enter password'),
          ),
          ElevatedButton(onPressed: _signUp, child: Text('Create new account')),
          IconButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context, PageConst.signInPage, (route) => false),
              icon: Icon(Icons.arrow_back_ios))
        ],
      ),
    );
  }

  void _signUp() {
    print('signup');
    showDialog(
        context: context, builder: (c) => AlertDialog(content: Text('hi')));

    print(_passwordController.text.isNotEmpty);
    print(_usernameController.text.isNotEmpty);
    print(_emailController.text.isNotEmpty);

    if (_passwordController.text.isNotEmpty &&
        _usernameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty) {
      print('inside if');
      BlocProvider.of<UserCubit>(context)
          .submitSignUp(UserEntity(
              email: _emailController.text, password: _passwordController.text))
          .then((value) => print('then: ${value}'))
          .onError((error, stackTrace) => print('err: ${error}'));
    } else {
      BC(context).makeSnackbar('enter valid credentials');
    }
  }
}
