import 'package:coronavirusrestapiflutter/app/repositories/data_repository.dart';
import 'package:coronavirusrestapiflutter/app/services/data_cache_service.dart';
import 'package:coronavirusrestapiflutter/app/ui/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/services/api.dart';
import 'app/services/api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = "pt_BR";
  await initializeDateFormatting();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(
    sharedPreferences: sharedPreferences,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  const MyApp({this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(
        apiService: APIService(API.sandbox()),
        dataCacheService:
            DataCacheService(sharedPreferences: sharedPreferences),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CoronaVirus tracker',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0xFF101010),
          cardColor: Color(0xFF222222),
        ),
        home: Dashboard(),
      ),
    );
  }
}
