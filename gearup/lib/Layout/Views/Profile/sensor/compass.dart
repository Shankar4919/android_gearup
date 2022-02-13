import 'dart:math' as math;
import 'package:e_commers/Layout/themes/colors_gearUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:permission_handler/permission_handler.dart';

//Use geomagnetic rotation sensor as fallback on Android

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _hasPermissions = false;

  @override
  void initState() {
    super.initState();

    _fetchPermissionStatus();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Compass'),
          backgroundColor: Colors.black,
          centerTitle: true,
          leading: IconButton(
            splashRadius: 20,
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Builder(builder: (context) {
          if (_hasPermissions) {
            return Column(
              children: <Widget>[
                Expanded(child: _buildCompass()),
              ],
            );
          } else {
            return _buildPermissionSheet();
          }
        }),
      ),
    );
  }

  Widget _buildCompass() {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(
            'Error reading heading: ${snapshot.error}',
            style: const TextStyle(color: Colors.white),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }

        double? direction = snapshot.data!.heading;
        if (direction == null) {
          return const Center(
            child: Text(
              "Device does not have sensors !",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCompassValue(direction),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
                elevation: 4.0,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Transform.rotate(
                    angle: (direction * (math.pi / 180) * -1),
                    child: Image.asset('assets/compass.jpeg'),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPermissionSheet() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            'Location Permission Required !',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 180,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white)),
              child: const Text(
                'Request Permissions',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Permission.locationWhenInUse.request().then((ignored) {
                  _fetchPermissionStatus();
                }).catchError((err) {
                  print(err);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void _fetchPermissionStatus() {
    Permission.locationWhenInUse.status.then((status) {
      if (mounted) {
        setState(() => _hasPermissions = status == PermissionStatus.granted);
      }
    });
  }

  _buildCompassValue(double direction) {
    int compassValue;
    if (direction.round() > -1) {
      compassValue = direction.round();
    } else {
      compassValue = 360 + (direction.round());
    }
    if (compassValue == 0 || compassValue == 360) {
      return _buildCompassValueBody('North', compassValue);
    } else if (compassValue > 0 && compassValue <= 46) {
      return _buildCompassValueBody('North', compassValue);
    } else if (compassValue > 46 && compassValue < 90) {
      return _buildCompassValueBody('Northeast', compassValue);
    } else if (compassValue == 90) {
      return _buildCompassValueBody('East', compassValue);
    } else if (compassValue > 90 && compassValue <= 136) {
      return _buildCompassValueBody('East', compassValue);
    } else if (compassValue > 136 && compassValue < 180) {
      return _buildCompassValueBody('Southeast', compassValue);
    } else if (compassValue == 180) {
      return _buildCompassValueBody('South', compassValue);
    } else if (compassValue > 180 && compassValue <= 226) {
      return _buildCompassValueBody('South', compassValue);
    } else if (compassValue > 226 && compassValue < 270) {
      return _buildCompassValueBody('Southwest', compassValue);
    } else if (compassValue == 270) {
      return _buildCompassValueBody('West', compassValue);
    } else if (compassValue > 270 && compassValue <= 316) {
      return _buildCompassValueBody('West', compassValue);
    } else if (compassValue > 316 && compassValue < 359) {
      return _buildCompassValueBody('Northwest', compassValue);
    } else {
      return _buildCompassValueBody('North', compassValue);
    }
  }

  Widget _buildCompassValueBody(String value, int direction) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
              color: ColorsGearUp.greenColor,
              fontSize: 17,
              fontWeight: FontWeight.w700),
        ),
        Text(
          direction.toString() + '°',
          style: const TextStyle(
              color: ColorsGearUp.greenColor,
              fontSize: 17,
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 20,
        ),
        const Icon(
          Icons.arrow_downward,
          color: ColorsGearUp.greenColor,
          size: 50,
        )
      ],
    );
  }
}
