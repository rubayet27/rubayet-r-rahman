import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../routes/routes_list.dart';
import '../core/theme/app_theme.dart';
import '../screens/portfolio/cubit/portfolio_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PortfolioCubit>(
          create: (context) => PortfolioCubit()..loadPortfolioData(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Rubayet R Rahman | Portfolio',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: AppTheme.darkTheme,
        theme: AppTheme.darkTheme,
        routerConfig: RoutesPages.router,
      ),
    );
  }
}
