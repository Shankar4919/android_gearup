import 'package:e_commers/Bloc/Auth/auth_bloc.dart';
import 'package:e_commers/Bloc/user/user_bloc.dart';
import 'package:e_commers/Layout/Views/Login/loading_page.dart';
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
          home: LoadingPage(),
        )));
    var sizedbox = find.byType(SizedBox);
    var scaffold = find.byType(Scaffold);

    expect(sizedbox, findsOneWidget);
    expect(scaffold, findsOneWidget);
  });
}
