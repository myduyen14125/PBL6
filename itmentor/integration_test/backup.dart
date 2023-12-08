import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:itmentor/main.dart' as app;
import 'package:itmentor/models/custom_appointment.dart';
import 'package:itmentor/screens/home_screens/search_mentors/search_mentor_screen.dart';
import 'package:itmentor/screens/homepage_navigation_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // group('end to end test', () {
  //   testWidgets('verify login username and password and then search for mentor',
  //       (tester) async {
  //     app.main();
  //     await tester.pumpAndSettle();

  //     // Tap the login button and wait for UI to settle
  //     await tester.tap(find.byKey(Key('loginButton')));
  //     await tester.pumpAndSettle();

  //     // Enter text in the username field
  //     await tester.enterText(
  //         find.byType(TextFormField).at(0), 'ngochungle1331@gmail.com');
  //     await tester.pump();

  //     // Enter text in the password field
  //     await tester.enterText(find.byType(TextFormField).at(1), '123456');
  //     await tester.pump();

  //     await tester.testTextInput.receiveAction(TextInputAction.done);
  //     await tester.pump();

  //     // Tap the login button again
  //     await tester.tap(find.byKey(Key('loginButton')));

  //     // Wait for the dialog to be displayed
  //     await tester.pumpAndSettle();

  //     // Check for the presence of the homepage navigation screen
  //     expect(find.byType(HomepageNavigationScreen), findsOneWidget);

  //     // Now, tap the 'searchMentorButton'
  //     // await tester.tap(find.byKey(Key('searchMentorButton')));

  //     // await Future.delayed(Duration(seconds: 2));

  //     // Wait for the UI to settle after tapping the search button
  //     await tester.pumpAndSettle();

  //     // expect(find.byType(SearchMentor), findsOneWidget);

  //     // Find the search field and enter text 'Hưng'
  //     // await tester.enterText(find.byKey(Key('searchField')), 'Hưng');
  //     // await tester.pump();

  //     // Trigger the submit action (hit Enter)
  //     // await tester.testTextInput.receiveAction(TextInputAction.done);
  //     // await tester.pumpAndSettle();

  //     // Now, tap the first mentor in the ListView
  //     // await tester.tap(find.byKey(Key('MentorData')).first);

  //     // Wait for the UI to settle after tapping the first mentor
  //     // await tester.pumpAndSettle();

  //     await tester.tap(find.byKey(Key('HoSoCaNhan')));

  //     await tester.pumpAndSettle();

  //     await tester.tap(find.byKey(Key('AddExperience')));

  //     await tester.pumpAndSettle();

  //     await Future.delayed(Duration(seconds: 2));

  //     await tester.tap(find.byKey(Key('ButtonAddExperience')));

  //     await tester.pumpAndSettle();

  //     await Future.delayed(Duration(seconds: 2));
  //   });
  // });

  // group('end to end test', () {
  //   testWidgets('login and add experience with empty data input',
  //       (tester) async {
  //     app.main();
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.byKey(Key('loginButton')));
  //     await tester.pumpAndSettle();

  //     await tester.enterText(
  //         find.byType(TextFormField).at(0), 'ngochungle1331@gmail.com');
  //     await tester.pump();

  //     await tester.enterText(find.byType(TextFormField).at(1), '123456');
  //     await tester.pump();

  //     await tester.testTextInput.receiveAction(TextInputAction.done);
  //     await tester.pump();

  //     await tester.tap(find.byKey(Key('loginButton')));

  //     await tester.pumpAndSettle();

  //     expect(find.byType(HomepageNavigationScreen), findsOneWidget);

  //     await tester.pumpAndSettle();

  //     await tester.tap(find.byKey(Key('HoSoCaNhan')));

  //     await tester.pumpAndSettle();

  // await tester.drag(
  //     find.byKey(Key('ScrollHoSoCaNhan')), const Offset(0.0, -800.0));

  // Wait for the UI to settle after scrolling
  //    await tester.pumpAndSettle();
  //    await tester.tap(find.byKey(Key('AddExperience')));

  //     await tester.pumpAndSettle();

  // await Future.delayed(Duration(seconds: 2));

  // await tester.enterText(find.byKey(Key('Position')), 'Intern');

  // await tester.testTextInput.receiveAction(TextInputAction.done);
  // await tester.pump();

  //     await tester.tap(find.byKey(Key('ButtonAddExperience')));

  //     await tester.pumpAndSettle();

  //     await Future.delayed(Duration(seconds: 2));
  //   });
  // });

  group('end to end test', () {
    testWidgets('login and add experience with valid data input',
        (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key('loginButton')));
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byType(TextFormField).at(0), 'ngochungle1331@gmail.com');
      await tester.pump();

      await tester.enterText(find.byType(TextFormField).at(1), '123456');
      await tester.pump();

      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      await tester.tap(find.byKey(Key('loginButton')));

      await tester.pumpAndSettle();

      expect(find.byType(HomepageNavigationScreen), findsOneWidget);

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key('HoSoCaNhan')));

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key('AddExperience')));

      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(Key('Position')), 'Intern');

      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      await tester.enterText(find.byKey(Key('Company')), 'FPT');

      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      await tester.enterText(find.byKey(Key('Description')), 'Flutter Intern');

      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      // Show the start date picker
      await tester.tap(find.byKey(Key('StartDatePicker')));
      await tester.pumpAndSettle();

      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key('EndDatePicker')));
      await tester.pumpAndSettle();

      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key('ButtonAddExperience')));

      await tester.pumpAndSettle();

      await Future.delayed(Duration(seconds: 2));
    });
  });

  // group('end to end test', () {
  //   testWidgets('login and add experience with empty data input',
  //       (tester) async {
  //     app.main();
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.byKey(Key('loginButton')));
  //     await tester.pumpAndSettle();

  //     await tester.enterText(
  //         find.byType(TextFormField).at(0), 'ngochungle1331@gmail.com');
  //     await tester.pump();

  //     await tester.enterText(find.byType(TextFormField).at(1), '123456');
  //     await tester.pump();

  //     await tester.testTextInput.receiveAction(TextInputAction.done);
  //     await tester.pump();

  //     await tester.tap(find.byKey(Key('loginButton')));

  //     await tester.pumpAndSettle();

  //     expect(find.byType(HomepageNavigationScreen), findsOneWidget);

  //     await tester.pumpAndSettle();

  //     await tester.tap(find.byKey(Key('HoSoCaNhan')));

  //     await tester.pumpAndSettle();

  //     await tester.tap(find.byKey(Key('AddExperience')));

  //     await tester.pumpAndSettle();

  //     await Future.delayed(Duration(seconds: 2));

  //     await tester.enterText(find.byKey(Key('Position')), 'Intern');

  //     await tester.testTextInput.receiveAction(TextInputAction.done);
  //     await tester.pump();

  //     await tester.tap(find.byKey(Key('ButtonAddExperience')));

  //     await tester.pumpAndSettle();

  //     await Future.delayed(Duration(seconds: 2));
  //   });
  // });
}
