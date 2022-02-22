import 'package:e_commers/Bloc/Auth/auth_bloc.dart';
import 'package:e_commers/Bloc/user/user_bloc.dart';
import 'package:e_commers/Layout/Views/Login/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Widget Testing: login_page.dart:", (WidgetTester tester) async {
    await tester.pumpWidget(MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc()..add(CheckLoginEvent())),
          BlocProvider(create: (context) => UserBloc()),
        ],
        child: MaterialApp(
          home: SignUpPage(),
        )));
    var materialApp = find.byType(Scaffold);
    var form = find.byType(Form);
    var listView = find.byType(ListView);
    var sizebox = find.byType(TextButton);

    expect(form, findsOneWidget);
    expect(materialApp, findsOneWidget);
    expect(listView, findsOneWidget);
    expect(sizebox, findsNWidgets(2));
  });
}
