import 'package:e_commers/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Test the existense of Material App in My App",
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    var materialApp = find.byType(MaterialApp);
    expect(materialApp, findsOneWidget);
  });
}


