import 'package:connect_four_game/components/text.dart';
import 'package:connect_four_game/assets/colors.dart';
import 'package:connect_four_game/screens/multiplayer_game_screen.dart';
import 'package:connect_four_game/screens/ai_game_screen.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10.0,
        backgroundColor: MainColor.primaryColor,
      ),
      backgroundColor: MainColor.primaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              //const SizedBox(height: 48),
              MainText(
                text: 'Connect Four',
                fontSize: 56,
                color: MainColor.accentColor,
              ),
              const SizedBox(
                  height: 8), // control spacing between text and image
              Padding(
                padding: EdgeInsets.all(24.0),
                child: Image.asset(
                  'lib/assets/images/logo.jpeg',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 8), // spacing between image and buttons
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MainColor.accentColor,
                  shadowColor: Colors.transparent,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MultiplayerGameScreen()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: MainText(
                    text: 'Multi Player',
                    fontSize: 30,
                    color: MainColor.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MainColor.accentColor,
                  shadowColor: Colors.transparent,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AIGameScreen()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: MainText(
                    text: 'Play With AI',
                    fontSize: 30,
                    color: MainColor.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 32), // optional bottom spacing
            ],
          ),
        ),
      ),
    );
  }
}
