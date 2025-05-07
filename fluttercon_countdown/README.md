# Fluttercon USA 2025 Countdown App

A simple Flutter application that displays a countdown timer to Fluttercon USA 2025.

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
*   Simple and clean user interface.
*   Supports light and dark themes.

[Back to Top](#table-of-contents)

## 2. Target Event Date

By default, this app counts down to **March 7, 2025, 09:00:00 local time**.
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
└── src/
    ├── app.dart              # MaterialApp setup, theming
    ├── screens/
    │   └── countdown_screen.dart # Main screen with the countdown logic
    ├── utils/
    │   └── app_constants.dart  # Constants like target date, UI values
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
    final DateTime kFlutterconTargetDate = DateTime(2025, 3, 7, 9, 0, 0); // Year, Month, Day, Hour, Minute, Second
    ```
3.  Save the file and hot reload/restart your application.

[Back to Top](#table-of-contents)