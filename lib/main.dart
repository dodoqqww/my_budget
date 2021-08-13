import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_budget/services/service_locator.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'common/theme.dart';
import 'generated/l10n.dart';
import 'models/catalog.dart';
import 'providers/bottom_nav_state.dart';
import 'ui/bottom_nav.dart';
import 'ui/screens/main_screen.dart';

void main() {
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //can't turn the screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        ChangeNotifierProvider<NavigationProvider>(
            child: AppNavigations(),
            create: (BuildContext context) => NavigationProvider()),
        // CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartModel depends
        // on CatalogModel, so a ProxyProvider is needed.

        // ChangeNotifierProxyProvider<CatalogModel, CartModel>(
        //   create: (context) => CartModel(),
        //   update: (context, catalog, cart) {
        //     cart.catalog = catalog;
        //     return cart;
        //   },
        // ),
      ],
      child: MaterialApp(
        // scale
        builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          // maxWidth: 1200,
          minWidth: 400,
          defaultScale: true,
        ),

        //language
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,

        //title && theme
        title: "Title",
        theme: appTheme,

        //routes
        initialRoute: '/',
        routes: {
          '/': (context) => AppNavigations(),
          // '/catalog': (context) => MyCatalog(),
          // '/cart': (context) => MyCart(),
        },
      ),
    );
  }
}
