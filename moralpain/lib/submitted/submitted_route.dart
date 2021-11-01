import 'package:flutter/material.dart';
import 'package:moralpain/assets/constants.dart';
class SubmittedRoute extends StatelessWidget {
  const SubmittedRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF232D4B),
        title: const Text('Moral Distress Survey'),
      ),
      body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          Text(
                  "Thank you, your response has been recorded.",
                  style: TextStyle(fontSize: 16),
                
                ),
          ElevatedButton(
            child: const Text('If you feel you need relief in the moment please click here'),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => const ThermometerRoute()),
              //);
            },
            style: ElevatedButton.styleFrom(primary: const Color(COLORS_UVA_BLUE))),

          ElevatedButton(
            child: const Text('Return to Main Page'),
            onPressed: (){
               Navigator.popUntil(
                 context,
                 ModalRoute.withName(Navigator.defaultRouteName),

               );
            },
            style: ElevatedButton.styleFrom(primary: const Color(COLORS_UVA_BLUE))
          ) ,
          SizedBox(
               height: 10,
               ), 
            ])
      )
      );
      
    
  }
}

