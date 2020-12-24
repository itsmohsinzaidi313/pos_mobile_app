import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_mobile_app/data_provider/login_repo/login_svc.dart';
import 'package:pos_mobile_app/screens/dashboard_screen.dart';
import 'package:pos_mobile_app/screens/login_screen.dart';
import 'package:pos_mobile_app/screens/settings_screen.dart';
import 'package:pos_mobile_app/screens/shift_screen.dart';
import 'package:pos_mobile_app/screens/splash_screen.dart';

import 'bloc/login_bloc/login_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //Screen orientation set to landscape
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((_) {
    runApp(BlocProvider(
      create: (context) => LoginBloc(loginRepo: LoginService()),
      child: new MaterialApp(
        title: 'POS',
        initialRoute: '/splashScreen',
        routes: {
          '/dashboardScreen': (context) => DashboardScreen(),
          '/loginScreen': (context) => LoginScreen(),
          '/splashScreen': (context) => SplashScreen(),
          '/shiftScreen': (context) => ShiftScreen(),
          '/settingScreen': (context) => SettingsScreen(),
        },
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.red,
          primaryColor: Colors.redAccent,
          accentColor: Colors.yellow[800],
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
      ),
    ));
  });
}
