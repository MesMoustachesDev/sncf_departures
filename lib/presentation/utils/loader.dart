import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

Widget getLoader() => Scaffold(
      body: FlareActor(
        "images/load5.flr",
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animation: "load",
      ),
    );
