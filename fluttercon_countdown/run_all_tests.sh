
#Make it executable (you only need to do this once): Open your terminal (like Git Bash, WSL, macOS terminal, or Linux terminal), navigate to your project root:
#
#cd d:\FlutterProjects\FTcon25usa\fluttercon_countdown
#chmod +x run_all_tests.sh
#
#Run the script: From your project root in the terminal:
#
#./run_all_tests.sh
#
#
#This script will:
#
#Print some friendly messages.
#Run flutter pub get to make sure your dependencies are current.
#Run flutter test to execute all tests in your test directory.
#Inform you if all tests passed or if some failed.

#!/bin/bash
#
# Script to run all Flutter tests in the Fluttercon USA 2025 Countdown project.
#

# Ensure the script exits immediately if a command exits with a non-zero status.
set -e

echo "🚀 Starting Flutter Test Runner for Fluttercon USA 2025 Countdown 🚀"
echo ""

echo "⚙️ Ensuring all dependencies are up to date..."
flutter pub get
echo "✅ Dependencies updated."
echo ""

echo "🧪 Running all Flutter tests..."
flutter test

TEST_EXIT_CODE=$? # Capture the exit code of the flutter test command

echo ""
if [ $TEST_EXIT_CODE -eq 0 ]; then
  echo "🎉 All tests passed successfully! 🎉"
else
  echo "⚠️ Some tests failed. Please review the output above. ⚠️"
fi

exit $TEST_EXIT_CODE