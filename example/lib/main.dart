import 'package:flutter/material.dart';
import 'package:paralax/paralax.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Paralax Card"),
          centerTitle: (0 == 0),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: ListView(physics: BouncingScrollPhysics(), children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
                  child: ParalaxContainer(
                      aspectRatio: 16 / 16,
                      type: ParalaxType.NETWORK,
                      imageUrl:
                          "https://i.pinimg.com/originals/34/b1/96/34b196575351e79f7c46bcf2c038a38a.png",
                      radius: 16,
                      widgets: Positioned(
                        bottom: 20,
                        left: 20,
                        child: Column(
                          children: [
                            Text("What Waht Waht")
                          ],
                        ),
                      )),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
                  child: ParalaxContainer(
                    aspectRatio: 16 / 16,
                    type: ParalaxType.NETWORK,
                    imageUrl:
                        "https://i.pinimg.com/originals/39/a3/55/39a3553197db772513adede23615a82a.png",
                    radius: 16,

                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
                  child: ParalaxContainer(
                    aspectRatio: 16 / 16,
                    type: ParalaxType.NETWORK,
                    imageUrl:
                        "https://i.pinimg.com/originals/04/6c/11/046c11a15bdbccd68ec8712be43cf965.jpg",
                    radius: 16,

                  ),
                )
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
