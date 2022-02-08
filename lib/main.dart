import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:my_budget/hive_helper/register_adapters.dart';
import 'package:my_budget/models/transaction.dart';
import 'package:my_budget/models/transaction_category.dart';
import 'package:my_budget/providers/graphs_screen_providers.dart';
import 'package:my_budget/providers/main_screen_providers.dart';
import 'package:my_budget/providers/settings_screen_providers.dart';
import 'package:my_budget/ui/screens/main_screen.dart';
import 'package:path_provider/path_provider.dart';
import './services/service_locator.dart';
import './ui/common/theme.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import './generated/l10n.dart';
import 'models/wallet.dart';
import 'providers/bottom_nav_provider.dart';
import './ui/bottom_nav.dart';
import 'ui/screens/graph_screen.dart';
import 'ui/screens/settings_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  registerAdapters();
  await initHive();

  setupServiceLocator();
  runApp(MyApp());
}

Future initHive() async {
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  await Hive.openBox<Wallet>('walletsBox');
  await Hive.openBox<TrxCategory>('trxCategoryBox');
  await Hive.openBox<Transaction>('trxBox');
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
            child: BottomNavigation(),
            create: (BuildContext context) => NavigationProvider()),
        ChangeNotifierProvider<AddEditCategoryScreenProvider>(
            child: SettingsScreen(),
            create: (BuildContext context) => AddEditCategoryScreenProvider()),
        ChangeNotifierProvider<AddEditCategoryScreenProvider>(
            child: MainScreen(),
            create: (BuildContext context) => AddEditCategoryScreenProvider()),
        ChangeNotifierProvider<WalletSettingsProvider>(
            child: SettingsScreen(),
            create: (BuildContext context) => WalletSettingsProvider()),
        ChangeNotifierProvider<WalletSettingsProvider>(
            child: MainScreen(),
            create: (BuildContext context) => WalletSettingsProvider()),
        ChangeNotifierProvider<ReminderSettingsProvider>(
            child: SettingsScreen(),
            create: (BuildContext context) => ReminderSettingsProvider()),
        ChangeNotifierProvider<IncomeWidgetProvider>(
            child: MainScreen(),
            create: (BuildContext context) => IncomeWidgetProvider()),
        ChangeNotifierProvider<ExpenseWidgetProvider>(
            child: MainScreen(),
            create: (BuildContext context) => ExpenseWidgetProvider()),
        ChangeNotifierProvider<MainScreenProvider>(
            child: MainScreen(),
            create: (BuildContext context) => MainScreenProvider()),
        ChangeNotifierProvider<AddEditTrxScreenProvider>(
            child: MainScreen(),
            create: (BuildContext context) => AddEditTrxScreenProvider()),
        ChangeNotifierProvider<GraphsScreenProvider>(
            child: GraphScreen(),
            create: (BuildContext context) => GraphsScreenProvider()),

        ChangeNotifierProxyProvider<MainScreenProvider, IncomeWidgetProvider>(
          create: (context) => IncomeWidgetProvider(),
          update: (context, mainScreenProvider, incomeWidgetProvider) {
            incomeWidgetProvider.selectedDate = mainScreenProvider.selectedDate;
            return incomeWidgetProvider;
          },
        ),

        ChangeNotifierProxyProvider<MainScreenProvider, ExpenseWidgetProvider>(
          create: (context) => ExpenseWidgetProvider(),
          update: (context, mainScreenProvider, incomeWidgetProvider) {
            incomeWidgetProvider.selectedDate = mainScreenProvider.selectedDate;
            return incomeWidgetProvider;
          },
        ),
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
          '/': (context) => BottomNavigation(),
          // '/addTrx': (context) => AddTrxScreen(),
          // '/catalog': (context) => MyCatalog(),
          // '/cart': (context) => MyCart(),
        },
        // onGenerateRoute: (settings) {
        //   switch (settings.name) {
        //     case '/addTrx':
        //       return PageTransition(
        //           child: AddTrxScreen(), type: PageTransitionType.bottomToTop);
        //       break;
        //     default:
        //       return null;
        //   }
        // },
      ),
    );
  }
}
