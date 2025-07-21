import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Cityscreen extends StatefulWidget {
  const Cityscreen({super.key});

  @override
  State<Cityscreen> createState() => _CityscreenState();
}

class _CityscreenState extends State<Cityscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black
        ),
        child: SafeArea(child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: (){

                },
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Color(0xFF0B0D1E),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Icon(FontAwesomeIcons.arrowLeft,
                  color: Colors.grey,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                onChanged: (value){
                  
                },
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                   icon: Icon(FontAwesomeIcons.magnifyingGlass,
                   color: Colors.white,),
                   hintText: 'Enter city name',
                   hintStyle: TextStyle(
                    color: Colors.grey
                   ),
                   border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0)
                      ),
                      borderSide: BorderSide.none,
                      ),
                  ),
              ),
            ),
            GestureDetector(
              onTap: (){

              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(19),
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text('get weather',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'poppins Reguler',
                ),
                ),
              ),
            )
          ],
        )),
      )
    );
  }
}