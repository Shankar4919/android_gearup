import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

class CompassDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Flutter Compass Demo',
      theme: ThemeData(brightness: Brightness.dark),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
          appBar: AppBar(title: Text('Flutter Compass Demo')),
          backgroundColor: Colors.black,
          body: Compass()));
}

class Compass extends StatefulWidget {
  Compass({Key? key}) : super(key: key);

  @override
  _CompassState createState() => _CompassState();
}

class _CompassState extends State<Compass> {
  double _heading = 0;

  String get _readout => _heading.toStringAsFixed(0) + '°';

  @override
  void initState() {
    super.initState();
    FlutterCompass.events!.listen((event) {
      _onData(double.infinity);
    });
  }

  void _onData(double x) => setState(() {
        _heading = x;
      });

  final TextStyle _style = TextStyle(
    color: Colors.red.withOpacity(0.9),
    fontSize: 32,
    fontWeight: FontWeight.w200,
  );

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        foregroundPainter: CompassPainter(angle: _heading),
        child: Center(child: Text(_readout, style: _style)));
  }
}

class CompassPainter extends CustomPainter {
  CompassPainter({required this.angle}) : super();

  final double angle;
  double get rotation => -2 * pi * (angle / 360);

  Paint get _brush => new Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    Paint circle = _brush..color = Colors.indigo.withOpacity(0.6);

    Paint needle = _brush..color = Colors.red.shade400;

    double centerX = size.width / 2;
    double centerY = size.height / 2;

    double radius = min(size.width / 2.2, size.height / 2.2);
    Offset center = Offset(centerX, centerY);
    Offset? start = Offset.lerp(Offset(center.dx, radius), center, .4);
    Offset? end = Offset.lerp(Offset(center.dx, radius), center, 0.1);

    Offset north = Offset(centerX - 18, (centerY - radius));
    Offset south = Offset(centerX - 18, (centerY + radius) - 55);
    Offset west = Offset(25, centerY - 25);
    Offset east = Offset(size.width - 55, centerY - 25);

    canvas.drawLine(start!, end!, needle);
    canvas.drawCircle(center, radius, circle);
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);

    canvas.translate(-center.dx, -center.dy);
    paintDirectionText(canvas, "N", north);
    paintDirectionText(canvas, "E", east);
    paintDirectionText(canvas, "S", south);
    paintDirectionText(canvas, "W", west);
  }

  void paintDirectionText(Canvas canvas, String label, Offset offset) {
    TextSpan span = new TextSpan(
        style: new TextStyle(color: Colors.white, fontSize: 48), text: label);
    TextPainter textPainter = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    textPainter.layout();
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
