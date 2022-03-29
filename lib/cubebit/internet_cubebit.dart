import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity/connectivity.dart';

enum InternetState { Initial, Lost, Gained }

class InternetCubit extends Cubit<InternetState> {
  Connectivity _connectivity = Connectivity();
  StreamSubscription? connectvitySubscription;

  InternetCubit() : super(InternetState.Initial) {
    connectvitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        emit(InternetState.Gained);
      } else {
        emit(InternetState.Lost);
      }
    });
  }
  @override
  Future<void> close() {
    // TODO: implement close
    connectvitySubscription?.cancel();
    return super.close();
  }
}
