import 'package:flutter/material.dart';

class McommentsScreen extends StatefulWidget {
  const McommentsScreen({Key? key}) : super(key: key);

  @override
  State<McommentsScreen> createState() => _McommentsScreenState();
}

class _McommentsScreenState extends State<McommentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
backgroundColor: Colors.white,
  title:const Text("Comments"),
  centerTitle: true,
),
      bottomNavigationBar: SafeArea(
          child: Container(
height: kToolbarHeight,
          )
      ),
    );
  }
}