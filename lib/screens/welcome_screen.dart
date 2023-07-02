import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {

  static const String routeId = "welcome";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin { // SingleTickerProviderMixin

  late AnimationController controller; // For animation
  late Animation animation; // For curved animation

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1), // Set animation duration to 1 second
      lowerBound: 0, // Set lower and upper bound values for the controller
      upperBound: 1, // Upper bound has to be 1 for curved animation
      vsync: this, // Set vsync to state of current screen (WelcomeScreen)
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate); // Set curved animation to animation controller
    controller.forward(); // Controller value moves from lowerBound (default 0) to upperBound (default 1); calling reverse (set 'from' value) will decrease the value

    // To loop animation
    // controller.addStatusListener((status) {
    //   if ( status == AnimationStatus.completed ) { // Forward pass completed; start reverse pass
    //     controller.reverse(from: 1);
    //   }
    //   else if ( status == AnimationStatus.dismissed ) { // Reverse pass completed; start forward pass
    //     controller.forward();
    //   }
    // });

    animation.addListener(() {
      setState(() {}); // Set state to rebuild widgets whose values depend on the animation's/controller's value
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: "logo",
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: animation.value * 60.0,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  text: ['Flash Chat'],
                  speed: Duration(milliseconds: 500),
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
                color: Colors.lightBlueAccent,
                label: "Log in",
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.routeId);
                }
            ),
            RoundedButton(
                color: Colors.blueAccent,
                label: "Register",
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.routeId);
                }
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose(); // Dispose of the animation controller once the screen is removed
    super.dispose();
  }
}
