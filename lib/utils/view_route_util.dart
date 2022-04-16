
import 'package:cari_hesapp_lite/models/kartlar/cari_kart.dart';
import 'package:cari_hesapp_lite/models/kartlar/stok_kart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../views/cari/cari_list_view/cari_list_view.dart';
import '../views/cari/cari_list_view/cari_list_view_model.dart/cari_list_view_model.dart';
import '../views/stok/stok_list_view/stok_liste_view.dart';

Future<CariKart?> getCariKartByPop(BuildContext context) async{
  return await goToView<CariKart?,CariListViewModel>(context, viewToGo: CariListView(),viewModel: CariListViewModel());


}

Future<StokKart?> getStokKartByPop(BuildContext context) {
  return Navigator.push<StokKart>(
      context,
      MaterialPageRoute(
        builder: (context) => StokListView(),
      ));
}

///[R] return type, [T] viewModel Type
Future<R?> goToView<R, T extends ChangeNotifier>(BuildContext context,
    {T? viewModel, required Widget viewToGo, bool? lazy}) {
  if (viewModel != null) {
    return Navigator.push<R>(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider<T>(
            create: (context) => viewModel,
            child: viewToGo,
            lazy: lazy,
          ),
        ));
  } else {
    return Navigator.push<R>(
        context,
        MaterialPageRoute(
          builder: (context) => viewToGo,
        ));
  }
}

goToViewMultiProvider<R>(BuildContext context,
    {required List<SingleChildWidget> providers, required Widget viewToGo}) {
  return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MultiProvider(
          providers: providers,
          child: viewToGo,
        ),
      ));
}

///[R] return type, T viewModel Type

goToViewWithValue<R, T extends ChangeNotifier>(BuildContext context,
    {required T value, required Widget child, TransitionBuilder? builder}) {
  return Navigator.push<R>(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider<T>.value(
          value: value,
          child: child,
          builder: builder,
        ),
      ));
}
