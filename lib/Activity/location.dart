import 'package:flutter/material.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  State<Location> createState() => _LoactionState();
}

class _LoactionState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:SafeArea(child: Text("Location Activity"))
    );
  }
}
