import 'package:e_commerces/components/bottomar.dart';
import 'package:e_commerces/page/cart/cart_page.dart';
import 'package:e_commerces/page/dashboard.dart';
import 'package:e_commerces/page/home/home_page.dart';
import 'package:e_commerces/page/payment/add_address.dart';
import 'package:e_commerces/page/splash/splash_screen.dart';

import 'package:get/get_navigation/src/routes/get_route.dart';

import '../page/login.dart';
import '../page/payment/payment.dart';
import '../page/register.dart';

routes() => [
      GetPage(name: "/dashboard", page: () => const DashBoardPage()),
      GetPage(name: "/bottombar", page: () => const Bottombar()),
      GetPage(name: "/login", page: () => const LoginPage()),
      GetPage(name: "/register", page: () => const RegisterPage()),
      GetPage(name: "/home", page: () => const HomePage()),
      GetPage(name: "/splash", page: () => const SplashScreen()),
      GetPage(name: "/cart", page: () => const CartPage()),
      GetPage(name: "/payment", page: () => const PaymentPage()),
      GetPage(name: "/add_address", page: () => const AddAddress()),
    ];
