import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class FlutterTimeZone extends StatefulWidget {
  const FlutterTimeZone({super.key});

  @override
  State<FlutterTimeZone> createState() => _FlutterTimeZoneState();
}

class _FlutterTimeZoneState extends State<FlutterTimeZone> {
  function() {
    tz.initializeTimeZones();
    var locations = tz.timeZoneDatabase.locations;
    log(locations.length.toString()); // => 429
    log(locations.keys.first); // => "Africa/Abidjan"
    log(locations.keys.last); // => "US/Pacific"

    final timeInNewYork = getTimeInCountry('Asia/Karachi');
    log("Asia/Karachi  $timeInNewYork");
    final timeInLondon = getTimeInCountry('America/Toronto');
    log("America/Toronto  $timeInLondon");
  }

  String getTimeInCountry(String country,
      {String format = 'yyyy-MM-dd hh:mm:ss'}) {
    final location = tz.getLocation(country);
    final currentTime = tz.TZDateTime.now(location);
    //final formatter = DateFormat(format);
    // final formatter = DateFormat();
    final formatter = formatDateWithLocale(
        currentTime, 'nl_BE'); // Replace 'en_US' with the desired locale

    return formatter;
  }

  String formatDateWithLocale(DateTime dateTime, String locale) {
    final formatter = DateFormat.yMMMMd(locale);
    final formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: function,
          child: Text("Press me"),
        ),
      ),
    );
  }
}
