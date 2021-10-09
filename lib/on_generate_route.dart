import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/app_constants.dart';
import 'package:notes_app/feature/domain/entities/note_entity.dart';
import 'package:notes_app/feature/domain/use_cases/sign_up_uc.dart';
import 'package:notes_app/feature/presentation/pages/add_new_note_page.dart';
import 'package:notes_app/feature/presentation/pages/sign_in_page.dart';
import 'package:notes_app/feature/presentation/pages/update_note_page.dart';

import 'feature/presentation/pages/sign_up_page.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case PageConst.addNotePage:
        if (args is String) {
          return materialBuilder(AddNewNotePage(uid: args));
        } else {
          return materialBuilder(ErrorPage());
        }
      case PageConst.updateNotePage:
        if (args is NoteEntity) {
          return materialBuilder(UpdateNotePage(noteEntity: args));
        } else {
          return materialBuilder(ErrorPage());
        }
      case PageConst.signInPage:
        return materialBuilder(SignInPage());
      case PageConst.signUpPage:
        return materialBuilder(SignUpPage());
      default:
        return materialBuilder(ErrorPage());
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

MaterialPageRoute materialBuilder(Widget widget) {
  return MaterialPageRoute(builder: (_) {
    return widget;
  });
}
