import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medquest/features/auth/presentation/pages/auth_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';






Color backgroundcolor = Color(0xFF673596);
Color containerBackgroundColor = Color(0xFF3C006D);
Color containerStrockColor = Color.fromARGB(150, 60, 0, 109);
Color textColor = const Color.fromARGB(200, 255, 255, 255);
Color selectionColor = const Color.fromARGB(204, 20, 16, 94);
FontWeight title = FontWeight.w900;
FontWeight containerTitle = FontWeight.w800;
FontWeight containerSubTitle = FontWeight.w600;
final supabase = Supabase.instance.client;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    authOptions: FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
      localStorage: SharedPreferencesLocalStorage(persistSessionKey: "MediquestoSessionKey")
    ),
    
    url: 'https://vkgbusbptbnmmciwkquw.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZrZ2J1c2JwdGJubW1jaXdrcXV3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ0MDU5ODAsImV4cCI6MjA2OTk4MTk4MH0._dzxVENaF_Jtwttlm1WNUV1Jc3s95GvC7_BpCinhmtA',
  );
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedQuest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: 'poppins'),
      home: AuthGate(),
    );
  }
}
