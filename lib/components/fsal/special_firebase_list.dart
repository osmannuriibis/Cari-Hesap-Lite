import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cari_hesapp_lite/components/cp_indicators/cp_indicator.dart';
import 'package:cari_hesapp_lite/models/konum.dart';
import 'package:cari_hesapp_lite/utils/extensions.dart';
import 'package:cari_hesapp_lite/utils/konum_service/calc_distance.dart';
import 'package:cari_hesapp_lite/utils/konum_service/konum_extension.dart';
import 'package:cari_hesapp_lite/utils/konum_service/konum_service.dart';
import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:flutter/material.dart';

class MyFirestoreList<T> extends StatelessWidget {
  late Type type;

  final Future<List<T>>? future;
  final Stream<List<T>>? stream;

  ///eğer veri yoksa [map]=>[null], [index]=>[-1] döner
  final Widget Function(BuildContext context, T model, int index) itemBuilder;

  final Widget defaultChild;

  final Widget separator;

  final bool shrinkWrap;
  final ScrollPhysics physics;
  final Widget? listTitle;

  final bool isTitleAlways;

  MyFirestoreList(
      {Key? key,
      this.physics = const NeverScrollableScrollPhysics(),
      this.future,
      this.stream,
      required this.itemBuilder,
      this.defaultChild = const CPIndicator(),
      this.separator = const Divider(),
      this.shrinkWrap = true,
      this.isTitleAlways = true,
      this.listTitle})
      //  : assert(!(stream == null || future == null)),
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    type = (stream != null) ? Stream : Future;
    return type == Stream
        ? StreamBuilder(stream: stream, builder: builder)
        : FutureBuilder(future: future, builder: builder);
  }

  Widget builder(BuildContext context, AsyncSnapshot<List<T>> snapshot) {
    if (snapshot.hasError) {
      bas("snapshot has error:");
      bas(snapshot);
    }

    List<T> list = snapshot.data ?? [];
    /*  if (list.isEmpty) {
      return Text("BOŞ");
    } */
    bas("object");
    return Column(
      children: [
        listTitle != null || (isTitleAlways && listTitle != null)
            ? listTitle!
            : const SizedBox.shrink(),
        AnimatedSize(
          duration: const Duration(milliseconds: 400),
          child: ListView.separated(
            physics: physics,
            shrinkWrap: shrinkWrap,
            itemCount: list.length,
            itemBuilder: (context, index) => AnimatedContainer(
                duration: const Duration(seconds: 5),
                child: itemBuilder(context, list[index], index)),
            separatorBuilder: (context, index) => separator,
          ),
        ),
      ],
    );
  }
}

///eğer veri yoksa [snapshot]=>[null], [index]=>[-1] döner

class MyFirestoreColList extends StatelessWidget {
  final Widget Function(
          BuildContext, QueryDocumentSnapshot<Map<String, dynamic>>?, int)
      itemBuilder;
  final Query<Map<String, dynamic>> query;
  // final Future<QuerySnapshot> futureQuery;

  final bool reverse, shrinkWrap;
  final Widget defaultChild;
  @override
  final Key? key;
  final Type T;

  final EdgeInsets padding;

  final String? filterField;
  final String? filterText;

  ///Snapshot must have this field
  final String? sortingType;

  const MyFirestoreColList({
    this.T = Stream,
    this.key,
    required this.query,
    required this.itemBuilder,
    this.reverse = false,
    this.shrinkWrap = true,
    this.defaultChild = const CPIndicator(),
    this.padding = const EdgeInsets.all(8),
    this.filterField,
    this.filterText,
    this.sortingType,
    /* this.futureQuery */
  })  : /*  assert(futureQuery == null || query == null),
        assert(!(futureQuery == null && query == null)), */
        assert(T == Future || T == Stream),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: (T == Stream)
          ? StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: query.snapshots(),

              ///(BuildContext context,AsyncSnapshot<Event> snapshot) {}
              builder: builder,
            )
          : FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
              future: query.get(),

              ///(BuildContext context,AsyncSnapshot<Event> snapshot) {}
              builder: builder,
            ),
    );
  }

  Widget builder(
    BuildContext context,
    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
  ) {
    if (snapshot.connectionState == ConnectionState.active ||
        snapshot.connectionState == ConnectionState.done) {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> list =
          snapshot.data?.docs ?? [];
      bas("list" * 5);
      bas(list.length);
      // bas(list.first.data().toString());

      if (list.isEmpty) return itemBuilder(context, null, -1);

      bas("sortingType" * 4);
      bas(sortingType);

      if (sortingType != null) {
        if (sortingType == "konum") {
          var currentLocation = KonumService().currentPosition;
          bas("konum sorting yapılıyor");
          bas(list.map((e) => e.data()));
          list.sort((e, y) {
            var first = getDistance(
                currentLocation.asKonum,
                Konum(
                    latitude: e.get("konum")["latitude"] ?? 0,
                    longitude: e.get("konum")["longitude"] ?? 0));
            var second = getDistance(
                currentLocation.asKonum,
                Konum(
                    latitude: y.get("konum")["latitude"] ?? 0,
                    longitude: y.get("konum")["longitude"] ?? 0));

            bas(first);
            bas(second);
            return first.compareTo(second);
          });
          bas("konum sorting yapıldı");
          bas(list.map((e) => e.data()));
        }
      }
      bas("BURADAYIZZ dan bi önce");
      if (filterField.isNotEmptyOrNull && filterText.isNotEmptyOrNull) {
        bas("BURADAYIZZ");
        var val = list.where((element) =>
            (element.data()[filterField] as String)
                .toLowerCase()
                .contains(filterText!.toLowerCase()));
        list = val.toList();
        bas(list.map((e) => e.data()));
      }

      return SingleChildScrollView(
        child: Column(
          mainAxisSize: shrinkWrap ? MainAxisSize.min : MainAxisSize.max,
          children: [
            for (var i = 0; i < list.length; i++)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [itemBuilder(context, list[i], i), const Divider()],
              )
          ],
        ),
      );

      // ignore: dead_code
      ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        controller: ScrollController(keepScrollOffset: false),
        itemCount: list.length,
        shrinkWrap: shrinkWrap,
        reverse: reverse,
        itemBuilder: (context, index) {
          //TODO       AnimatedBuilder(animation: animation, builder: builder);
          //

          return itemBuilder(context, list[index], index);
        },
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          defaultChild,
        ],
      );
    }
  }
}

class MyFirestoreDocList extends StatelessWidget {
  final Widget Function(
          BuildContext context, DocumentSnapshot<Map<String, dynamic>>?)?
      itemBuilder;
  final Stream<DocumentSnapshot<Map<String, dynamic>>>? streamQuery;
  final Future<DocumentSnapshot<Map<String, dynamic>>>? futureQuery;

  final bool reverse, shrinkWrap;
  final Widget defaultChild;
  @override
  final Key? key;

  MyFirestoreDocList(
      {this.key,
      this.streamQuery,
      this.itemBuilder,
      this.reverse = false,
      this.shrinkWrap = true,
      this.defaultChild = const CPIndicator(),
      this.futureQuery})
      : assert(futureQuery == null || streamQuery == null),
        assert(!(futureQuery == null && streamQuery == null)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (streamQuery != null) {
      return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: streamQuery,

        ///(BuildContext context,AsyncSnapshot<Event> snapshot) {}
        builder: builder,
      );
    } else if (futureQuery != null) {
      return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: futureQuery,

        ///(BuildContext context,AsyncSnapshot<Event> snapshot) {}
        builder: builder,
      );
    } else {
      return throw Exception("The issue is in MyFirestoreList");
    }
  }

  Widget builder(BuildContext context,
      AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
    if (snapshot.connectionState == ConnectionState.active) {
      //TODO       AnimatedBuilder(animation: animation, builder: builder);
      //

      return itemBuilder!(context, snapshot.data);
    } else {
      return defaultChild;
    }
  }
}
