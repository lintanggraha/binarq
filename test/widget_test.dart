import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:binarq/main.dart';

void main() {
  testWidgets('main menu renders start button', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: MainMenuScreen(),
        ),
      ),
    );

    expect(find.text('BinarQ'), findsOneWidget);
    expect(find.text('MULAI MAIN'), findsOneWidget);
  });
}
