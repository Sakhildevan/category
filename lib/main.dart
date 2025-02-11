import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'bloc/category_bloc.dart';
import 'bloc/product_bloc.dart';
import 'data/repository/product_repository.dart';
import 'presentation/screen/category_product_screen.dart';
import 'presentation/screen/splash_screen.dart';

void main() async {
  await dotenv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CategoryBloc(ProductRepository())),
        BlocProvider(create: (context) => ProductBloc(ProductRepository())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Category Product App',
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/home': (context) => CategoryProductScreen(),
        },
      ),
    );
  }
}
