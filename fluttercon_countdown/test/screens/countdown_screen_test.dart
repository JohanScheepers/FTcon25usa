import 'dart:async';

import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttercon_countdown/src/models/speaker_model.dart';
import 'package:fluttercon_countdown/src/screens/countdown_screen.dart';
import 'package:fluttercon_countdown/src/utils/app_constants.dart';
import 'package:fluttercon_countdown/src/utils/speakers.dart'
    as speaker_data_source;

// A helper to access private members for testing purposes
// ignore_for_file: invalid_use_of_protected_member

void main() {
  group('_CountdownScreenState Tests', () {
    late dynamic state; // Changed type to dynamic

    // Use a fixed target date for consistent testing
    final testTargetDate = DateTime(2025, 6, 25, 9, 0, 0);

    setUp(() {
      // It's important to reset the state for each test
      // CountdownScreen is a StatefulWidget, so we create its state.
      // This is a common way to test State classes directly.
      state = CountdownScreen().createState();
    });

    tearDown(() {
      state.dispose(); // Ensure timers are cancelled
    });

    group('_loadSpeakers', () {
      test('successfully loads speakers when data is valid', () {
        // Arrange: Use the actual speaker data
        final originalSpeakerData = speaker_data_source.speakers;
        speaker_data_source.speakers = [
          {
            "name": "Test Speaker 1",
            "talks": [
              {"title": "Test Talk 1", "details": "Details 1"}
            ]
          },
          {"name": "Test Speaker 2", "talks": []}
        ];

        // Act
        state._loadSpeakers();

        // Assert
        expect(state._isLoadingSpeakers, isFalse);
        expect(state._speakerLoadError, isNull);
        expect(state._speakers.length, 2);
        expect(state._speakers[0].name, "Test Speaker 1");
        expect(state._speakers[0].talks.length, 1);
        expect(state._speakers[0].talks[0].title, "Test Talk 1");
        expect(state._speakers[1].name, "Test Speaker 2");
        expect(state._speakers[1].talks.isEmpty, isTrue);

        // Restore original data if necessary for other tests, though setUp re-creates state
        speaker_data_source.speakers = originalSpeakerData;
      });

      test('handles empty speaker data source', () {
        // Arrange
        final originalSpeakerData = speaker_data_source.speakers;
        speaker_data_source.speakers = []; // Simulate empty data

        // Act
        state._loadSpeakers();

        // Assert
        expect(state._isLoadingSpeakers, isFalse);
        expect(state._speakerLoadError, isNull);
        expect(state._speakers.isEmpty, isTrue);

        speaker_data_source.speakers = originalSpeakerData;
      });

      test('handles malformed speaker data (casting error)', () {
        // Arrange
        final originalSpeakerData = speaker_data_source.speakers;
        speaker_data_source.speakers = [
          "not a map" // This will cause a casting error
        ];

        // Act
        state._loadSpeakers();

        // Assert
        expect(state._isLoadingSpeakers, isFalse);
        expect(state._speakerLoadError, isNotNull);
        expect(
            state._speakerLoadError,
            contains(
                'type \'String\' is not a subtype of type \'Map<String, dynamic>\''));
        expect(state._speakers.isEmpty, isTrue);

        speaker_data_source.speakers = originalSpeakerData;
      });
    });

    group('_updateTimeRemaining (with kFlutterconTargetDate as testTargetDate)',
        () {
      // Note: kFlutterconTargetDate is final. For robust testing of _updateTimeRemaining
      // against different target dates, kFlutterconTargetDate would ideally be injectable
      // or the logic using it refactored. Here, we test against the fixed testTargetDate.

      test('when current time is before target date, _eventPassed is false',
          () {
        final futureTime = testTargetDate.subtract(const Duration(days: 1));
        withClock(Clock.fixed(futureTime), () {
          state._updateTimeRemaining();
          expect(state._eventPassed, isFalse);
          expect(state._timeRemaining.isNegative, isFalse);
          expect(state._timeRemaining > Duration.zero, isTrue);
        });
      });

      test('when current time is after target date, _eventPassed is true', () {
        final pastTime = testTargetDate.add(const Duration(days: 1));
        withClock(Clock.fixed(pastTime), () {
          state._updateTimeRemaining();
          expect(state._eventPassed, isTrue);
          expect(state._timeRemaining, Duration.zero);
        });
      });

      test(
          'when current time is exactly target date, _eventPassed is true (or just after)',
          () {
        // DateTime.now().isAfter(target) will be true if now == target
        withClock(Clock.fixed(testTargetDate), () {
          state._updateTimeRemaining();
          expect(state._eventPassed, isTrue);
          expect(state._timeRemaining, Duration.zero);
        });
      });
    });

    group('initState and dispose', () {
      test('initState sets up timer if event is in the future', () {
        final futureTime =
            kFlutterconTargetDate.subtract(const Duration(hours: 1));
        withClock(Clock.fixed(futureTime), () {
          state
              .initState(); // Manually call initState for testing its direct effects
          expect(state._timer, isNotNull);
          expect(state._timer!.isActive, isTrue);
          expect(state._eventPassed, isFalse);
        });
      });

      test('initState does not start timer if event has passed', () {
        final pastTime = kFlutterconTargetDate.add(const Duration(hours: 1));
        withClock(Clock.fixed(pastTime), () {
          state.initState();
          // Timer might be null or inactive depending on exact logic path
          // The key is that _eventPassed is true, which prevents timer creation in the if block
          expect(state._eventPassed, isTrue);
          expect(state._timer?.isActive ?? false, isFalse);
        });
      });

      test('dispose cancels an active timer', () {
        // Arrange: Start a timer
        final futureTime =
            kFlutterconTargetDate.subtract(const Duration(hours: 1));
        Timer? activeTimer;
        withClock(Clock.fixed(futureTime), () {
          state.initState();
          activeTimer = state._timer; // Get a reference to the timer
        });
        expect(activeTimer, isNotNull);
        expect(activeTimer!.isActive, isTrue);

        // Act
        state.dispose();

        // Assert
        expect(activeTimer!.isActive, isFalse);
      });
    });
  });
}
