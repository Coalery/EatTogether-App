import 'package:eat_together/bindings/create_party.binding.dart';
import 'package:eat_together/bindings/home.binding.dart';
import 'package:eat_together/bindings/login.binding.dart';
import 'package:eat_together/bindings/my.binding.dart';
import 'package:eat_together/bindings/party.binding.dart';
import 'package:eat_together/bindings/purchase_ready.binding.dart';
import 'package:eat_together/modules/create_party/create_party.page.dart';
import 'package:eat_together/modules/home/home.page.dart';
import 'package:eat_together/modules/login/login.page.dart';
import 'package:eat_together/modules/my/my.page.dart';
import 'package:eat_together/modules/party/party.page.dart';
import 'package:eat_together/modules/purchase/purchase_page.dart';
import 'package:eat_together/modules/purchase/purchase_ready.page.dart';
import 'package:eat_together/modules/splash/splash.page.dart';
import 'package:eat_together/routes/app_routes.dart';
import 'package:get/get.dart';

class Pages {
  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => SplashPage()
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginPage(),
      binding: LoginBinding()
    ),
    GetPage(
      name: Routes.home,
      page: () => HomePage(),
      binding: HomeBinding()
    ),
    GetPage(
      name: Routes.party,
      page: () => PartyPage(),
      binding: PartyBinding()
    ),
    GetPage(
      name: Routes.createParty,
      page: () => CreatePartyPage(),
      binding: CreatePartyBinding()
    ),
    GetPage(
      name: Routes.mypage,
      page: () => MyPage(),
      binding: MyPageBinding()
    ),
    GetPage(
      name: Routes.purchaseReady,
      page: () => PurchaseReadyPage(),
      binding: PurchaseReadyBinding()
    ),
    GetPage(
      name: Routes.purchase,
      page: () => PurchasePage()
    )
  ];
}