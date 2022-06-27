import 'package:flutter/material.dart';
import 'package:flutter_geofence/geofence.dart';
import 'package:solar_calculator/solar_calculator.dart';
import 'package:solar_monitor/database/database.dart';
import 'package:solar_monitor/utils/constants.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      physics: BouncingScrollPhysics(),
      controller: PageController(),
      children: [TemperaturePage(), SunPosPage()],
    ));
  }
}

class TemperaturePage extends StatelessWidget {
  const TemperaturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      image: 'assets/pv_background.png',
      child: Container(
          child: FutureBuilder(
              future: Database.getTemperature(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  //return Text("${snapshot.data}");
                  double temp = snapshot.data as double;

                  return Container(
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(top: 80),
                    child: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.width / 2,
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        temp.toStringAsFixed(2) + "°C",
                        style: kdefaultTextStyle,
                      ),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(255, 246, 184, 28),
                                offset: Offset(0, 0),
                                spreadRadius: 5.0,
                                blurRadius: 20.0,
                                blurStyle: BlurStyle.normal)
                          ],
                          color: Color.fromARGB(255, 246, 184, 28),
                          shape: BoxShape.circle),
                    ),
                  );
                } else
                  return Center(
                    child: CircularProgressIndicator(),
                  );
              })),
    );
  }
}

class SunPosPage extends StatefulWidget {
  @override
  State<SunPosPage> createState() => _SunPosPageState();
}

class _SunPosPageState extends State<SunPosPage> {
  @override
  Widget build(BuildContext context) {
    return Background(
        image: 'assets/solar_background.png',
        child: Stack(
          children: [
            Align(
                alignment: Alignment(0, 1),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.bottomCenter,
                  child: FractionalTranslation(
                    child: Container(
                      height: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(255, 246, 184, 28),
                                offset: Offset(0, -4),
                                spreadRadius: 5.0,
                                blurRadius: 20.0,
                                blurStyle: BlurStyle.normal)
                          ],
                          color: Color.fromARGB(255, 246, 184, 28),
                          shape: BoxShape.circle),
                    ),
                    translation: Offset(0, 0.5),
                  ),
                )),
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 100),
              child: FutureBuilder<Coordinate?>(
                  future: Geofence.getCurrentLocation(),
                  builder: (context, AsyncSnapshot<Coordinate?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      final calc = SolarCalculator(
                          Instant(
                              year: DateTime.now().year,
                              month: DateTime.now().month,
                              day: DateTime.now().day,
                              hour: DateTime.now().hour,
                              minute: DateTime.now().minute,
                              second: DateTime.now().second,
                              timeZoneOffset: 0.0),
                          snapshot.data!.latitude,
                          snapshot.data!.longitude);
                      return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "azimuth : \n ${calc.sunHorizontalPosition.azimuth.toStringAsFixed(2)}",
                              style: kdefaultTextStyle,
                            ),
                            Text(
                              "elevation : \n ${calc.sunHorizontalPosition.elevation.toStringAsFixed(2)}",
                              style: kdefaultTextStyle,
                            )
                          ]);
                    } else
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      );
                  }),
            ),
          ],
        ));
  }
}

class Background extends StatelessWidget {
  final String image;
  final Widget child;
  Background({
    required this.image,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(image),
            alignment: Alignment(0, 1.0),
            fit: BoxFit.cover),
      ),
      child: child,
    );
  }
}
