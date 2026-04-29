import 'package:flutter/material.dart';

void main(){
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BackgroundSageAesthetic(),
  ));
}
class BackgroundSageAesthetic extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    const Color sageBase = Color(0xFFA7BEAE);
    const Color sageLight =Color(0xFFE0E7E2);
    const Color textColor =Color(0xFF55A7D6);

    return Scaffold (
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              sageLight,
              sageBase,
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -100,
              child: CircleAvatar(
                radius: 200,
                backgroundColor: Colors.white.withOpacity(0.15),             
              ),
            ),
          
            Positioned(
              bottom: -100,
              left: -80,
              child: CircleAvatar(
                radius: 150,
                backgroundColor:  Colors.white.withOpacity(0.2),
              ),
            ),
            SafeArea(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    const Text(
                      "Reminder Sholat",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                        letterSpacing: 0.5,
                        ),
                      ),
    
                      const SizedBox(height: 5),
                      const Text(
                        "(Mualaf Friendly)",
                        style: TextStyle(
                          fontSize: 18,
                        color: textColor,
                        fontWeight: FontWeight.w500,
                        ),
                      ),
                       Spacer(),
                      Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:  Center(
                          child: Text(
                            "[ Space Jadwal Sholat ]",
                            style: TextStyle(color: textColor, fontStyle: FontStyle.italic),
                          ),
                        ),
                        ),
                        const Spacer(),
                  ],
                ),
              ),
            ),        
          ],
        ),
        ),
      );
  }
}