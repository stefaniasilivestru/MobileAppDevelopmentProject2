import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:project2_flutter/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/weather.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherFactory _wf = WeatherFactory(OPEN_WEATHER_API_KEY);
  Weather? _weather; // store information
  String routeName = '';

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        routeName = prefs.getString('routeName') ?? '';
      });
      Logger().d('Loaded routeName: $routeName');

      _wf.currentWeatherByCityName(routeName).then((weather) {
        setState(() {
          _weather = weather;
        });
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1c2143),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 24.0,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text('Weather'),
      ),
      body: Card(
        color: const Color(0xfff6f0f0),
        elevation: 10.0,
        margin: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildUI(),
        ),
      ),
    );
  }

  Widget _buildUI() {
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _locationHeader(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.02,
          ),
          _dateTimeInfo(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.05,
          ),
          _weatherIcon(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.02,
          ),
          _currentTemperature(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.06,
          ),
          _extraInfo(),
        ],

      ),
    );
  }

  Widget _locationHeader() {
    return Text(
      _weather?.areaName ?? 'Unknown location',
      style: const TextStyle(
        fontSize: 34.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1c2143),
      )
    );
  }

  Widget _dateTimeInfo() {
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(
          'Last updated: ${DateFormat('h:mm a').format(now)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: Color(0xFF1c2143),
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat('EEEE').format(now),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1c2143),
              ),
            ),
            Text(
             "  |  ${DateFormat('d/M/y').format(now)}",
              style: const TextStyle(
                color: Color(0xFF1c2143),
              ),
            ),
          ],

        )
      ]
    );
  }

  Widget _weatherIcon() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.2,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"),
            )
          ),
        ),
        Text(
          _weather?.weatherDescription ?? '',
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1c2143),
          ),
        )
      ],
    );
  }

  Widget _currentTemperature() {
    return Text(
      '${_weather?.temperature?.celsius?.toStringAsFixed(0) ?? 'Unknown'}°C',
      style: const TextStyle(
        fontSize: 48.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1c2143),
      ),

    );

  }

  Widget _extraInfo() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            const Text(
              'Feels like',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Color(0xFF1c2143),
              ),
            ),
            Text(
              '${_weather?.tempFeelsLike?.celsius?.toStringAsFixed(0) ?? 'Unknown'}°C',
              style: const TextStyle(
                fontSize: 16.0,
                color: Color(0xFF1c2143),
              ),
            ),
          ],
        ),
        const SizedBox(width: 16.0),
        Column(
          children: [
            const Text(
              'Max',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Color(0xFF1c2143),
              ),
            ),
            Text(
              '${_weather?.tempMax?.celsius?.toStringAsFixed(0) ?? 'Unknown'}°C',
              style: const TextStyle(
                fontSize: 16.0,
                color: Color(0xFF1c2143),
              ),
            ),
          ],
        ),
        const SizedBox(width: 16.0),
        Column(
          children: [
            const Text(
              'Min',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Color(0xFF1c2143),
              ),
            ),
            Text(
              '${_weather?.tempMin?.celsius?.toStringAsFixed(0) ?? 'Unknown'}°C',
              style: const TextStyle(
                fontSize: 16.0,
                color: Color(0xFF1c2143),
              ),
            ),
          ],
        ),
      ],
    );
  }


}