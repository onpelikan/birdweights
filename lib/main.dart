import 'package:birds_weights/models/user.dart';
import 'package:birds_weights/models/weight_day.dart';
import 'package:birds_weights/pages/add_weights.dart';
import 'package:birds_weights/pages/authenticate.dart';
import 'package:birds_weights/pages/home.dart';
import 'package:birds_weights/pages/wrapper.dart';
import 'package:birds_weights/services/auth.dart';
import 'package:birds_weights/services/database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

/**
 * Test comment for commit
 */
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).whenComplete(() {
    print("completedAppInitialize");
  });
  runApp(const BirdsWeightsApp());
}

class BirdsWeightsApp extends StatelessWidget {
  const BirdsWeightsApp();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
      initialData: null,
      value: AuthService().user,
      child: const MaterialApp(
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    var args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Wrapper());
      case '/auth':
        return MaterialPageRoute(builder: (_) => const Authenticate());
      case '/add':
        // Validation of correct data type
        args ??= WeightDay(DateTime.now(), getEmptyWeightsMap());
        if (args is WeightDay) {
          return mprAddWeightsWithArgs(args);
        }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static MaterialPageRoute<dynamic> mprAddWeightsWithArgs(WeightDay args) {
    return MaterialPageRoute(
      builder: (_) => AddWeights(
        initValues: args,
      ),
    );
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error routing'),
        ),
        body: const Center(
          child: Text('ERROR routing'),
        ),
      );
    });
  }
}
