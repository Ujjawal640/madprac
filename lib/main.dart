// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/common/theme.dart';
import 'package:shop_app/models/cart.dart';
import 'package:shop_app/models/catalog.dart';
import 'package:shop_app/screens/cart.dart';
import 'package:shop_app/screens/catalog.dart';
import 'package:shop_app/screens/login.dart';


void main() {
  setupWindow();
  runApp(const MyApp());
}

const double windowWidth = 400;
const double windowHeight = 800;

void setupWindow() {
 
  
}

GoRouter router() {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const MyLogin(),
      ),
      GoRoute(
        path: '/catalog',
        builder: (context, state) => const MyCatalog(),
        routes: [
          GoRoute(
            path: 'cart',
            builder: (context, state) => const MyCart(),
          ),
        ],
      ),
    ],
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        Provider(create: (context) => CatalogModel()),
        // CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartModel depends
        // on CatalogModel, so a ProxyProvider is needed.
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            if (cart == null) throw ArgumentError.notNull('cart');
            cart.catalog = catalog;
            return cart;
          },
        ),
      ],
      child: MaterialApp.router(
        title: 'Provider Demo',
        theme: appTheme,
        routerConfig: router(),
      ),
    );
  }
}





/*import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/config/routes.dart';
import 'firebase_options.dart';
import 'package:shop_app/screens/login2.dart';
import 'package:shop_app/screens/register.dart';

void main() async {
  // ensures that widget gets loaded first and then firebase gets initialized.
  WidgetsFlutterBinding.ensureInitialized();
  // initialize the firebase --> returns a future object --> waits till the time application gets initialized.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    // home: Login(),
    initialRoute: '/',
    routes: getRoutes(),
  ));
}
*/