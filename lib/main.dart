import 'package:app/src/providers/userProvider.dart';
import 'package:app/src/screens/auth_screens/login.dart';
import 'package:app/src/screens/auth_screens/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Diwan',
        theme: ThemeData(
          fontFamily: 'Urbanist',
          useMaterial3: true,
        ).copyWith(
          dialogBackgroundColor: Colors.white,
          dialogTheme: const DialogTheme(elevation: 0),
        ),
        home: LoginScreen(),
        //home: RegisterScreen(),
      ),
    );
  }
}
