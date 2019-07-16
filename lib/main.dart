import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sncf_schedules/domain/bloc/prefs/prefs_bloc.dart';
import 'package:sncf_schedules/domain/bloc/prefs/prefs_events.dart';
import 'package:sncf_schedules/presentation/navigation/navigation.dart';
import 'package:sncf_schedules/presentation/screens/home/home_page.dart';
import 'package:sncf_schedules/presentation/screens/prefs/set_prefs_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sncf_schedules/presentation/screens/splash/splash_screen.dart';
import 'package:sncf_schedules/presentation/utils/HexToColor.dart';
import 'package:sncf_schedules/presentation/utils/arch_sample_keys.dart';
import 'package:sncf_schedules/presentation/utils/blocs_delegate.dart';

import 'domain/bloc/departures/departures_bloc.dart';
import 'domain/bloc/journeys/journeys_bloc.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final prefsBloc = PrefsBloc();
    final departureBloc = DeparturesBloc(prefsBloc: prefsBloc);
    final journeysBloc = JourneysBloc(prefsBloc: prefsBloc);

    return BlocProviderTree(
      blocProviders: [
        BlocProvider<PrefsBloc>(bloc: prefsBloc),
        BlocProvider<DeparturesBloc>(bloc: departureBloc),
        BlocProvider<JourneysBloc>(bloc: journeysBloc),
      ],
//      bloc: prefsBloc,
      child: MaterialApp(
        title: "Sncf Commuting",
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primaryColor: HexColor("#3C353C"),
          accentColor: HexColor("#F47925"),
        ),
        routes: {
          Navigation.setPrefs: (context) {
            return SetPrefsScreen(
              onInit: () => prefsBloc.dispatch(LoadPrefs()),
              key: SncfSchedulesKeys.setPrefsScreen,
            );
          },
          Navigation.home: (context) {
            return HomeScreen(
              onInit: () => prefsBloc.dispatch(LoadPrefs()),
            );
          },
          Navigation.splash: (context) {
            return SplashScreen(
              onInit: () =>
                  Future.delayed(const Duration(milliseconds: 500), () {
                    prefsBloc.dispatch(LoadPrefs());
                  }),
              key: SncfSchedulesKeys.splashScreen,
            );
          },
        },
      ),
    );
  }
}
