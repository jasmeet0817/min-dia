import 'package:get/get.dart';
import 'package:min_dia/routes/routes_name.dart';
import 'package:min_dia/views/audio_view.dart';
import 'package:min_dia/views/book_view.dart';
import 'package:min_dia/views/home_view.dart';

class AppRoutes {
  static appRoutes() => [
    GetPage(
      name: RoutesName.homeView,
      page: () => HomeView(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: RoutesName.bookView,
      page: () => BookView(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: RoutesName.audioView,
      page: () => AudioView(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
    ),
  ];
}
