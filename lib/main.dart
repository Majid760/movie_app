import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_assessment/core/utils/app_path.dart';
import 'package:movie_app_assessment/features/movies/presentation/pages/watch_screen.dart';

import 'configs/routes/app_routes.dart';
import 'core/di/service_locator.dart';
import 'core/presentation/widgets/bottom_navbar.dart';
import 'features/movies/presentation/manager/movie_detail_cubit.dart';
import 'features/search/presentation/manager/search_movie_cubit.dart';

Future<void> main() async {
  // debugPaintSizeEnabled = true;
  // Initialize service locator
  await ServicesLocator.shared.init();

  // Set up a global error handler for Flutter framework errors.
  FlutterError.onError = (FlutterErrorDetails details) {
    // Log the error or send it to an error tracking service
    if (kDebugMode) {
      print('Caught Flutter framework error: ${details.exceptionAsString()}');
    }
    // Continue to present the error for further processing
    FlutterError.presentError(details);
  };
  // Use runZonedGuarded to catch all uncaught asynchronous errors
  runApp(const MyApp());
}

void sendErrorToService(Object error, StackTrace stackTrace) {
  // Send the error details to Firebase Crashlytics
  // FirebaseCrashlytics.instance.recordError(error, stackTrace);
  // Log the error for debugging
  debugPrint('Caught asynchronous error: $error');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => WidgetsBinding.instance.focusManager.primaryFocus?.unfocus(),
        child: MultiBlocProvider(
            providers: [
              BlocProvider<MovieDetailCubit>(create: (context) => MovieDetailCubit(), lazy: false),
              BlocProvider<SearchCubit>(create: (context) => SearchCubit(), lazy: false),
              // Add other BlocProviders here as needed
              // BlocProvider<AnotherCubit>(
              //   create: (context) => GetIt.instance<AnotherCubit>(),
              // ),
            ],
            child: MaterialApp.router(
              routerConfig: AppRouter.router,
              debugShowCheckedModeBanner: false,
            )));
  }
}

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({super.key});

  @override
  State<AppBottomNavigationBar> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<AppBottomNavigationBar> with SingleTickerProviderStateMixin {
  int _tabIndex = 1;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  void _onTabTapped(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

  List<Widget> screens = [
    Container(alignment: Alignment.center, child: Text("Dashboard")),
    WatchScreen(),
    Container(alignment: Alignment.center, child: Text("Media Library")),
    Container(alignment: Alignment.center, child: Text("More")),
  ];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000), // Slightly longer for smoother animation
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start from below the screen
      end: Offset.zero, // End at original position
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic, // Smooth easing curve
    ));

    // Start the navbar slide animation when widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SlideTransition(
        position: _slideAnimation,
        child: AppNavBar(
          currentIndex: _tabIndex,
          onTap: _onTabTapped,
          navbarItems: [
            AppNavBarItem(
              navbarIcon: AppSvgWidget.dashboardIcon,
              active: AppSvgWidget.dashboardIcon, // Use your actual active icon here
              label: "Dashboard",
            ),
            AppNavBarItem(
              navbarIcon: AppSvgWidget.watchIcon,
              label: "Watch",
              active: AppSvgWidget.watchIcon, // Use your actual active icon here
            ),
            AppNavBarItem(
              navbarIcon: AppSvgWidget.mediaLabIcon,
              active: AppSvgWidget.mediaLabIcon, // Use your actual active icon here
              label: "Media Library",
            ),
            AppNavBarItem(
              navbarIcon: AppSvgWidget.moreIcon,
              active: AppSvgWidget.moreIcon, // Use your actual active icon here
              label: "More",
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _tabIndex,
        children: screens,
      ),
    );
  }
}
