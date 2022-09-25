import 'package:flutter/material.dart';

class SeachPage extends StatefulWidget {
  const SeachPage({super.key});

  @override
  State<SeachPage> createState() => _SeachPageState();
}

class _SeachPageState extends State<SeachPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SeachPage')),
    );
  }
}
