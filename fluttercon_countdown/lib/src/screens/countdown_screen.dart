import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttercon_countdown/src/utils/app_constants.dart';
import 'package:fluttercon_countdown/src/widgets/time_unit_display.dart';
import 'package:fluttercon_countdown/src/models/speaker_model.dart';
import 'package:fluttercon_countdown/src/utils/speakers.dart'
    as speaker_data; // Import the speakers.dart file

/// A screen that displays a countdown timer to a target event date.
class CountdownScreen extends StatefulWidget {
  /// Creates an instance of [CountdownScreen].
  const CountdownScreen({super.key});

  @override
  State<CountdownScreen> createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> {
  Timer? _timer;
  Duration _timeRemaining = Duration.zero;
  bool _eventPassed = false;
  List<Speaker> _speakers = [];
  bool _isLoadingSpeakers = true;
  String? _speakerLoadError;

  @override
  void initState() {
    super.initState();
    _updateTimeRemaining();
    _loadSpeakers();
    if (!_eventPassed) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _updateTimeRemaining();
      });
    }
  }

  /// Loads speaker data from the JSON asset file.
  void _loadSpeakers() {
    setState(() {
      _isLoadingSpeakers = true;
      _speakerLoadError = null;
    });
    try {
      // Use the speakers data directly from the imported speakers.dart file
      // The 'speakers' variable in speakers.dart is dynamic, but it's a List of Maps.
      final List<dynamic> data = speaker_data.speakers;
      _speakers = data
          .map((item) => Speaker.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      _speakerLoadError = 'Failed to load speaker data: $e';
    }
    if (mounted) setState(() => _isLoadingSpeakers = false);
  }

  /// Calculates the time remaining until [kFlutterconTargetDate] and updates the state.
  void _updateTimeRemaining() {
    final now = DateTime.now();
    if (now.isAfter(kFlutterconTargetDate)) {
      setState(() {
        _eventPassed = true;
        _timeRemaining = Duration.zero;
      });
      _timer?.cancel(); // Stop timer if event has passed
    } else {
      setState(() {
        _timeRemaining = kFlutterconTargetDate.difference(now);
        _eventPassed = false;
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final days = _timeRemaining.inDays;
    final hours = _timeRemaining.inHours.remainder(24);
    final minutes = _timeRemaining.inMinutes.remainder(60);
    final seconds = _timeRemaining.inSeconds.remainder(60);

    return Scaffold(
      appBar: AppBar(
        title: const Text(kAppTitle),
        backgroundColor: theme.colorScheme.primaryContainer,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Reload Speakers',
            onPressed: _loadSpeakers,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: _eventPassed
                ? Text(
                    'Fluttercon USA 2025 has passed!\nSee you next year!',
                    textAlign: TextAlign.center,
                    style: textTheme.headlineMedium?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Countdown to Fluttercon USA 2025',
                        style: textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.secondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: kDefaultPadding * 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TimeUnitDisplay(value: days, label: 'Days'),
                          TimeUnitDisplay(value: hours, label: 'Hours'),
                          TimeUnitDisplay(value: minutes, label: 'Mins'),
                          TimeUnitDisplay(value: seconds, label: 'Secs'),
                        ],
                      ),
                    ],
                  ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
            child: Text('Event Speakers', style: textTheme.titleLarge),
          ),
          Expanded(
            child: _buildSpeakerList(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSpeakerList(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    if (_isLoadingSpeakers) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_speakerLoadError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Text(
            _speakerLoadError!,
            style:
                textTheme.bodyLarge?.copyWith(color: theme.colorScheme.error),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (_speakers.isEmpty) {
      return Center(
        child: Text('No speakers found.', style: textTheme.bodyLarge),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(
          bottom: kDefaultPadding), // Add padding to the bottom
      itemCount: _speakers.length,
      itemBuilder: (context, index) {
        final speaker = _speakers[index];
        return Card(
          elevation: 4.0,
          margin: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  speaker.name,
                  style: textTheme.titleLarge
                      ?.copyWith(color: theme.colorScheme.primary),
                ),
                if (speaker.talks.isNotEmpty)
                  const SizedBox(height: kDefaultPadding / 2),
                ...speaker.talks.map((talk) {
                  return Padding(
                    padding: const EdgeInsets.only(top: kDefaultPadding / 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          talk.title,
                          style: textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: kDefaultPadding / 4),
                        Text(
                          talk.details,
                          style: textTheme.bodyMedium,
                        ),
                        if (speaker.talks.indexOf(talk) <
                            speaker.talks.length - 1)
                          const SizedBox(height: kDefaultPadding),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }
}
