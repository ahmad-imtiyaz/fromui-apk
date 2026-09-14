import 'package:flutter_test/flutter_test.dart';

import 'package:forui_demo/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const Application());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsNothing);

    // Tap the '+' button and trigger a frame.
    await tester.tap(find.text('Increment (0)'));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('Increment (1)'), findsOneWidget);
  });
}
