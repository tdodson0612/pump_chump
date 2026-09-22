// lib/main.dart

import 'package:flutter/material.dart';

import 'screens/app_shell.dart';
import 'services/app_state.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    final state = await AppState.load();
    runApp(PumpChumpApp(state: state));
  } catch (error, stack) {
    // Something went wrong reading saved data or setting up notifications.
    // Show a plain message instead of a blank or crashed screen.
    debugPrint('Pump Chump failed to start: $error\n$stack');
    runApp(const _StartupErrorApp());
  }
}

/// Shown only if the app cannot start normally.
class _StartupErrorApp extends StatelessWidget {
  const _StartupErrorApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48),
                  const SizedBox(height: 16),
                  const Text(
                    "Pump Chump couldn't start",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Please close and reopen the app. '
                    'If this keeps happening, try restarting your phone.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PumpChumpApp extends StatelessWidget {
  const PumpChumpApp({super.key, required this.state});

  final AppState state;

  @override
  Widget build(BuildContext context) {
    return AppScope(
      state: state,
      child: MaterialApp(
        title: 'Pump Chump',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        home: const AppShell(),
      ),
    );
  }
}