import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_application/Flutter_TimeZone/flutter_timezonde.dart';
import 'package:flutter_bloc_application/bloc/internet_bloc/internet_bloc.dart';
import 'package:flutter_bloc_application/bloc/internet_bloc/internet_state.dart';
import 'package:flutter_bloc_application/cubit/internet_cubit.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'flutter_doenload_files/flutter_download_images/download.dart';

void main() {
  tz.initializeTimeZones();
  log("tz is initialized ");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider<InternetBloc>(create: (context) => InternetBloc()),
        BlocProvider<InternetCubit>(create: (context) => InternetCubit())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: FlutterTimeZone(),
      ),
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocConsumer<InternetCubit, InternetStates>(
            listener: (context, state) {
              if (state == InternetStates.Gained) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("Connected")));
              } else if (state == InternetStates.Lost) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Not Connected")));
              }
            },
            builder: (context, state) {
              if (state == InternetStates.Gained) {
                return const Text("Connected");
              } else if (state == InternetStates.Lost) {
                return const Text("Not Connected");
              }
              return const Text("Loading...");
            },
          )
        ],
      ),
    );
  }
}
