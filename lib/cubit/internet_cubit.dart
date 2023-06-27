import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Enum for State --->> same as State class in bloc
enum InternetStates { Initial, Gained, Lost }

class InternetCubit extends Cubit<InternetStates> {
  Connectivity connectivity = Connectivity();
  StreamSubscription? streamSubscription;

  InternetCubit() : super(InternetStates.Initial) {
    streamSubscription = connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        emit(InternetStates.Gained);
      } else {
        emit(InternetStates.Lost);
      }
    });
  }
  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
}
