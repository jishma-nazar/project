import 'package:flutter/material.dart';

class VoiceCall extends StatefulWidget {
  @override
  _VoiceCallState createState() => _VoiceCallState();
}

class _VoiceCallState extends State<VoiceCall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[300],
        automaticallyImplyLeading: true,
      ),
    );
  }
}
