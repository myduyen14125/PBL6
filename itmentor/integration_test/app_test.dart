import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:itmentor/main.dart' as app;
import 'package:itmentor/models/custom_appointment.dart';
import 'package:itmentor/screens/home_screens/search_mentors/search_mentor_screen.dart';
import 'package:itmentor/screens/homepage_navigation_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
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

  //     await tester.tap(find.byKey(Key('ButtonAddExperience')));

  //     await tester.pumpAndSettle();

  //     await Future.delayed(Duration(seconds: 2));
  //   });
  // });

  // group('end to end test', () {
  //   testWidgets('login and add experience with empty Position data input',
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

  //     // empty position

  //     await tester.enterText(find.byKey(Key('Company')), 'FPT');
  //     await tester.testTextInput.receiveAction(TextInputAction.done);
  //     await tester.pump();

  //     await tester.enterText(find.byKey(Key('Description')), 'Flutter Intern');
  //     await tester.testTextInput.receiveAction(TextInputAction.done);
  //     await tester.pump();

  //     await tester.tap(find.byKey(Key('StartDatePicker')));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.text('OK'));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.byKey(Key('EndDatePicker')));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.text('OK'));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.byKey(Key('ButtonAddExperience')));
  //     await tester.pumpAndSettle();

  //     await Future.delayed(Duration(seconds: 2));
  //   });
  // });

  // group('end to end test', () {
  //   testWidgets('login and add experience with empty Company data input',
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

  //     await tester.enterText(find.byKey(Key('Position')), 'Intern');
  //     await tester.testTextInput.receiveAction(TextInputAction.done);
  //     await tester.pump();

  //     // empty Company

  //     await tester.enterText(find.byKey(Key('Description')), 'Flutter Intern');
  //     await tester.testTextInput.receiveAction(TextInputAction.done);
  //     await tester.pump();

  //     await tester.tap(find.byKey(Key('StartDatePicker')));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.text('OK'));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.byKey(Key('EndDatePicker')));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.text('OK'));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.byKey(Key('ButtonAddExperience')));
  //     await tester.pumpAndSettle();

  //     await Future.delayed(Duration(seconds: 2));
  //   });
  // });

  // group('end to end test', () {
  //   testWidgets('login and add experience with empty Description data input',
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

  //     await tester.enterText(find.byKey(Key('Position')), 'Intern');
  //     await tester.testTextInput.receiveAction(TextInputAction.done);
  //     await tester.pump();

  //     await tester.enterText(find.byKey(Key('Company')), 'Flutter Intern');
  //     await tester.testTextInput.receiveAction(TextInputAction.done);
  //     await tester.pump();

  //     // empty Description

  //     await tester.tap(find.byKey(Key('StartDatePicker')));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.text('OK'));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.byKey(Key('EndDatePicker')));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.text('OK'));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.byKey(Key('ButtonAddExperience')));
  //     await tester.pumpAndSettle();

  //     await Future.delayed(Duration(seconds: 2));
  //   });
  // });

  // group('end to end test', () {
  //   testWidgets('login and add experience with empty StartDate data input',
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

  //     await tester.enterText(find.byKey(Key('Position')), 'Intern');
  //     await tester.testTextInput.receiveAction(TextInputAction.done);
  //     await tester.pump();

  //     await tester.enterText(find.byKey(Key('Company')), 'Flutter Intern');
  //     await tester.testTextInput.receiveAction(TextInputAction.done);
  //     await tester.pump();

  //     await tester.enterText(find.byKey(Key('Description')), 'Flutter Intern');
  //     await tester.testTextInput.receiveAction(TextInputAction.done);
  //     await tester.pump();

  //     // empty StartDate

  //     await tester.tap(find.byKey(Key('EndDatePicker')));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.text('OK'));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.byKey(Key('ButtonAddExperience')));
  //     await tester.pumpAndSettle();

  //     await Future.delayed(Duration(seconds: 2));
  //   });
  // });

  // group('end to end test', () {
  //   testWidgets('login and add experience with empty EndDate data input',
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

  //     await tester.enterText(find.byKey(Key('Position')), 'Intern');
  //     await tester.testTextInput.receiveAction(TextInputAction.done);
  //     await tester.pump();

  //     await tester.enterText(find.byKey(Key('Company')), 'Flutter Intern');
  //     await tester.testTextInput.receiveAction(TextInputAction.done);
  //     await tester.pump();

  //     await tester.enterText(find.byKey(Key('Description')), 'Flutter Intern');
  //     await tester.testTextInput.receiveAction(TextInputAction.done);
  //     await tester.pump();

  //     await tester.tap(find.byKey(Key('StartDatePicker')));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.text('OK'));
  //     await tester.pumpAndSettle();

  //     // empty StartDate

  //     await tester.tap(find.byKey(Key('ButtonAddExperience')));
  //     await tester.pumpAndSettle();

  //     await Future.delayed(Duration(seconds: 2));
  //   });
  // });

  // group('end to end test', () {
  //   testWidgets('login and add experience with invalid position data input',
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

  //     await tester.enterText(find.byKey(Key('Position')), '😂');
  //     await tester.testTextInput.receiveAction(TextInputAction.done);
  //     await tester.pump();

  //     await tester.enterText(find.byKey(Key('Company')), 'Flutter Intern');
  //     await tester.testTextInput.receiveAction(TextInputAction.done);
  //     await tester.pump();

  //     await tester.enterText(find.byKey(Key('Description')), 'Flutter Intern');
  //     await tester.testTextInput.receiveAction(TextInputAction.done);
  //     await tester.pump();

  //     await tester.tap(find.byKey(Key('StartDatePicker')));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.text('OK'));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.byKey(Key('EndDatePicker')));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.text('OK'));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.byKey(Key('ButtonAddExperience')));
  //     await tester.pumpAndSettle();

  //     await Future.delayed(Duration(seconds: 2));
  //   });
  // });

  // group('end to end test', () {
  //   testWidgets('login and add experience with invalid company data input',
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

  //     await tester.enterText(find.byKey(Key('Position')), 'Intern');
  //     await tester.testTextInput.receiveAction(TextInputAction.done);
  //     await tester.pump();

  //     await tester.enterText(find.byKey(Key('Company')), '😁');
  //     await tester.testTextInput.receiveAction(TextInputAction.done);
  //     await tester.pump();

  //     await tester.enterText(find.byKey(Key('Description')), 'Flutter Intern');
  //     await tester.testTextInput.receiveAction(TextInputAction.done);
  //     await tester.pump();

  //     await tester.tap(find.byKey(Key('StartDatePicker')));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.text('OK'));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.byKey(Key('EndDatePicker')));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.text('OK'));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.byKey(Key('ButtonAddExperience')));
  //     await tester.pumpAndSettle();

  //     await Future.delayed(Duration(seconds: 2));
  //   });
  // });

  // group('end to end test', () {
  //   testWidgets('login and add experience with invalid description data input',
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

  //     await tester.enterText(find.byKey(Key('Position')), 'Intern');
  //     await tester.testTextInput.receiveAction(TextInputAction.done);
  //     await tester.pump();

  //     await tester.enterText(find.byKey(Key('Company')), 'FPT');
  //     await tester.testTextInput.receiveAction(TextInputAction.done);
  //     await tester.pump();

  //     await tester.enterText(find.byKey(Key('Description')), '😒');
  //     await tester.testTextInput.receiveAction(TextInputAction.done);
  //     await tester.pump();

  //     await tester.tap(find.byKey(Key('StartDatePicker')));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.text('OK'));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.byKey(Key('EndDatePicker')));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.text('OK'));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.byKey(Key('ButtonAddExperience')));
  //     await tester.pumpAndSettle();

  //     await Future.delayed(Duration(seconds: 2));
  //   });
  // });

  // group('end to end test', () {
  //   testWidgets('login and add experience with startDate after endDate',
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

  //     await tester.enterText(find.byKey(Key('Position')), 'Intern');
  //     await tester.testTextInput.receiveAction(TextInputAction.done);
  //     await tester.pump();

  //     await tester.enterText(find.byKey(Key('Company')), 'FPT');
  //     await tester.testTextInput.receiveAction(TextInputAction.done);
  //     await tester.pump();

  //     await tester.enterText(find.byKey(Key('Description')), 'Flutter Intern');
  //     await tester.testTextInput.receiveAction(TextInputAction.done);
  //     await tester.pump();

  //     await tester.tap(find.byKey(Key('StartDatePicker')));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.text('OK'));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.byKey(Key('EndDatePicker')));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.text('OK'));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.byKey(Key('ButtonAddExperience')));
  //     await tester.pumpAndSettle();

  //     await Future.delayed(Duration(seconds: 2));
  //   });
  // });

  // group('end to end test', () {
  //   testWidgets('login and add experience with startDate after endDate',
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

  //     await tester.enterText(find.byKey(Key('Position')), 'Intern');
  //     await tester.testTextInput.receiveAction(TextInputAction.done);
  //     await tester.pump();

  //     await tester.enterText(find.byKey(Key('Company')), 'FPT');
  //     await tester.testTextInput.receiveAction(TextInputAction.done);
  //     await tester.pump();

  //     await tester.enterText(find.byKey(Key('Description')), 'Flutter Intern');
  //     await tester.testTextInput.receiveAction(TextInputAction.done);
  //     await tester.pump();

  //     await tester.tap(find.byKey(Key('StartDatePicker')));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.text('OK'));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.byKey(Key('EndDatePicker')));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.text('OK'));
  //     await tester.pumpAndSettle();

  //     await tester.tap(find.byKey(Key('ButtonAddExperience')));
  //     await tester.pumpAndSettle();

  //     await Future.delayed(Duration(seconds: 2));
  //   });
  // });

  group('end to end test', () {
    testWidgets('login and delete experience', (tester) async {
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

      await tester.tap(find.byKey(Key('DeleteExperience')));
      await tester.pumpAndSettle();

      // Assuming 'IconDeleteExperience' is an IconButton, use find.byType instead
      await tester.tap(find.byType(IconButton).first);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key('ConfirmDeleteExperience')));
      await tester.pumpAndSettle();

    });
  });

}
