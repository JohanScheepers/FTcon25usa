# Fluttercon USA 2025 Countdown App

A Flutter application designed to keep you informed about Fluttercon USA 2025.
It features a real-time countdown timer to the event and provides a detailed list
of speakers, their talks, and talk descriptions.

## Table of Contents
* [1. Features](#1-features)
* [2. Target Event Date](#2-target-event-date)
* [3. Getting Started](#3-getting-started)
  * [Prerequisites](#prerequisites)
  * [Installation & Running](#installation--running)
* [4. Project Structure](#4-project-structure)
* [5. Customization](#5-customization)
  * [Changing the Target Date](#changing-the-target-date)

## 1. Features

*   Displays remaining days, hours, minutes, and seconds until Fluttercon USA 2025.
*   Shows a message if the event date has passed.
*   Lists event speakers, their talk titles, and detailed talk descriptions.
*   Simple and clean user interface.
*   Supports light and dark themes.

[Back to Top](#table-of-contents)

## 2. Target Event Date

By default, this app counts down to **June 25, 2025, 09:00:00 local time**.
You can modify this target date easily (see [Customization](#customization)).

[Back to Top](#table-of-contents)

## 3. Getting Started

### Prerequisites

*   Flutter SDK: Make sure you have Flutter installed. For installation instructions, see the [official Flutter documentation](https://flutter.dev/docs/get-started/install).

### Installation & Running

1.  Clone or download this repository (if applicable) or create the project using `flutter create fluttercon_countdown`.
2.  Navigate to the project directory:
    ```bash
    cd fluttercon_countdown
    ```
3.  Get the dependencies:
    ```bash
    flutter pub get
    ```
4.  Run the app:
    ```bash
    flutter run
    ```

[Back to Top](#table-of-contents)

## 4. Project Structure

The project follows a standard Flutter application structure:

```
lib/
├── main.dart                 # App entry point
└── src/                      # Source code
    ├── app.dart              # MaterialApp setup, theming
    ├── models/
    │   └── speaker_model.dart  # Data models for Speaker and Talk
    ├── screens/
    │   └── countdown_screen.dart # Main screen with countdown & speaker list
    ├── utils/
    │   ├── app_constants.dart  # Constants like target date, UI values
    │   └── speakers.dart       # Raw speaker data (Dart List)
    └── widgets/
        └── time_unit_display.dart # Widget to display D/H/M/S units
```

[Back to Top](#table-of-contents)

## 5. Customization

### Changing the Target Date

1.  Open the file `lib/src/utils/app_constants.dart`.
2.  Modify the `kFlutterconTargetDate` constant:
    ```dart
    /// The target date and time for Fluttercon USA 2025.
    /// Change this to your desired event date and time.
    final DateTime kFlutterconTargetDate = DateTime(2025, 6, 25, 9, 0, 0); // Year, Month, Day, Hour, Minute, Second
    ```
3.  Save the file and hot reload/restart your application.

[Back to Top](#table-of-contents)