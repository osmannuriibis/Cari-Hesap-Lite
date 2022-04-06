import 'package:cari_hesapp_lite/components/scroll_column.dart';
import 'package:flutter/gestures.dart';

import '../../../components/buttons/fab.dart';
import '../../../constants/constants.dart';
import '../../../models/kartlar/cari_kart.dart';
import 'cari_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cari_view_pages/analyze/cari_analyze_page.dart';
import 'cari_view_pages/home/cari_home_page.dart';
import 'cari_view_pages/transactions/cari_transaction_page.dart';
import 'components/end_drawer.dart';

class CariView extends StatefulWidget {
/*   @override
  _CariViewState createState() => _CariViewState();
}

DatabaseService<CariKart> dbService = DatabaseService();

class _CariViewState extends State<CariView> { */
  @override
  _CariViewState createState() => _CariViewState();
}

class _CariViewState extends State<CariView> {
  late CariViewModel viewModel;
  late CariViewModel viewModelUnlistened;

  late CariKart cariKart;

  int _seciliIndex = 0;

  Widget _seciliSayfa(int index) {
    switch (index) {
      case 0:
        return CariHomePage();

      case 1:
        return CariTransPage();
      case 2:
        return CariAnalyzePage();

      default:
        return const Center(child: Text("Bir Hata Oluştu"));
    }
  }

  safyaDegistir(int seciliSayfa) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<CariViewModel>(this.context);
    viewModelUnlistened =
        Provider.of<CariViewModel>(this.context, listen: false);
    cariKart = viewModel.cariKart;
    return WillPopScope(
      onWillPop: () async {
        if (!viewModelUnlistened.scaffoldKey.currentState!.isEndDrawerOpen) {
          if (_seciliIndex != 0) {
            _seciliIndex = 0;
            setState(() {});
          } else {
            return true;
          }
        } else {
          Navigator.pop(context);
        }
        return false;
      },
      child: Scaffold(
        key: viewModel.scaffoldKey,
        floatingActionButton: FAB(
          child: const Icon(Icons.playlist_add_outlined),
          onPressed: () {
            openDrawer();
          },
        ),
        
        endDrawer: CariViewEndDrawer(),
        /*    appBar: AppBar(
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              "https://picsum.photos/200/300",
              fit: BoxFit.cover,
            ),
            stretchModes: [
              StretchMode.blurBackground,
            ],
            collapseMode: CollapseMode.parallax,
            title: Text((cariKart.unvani ?? "null")),
      
            /* viewModelUnlistened.personel.imagePath != ""
                    ? Image.network("https://thispersondoesnotexist.com/image")
                    : Image.asset("assets/images/user_default_avatar.png") */
          ),
        ), */
        /*  appBar: AppBar(
          title: Text(widget.cariKart.unvani),
        ), */
        body: SafeArea(
          child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              primary: true,
              slivers: [
                SliverAppBar(
                  stretch: true,
                  //title: Text(widget.cariKart.unvani),

                  backgroundColor: kPrimaryColor,
                  expandedHeight: MediaQuery.of(context).size.height * 0.20,
                  floating: true,
                  excludeHeaderSemantics: true,

                  // collapsed appBar'ı gizliyor
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      "https://picsum.photos/200/300",
                      fit: BoxFit.cover,
                    ),
                    collapseMode: CollapseMode.pin,
                    title: Text((cariKart.unvani ?? "null")),

                    /* viewModelUnlistened.personel.imagePath != ""
                      ? Image.network("https://thispersondoesnotexist.com/image")
                      : Image.asset("assets/images/user_default_avatar.png") */
                  ),
                ),
                SliverFillRemaining(
                  /*   itemExtent: 100, */
                  //  fillOverscroll: true,
                  fillOverscroll: true,

                  child: _seciliSayfa(_seciliIndex),
                ),
              ]),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  void openDrawer() {
    viewModelUnlistened.scaffoldKey.currentState!.openEndDrawer();
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _seciliIndex,
      onTap: (index) {
        setState(() {
          _seciliIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Ofis"),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: "İşlemler"),
        BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart_outlined), label: "Analiz"),
      ],
    );
  }
}

/*   Tab(icon: Icon(Icons.home), text: "Ofis"),
              Tab(icon: Icon(Icons.list), text: "İşlemler"),
              Tab(icon: Icon(Icons.insert_chart_outlined), text: "Analiz"), */
