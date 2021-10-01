import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Face Mood',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double value = 0.0;
  int r = 255;
  int g = 0;

  @override
  Widget build(BuildContext context) {
    Color color = Color.fromRGBO(r, g, 0, 1.0);

    return Scaffold(
      appBar: AppBar(
        title: Text("Express My Mood"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                border: Border.all(width: 8.0),
                color: color,
                borderRadius: BorderRadius.circular(16.0),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(backgroundColor: Colors.black, radius: 8.0),
                      CircleAvatar(backgroundColor: Colors.black, radius: 8.0),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    child: CustomPaint(
                      size: Size(80, 40),
                      painter: CurvePainter(value),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 32.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text("Bad\n:(", textAlign: TextAlign.center),
                  Expanded(
                    child: Slider(
                      value: value,
                      min: 0,
                      max: 255,
                      onChanged: (v) {
                        value = v;
                        r = 255 - value.floor();
                        g = 0 + value.floor();
                        setState(() {});
                      },
                    ),
                  ),
                  Text("Good!\n:)", textAlign: TextAlign.center),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  double height;

  CurvePainter(this.height);
  // THIS WHOLE CODE IS JUST TO ANIMATE THE SMILE CURVE :D

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    Path path = Path();
    path.moveTo(0, size.height / 2);
    path.quadraticBezierTo(
        size.width / 2, _normalizeHeight(size), size.width, size.height / 2);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  _normalizeHeight(Size size) {
    double x1 = 0;
    double x2 = 255;
    double y1 = -1 * size.height;
    double y2 = size.height;
    /*
    // (x-x1)/(x2-x1) = (y-y1)/(y2-y1)
    * x = slider result (0-255) so find & return y
    */
    var result = (height - x1) / (x2 - x1) * (y2 - y1) + y1;
    return result + 20;
    // +20 is adjustment cz the result isn't expected even the calc is right
  }
}
