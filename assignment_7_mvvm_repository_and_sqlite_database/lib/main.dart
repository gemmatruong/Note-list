import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'di/service_locator.dart';
import 'providers/note_provider.dart';
import 'ui/note_list_screen.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteProvider()..fetchNotes(),
      child: MaterialApp(
        title: 'Gemma Notes',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF98D8C8),
          ),
          useMaterial3: true,
        ),
        home: const NoteListScreen(),
      ),
    );
  }
}