import 'package:flutter/material.dart';
import 'package:social_feed_reaction/social_feed_reaction.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Social feed reaction',
      theme: ThemeData(primaryColor: const Color(0xff3b5998)),
      debugShowCheckedModeBanner: false,
      home: const SocialReactionMainPage(),
    );
  }
}

class SocialReactionMainPage extends StatelessWidget {
  const SocialReactionMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Social Reaction ',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: const SocialReactionCollection(),
    );
  }
}
