import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: WelcomeScreen.routeId, // Another way to start on a specified screen is to use the initialRoute property of MaterialApp; make sure to use named routes in the routes property as well.
      routes: {
        ChatScreen.routeId: (context) => ChatScreen(),
        LoginScreen.routeId: (context) => LoginScreen(),
        RegistrationScreen.routeId: (context) => RegistrationScreen(),
        WelcomeScreen.routeId: (context) => WelcomeScreen(),
      },
    );
  }
}
