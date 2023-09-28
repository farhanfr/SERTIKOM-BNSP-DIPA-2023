import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sertifikasi_bnsp/utils/routes.dart' as AppRoute;

void backToRoot(context) {
  Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
}

void popUntilRoot(context) {
  Navigator.popUntil(context, ModalRoute.withName('/'));
}

void backToMain(context) {
  Navigator.pushNamedAndRemoveUntil(context, '/main', (_) => false);
}

void hideKeyboard(context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

void popScreen(BuildContext context, [dynamic data]) {
  Navigator.pop(context, data);
}

enum RouteTransition { slide, dualSlide, fade, material, slideUp }

Future pushScreen(BuildContext context, Widget buildScreen,
    [RouteTransition routeTransition = RouteTransition.slide,
    Widget? fromScreen]) async {
  dynamic data;
  switch (routeTransition) {
    case RouteTransition.slide:
      data =
          await Navigator.push(context, AppRoute.SlideRoute(page: buildScreen));
      break;
    case RouteTransition.fade:
      data =
          await Navigator.push(context, AppRoute.FadeRoute(page: buildScreen));
      break;
    case RouteTransition.material:
      data = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => buildScreen));
      break;
    case RouteTransition.dualSlide:
      data = await Navigator.push(
          context,
          AppRoute.DualSlideRoute(
              enterPage: buildScreen, exitPage: fromScreen ?? context.widget));
      break;
    case RouteTransition.slideUp:
      data = await Navigator.push(
          context, AppRoute.SlideUpRoute(page: buildScreen));
      break;
  }
  return data;
}

void pushAndRemoveScreen(BuildContext context, {@required Widget? pageRef}) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => pageRef!),
      (Route<dynamic> route) => false);
}

String toDateFormat(String dateValue){
  DateTime date = DateFormat('yyyy-MM-dd hh:mm:ss').parse(dateValue);
  String formattedDate = DateFormat('dd/MM/yyyy').format(date);
  return formattedDate;
}
