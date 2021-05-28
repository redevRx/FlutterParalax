# paralax

Flutter Paralax Card

### Install Package
``` dart

dependencies:
  paralax: ^0.0.8+1
```
### Example Code

``` dart
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Paralax Card"),centerTitle: (0 == 0),),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(child: ListView(
                physics: BouncingScrollPhysics(),
                children: List.generate(
                    15,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0 , horizontal: 16),
                          child: ParalaxContainer(
                            aspectRatio: 16 / 16,
                             type: ParalaxType.ASSETS,
                            imageUrl: "assets/rov/${index + 1}.jpg",
                            radius: 16,
                            Positioned(
                        bottom: 20,
                        left: 20,
                        child: Column(
                          children: [
                            Text("What Waht Waht")
                          ],
                        ),
                      )
                          ),
                        )),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
```

### Paralax Container

``` dart
ParalaxContainer(
aspectRatio: 16 / 16,
 type: ParalaxType.ASSETS,
imageUrl: "assets/rov/${index + 1}.jpg",
 radius: 16,
      ),
```

### Example
<center>
<a href="https://github.com/redevRx/FlutterParalax/tree/dev">
 <img src="https://github.com/redevRx/FlutterParalax/blob/dev/demo.gif?raw=true" width="200"/>
</a>
</center>
