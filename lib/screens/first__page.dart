import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'home.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          padding: EdgeInsets.only(top: 150),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 66, 133, 244),
                      borderRadius: BorderRadius.circular(25)),
                  child: Icon(
                    Icons.done_outline,
                    color: Colors.white,
                    size: 35,
                    weight: 2,
                  )),
                  SizedBox(height: 30,),
              Text(
                "Welcome To",
                style: TextStyle(
                    fontSize: 30, color: Colors.black.withOpacity(0.5)),
              ),
                  SizedBox(height: 8,),

              Text(
                textAlign: TextAlign.center,
                "My Todo",
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.black.withOpacity(0.8),
                    fontFamily: 'Kalam',
                    fontWeight: FontWeight.bold),
              ),
                  SizedBox(height: 25,),

              Text(
                textAlign: TextAlign.center,
                'My Todo helps you  stay organized and perform your tasks much faster',
                style: TextStyle(
                    fontSize: 20, color: Colors.black.withOpacity(0.4)),
              ),
              Padding(padding: EdgeInsets.only(top: 50)),
              MaterialButton(
                height: 60,
                minWidth: 200,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ));
                },
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Color.fromARGB(255, 216, 230, 252),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Text(
                  'let\'s go',
                  style: TextStyle(fontSize: 25, color: Colors.blue),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
