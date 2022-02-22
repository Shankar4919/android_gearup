import 'package:e_commers/Bloc/Auth/auth_bloc.dart';
import 'package:e_commers/Bloc/user/user_bloc.dart';
import 'package:e_commers/Layout/Views/Login/register_page.dart';
import 'package:e_commers/Layout/widgets/widgets.dart';
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
    var safeArea = find.byType(SafeArea);
    var scaffold = find.byType(Scaffold);

    expect(safeArea, findsOneWidget);
    expect(scaffold, findsOneWidget);
  });
}
