import 'package:flutter/material.dart';

class SampleDisplay extends StatefulWidget {
  const SampleDisplay({super.key});

  @override
  State<SampleDisplay> createState() => _SampleDisplayState();
}

class _SampleDisplayState extends State<SampleDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Display'),
      ),
      body: Center(
        child: Text(
          'This is a sample display screen.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}