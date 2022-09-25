import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Ghome extends StatefulWidget {
  final snap;
  Ghome({Key? key,this.snap}) : super(key: key);

  @override
  State<Ghome> createState() => _GhomeState();
}

class _GhomeState extends State<Ghome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white
          ),
          title: Text(
            "${widget.snap['Group Name']}",
            style:const TextStyle(
              color:Colors.white
            ),
            ),
            actions: [
              IconButton(
                onPressed: (){},
                icon: const FaIcon(FontAwesomeIcons.message),
                ),
            ],
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                
              ],
            )
          ],
        ),
      ),
    );
  }
}