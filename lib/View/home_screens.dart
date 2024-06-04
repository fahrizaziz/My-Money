import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:mymoney/Model/auth_model.dart';
import 'package:mymoney/View/inoutcome_screens.dart';
import 'package:mymoney/ViewModel/auth_providers.dart';
import 'package:provider/provider.dart';

import '../Model/Utils/assets.dart';
import '../Model/Utils/colors.dart';
import '../Model/Utils/strings.dart';
import 'login_screens.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  AuthProviders? _authProviders;
  @override
  Widget build(BuildContext context) {
    _authProviders = Provider.of<AuthProviders>(context);
    AuthModel user = _authProviders!.user;
    return Scaffold(
      endDrawer: drawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
            child: Row(
              children: [
                Image.asset(AppAsset.profile),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hi,',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        user.dataField!.dataUser!.name!.isEmpty
                            ? ''
                            : user.dataField!.dataUser!.name!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                ),
                Builder(builder: (ctx) {
                  return Material(
                    borderRadius: BorderRadius.circular(4),
                    color: CustomColor.chart,
                    child: InkWell(
                      onTap: () {
                        Scaffold.of(ctx).openEndDrawer();
                      },
                      borderRadius: BorderRadius.circular(4),
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          Icons.menu,
                          color: CustomColor.primary,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                // cHome.getAnalysis(cUser.data.idUser!);
              },
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                children: [
                  Text(
                    Strings.pengeluaranHariIni,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  DView.height(),
                  // cardToday(context),
                  DView.height(30),
                  Center(
                    child: Container(
                      height: 5,
                      width: 80,
                      decoration: BoxDecoration(
                        color: CustomColor.bg,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  DView.height(30),
                  Text(
                    Strings.pengeluaranMingguIni,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  DView.height(),
                  // weekly(),
                  DView.height(30),
                  Text(
                    Strings.pengeluaranBulanIni,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  DView.height(),
                  // monthly(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Drawer drawer() {
    _authProviders = Provider.of<AuthProviders>(context);
    AuthModel user = _authProviders!.user;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            margin: const EdgeInsets.only(
              bottom: 0,
            ),
            padding: const EdgeInsets.fromLTRB(
              20,
              16,
              16,
              20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(AppAsset.profile),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.dataField!.dataUser!.name!.isEmpty
                                ? ''
                                : user.dataField!.dataUser!.name!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            user.dataField!.dataUser!.email ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Material(
                  color: CustomColor.primary,
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                  child: Consumer<AuthProviders>(
                    builder: (context, value, child) {
                      return InkWell(
                        onTap: () {
                          value.logout();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreens(),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(
                          30,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 8,
                          ),
                          child: Text(
                            Strings.keluar,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              // Get.to(() => AddHistoryPage())?.then((value) {
              //   if (value ?? false) {
              //     cHome.getAnalysis(cUser.data.idUser!);
              //   }
              // });
            },
            leading: const Icon(
              Icons.add,
            ),
            horizontalTitleGap: 0,
            title: Text(
              Strings.tambahBaru,
            ),
            trailing: const Icon(
              Icons.navigate_next,
            ),
          ),
          const Divider(height: 1),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => InOutComeScreens(
                    type: Strings.pemasukan,
                  ),
                ),
              );
            },
            leading: const Icon(
              Icons.south_west,
            ),
            horizontalTitleGap: 0,
            title: Text(
              Strings.pemasukan,
            ),
            trailing: const Icon(
              Icons.navigate_next,
            ),
          ),
          const Divider(height: 1),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => InOutComeScreens(
                    type: Strings.pengeluaran,
                  ),
                ),
              );
            },
            leading: const Icon(
              Icons.north_east,
            ),
            horizontalTitleGap: 0,
            title: Text(
              Strings.pengeluaran,
            ),
            trailing: const Icon(
              Icons.navigate_next,
            ),
          ),
          const Divider(height: 1),
          ListTile(
            onTap: () {
              // Get.to(() => const HistoryPage());
            },
            leading: const Icon(
              Icons.history,
            ),
            horizontalTitleGap: 0,
            title: Text(
              Strings.riwayat,
            ),
            trailing: const Icon(
              Icons.navigate_next,
            ),
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }
}
