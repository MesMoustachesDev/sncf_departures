import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sncf_schedules/domain/bloc/prefs/prefs_bloc.dart';
import 'package:sncf_schedules/domain/bloc/prefs/prefs_states.dart';
import 'package:sncf_schedules/presentation/navigation/navigation.dart';
import 'package:sncf_schedules/presentation/utils/arch_sample_keys.dart';
import 'package:sncf_schedules/presentation/utils/loader.dart';

class SplashScreen extends StatefulWidget {
//  final OnSaveCallback onSave;
  final void Function() onInit;

  SplashScreen({
    @required this.onInit,
    Key key,
//    @required this.onSave,
  }) : super(key: key ?? SncfSchedulesKeys.splashScreen);

  @override
  SplashScreenState createState() {
    return new SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prefsBloc = BlocProvider.of<PrefsBloc>(context);
    return BlocBuilder(
        cubit: prefsBloc,
        builder: (BuildContext context, PrefsState state) {
          if (state is PrefsSet) {
            print("pushing home");
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, Navigation.home);
            });
            return getLoader();
          } else if (state is PrefsLoading) {
            return getLoader();
          } else {
            print("pushing prefs");
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, Navigation.setPrefs);
            });
            return getLoader();
          }
        });
  }
}
