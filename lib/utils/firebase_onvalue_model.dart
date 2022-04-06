import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:cari_hesapp_lite/models/base_model/base_model.dart';
import 'package:cari_hesapp_lite/services/firebase/database/utils/database_utils.dart';
import 'package:flutter/material.dart';


//TODO kullanılmıyrsa sil
class FirebaseModelBuilder2<T extends BaseModel> extends StatelessWidget {
  final String modelId;

  final Widget Function(BuildContext context, T? model) builder;
  final Widget defaultChild;
  final Type type;
  final dbUtil = DBUtils();
  FirebaseModelBuilder2({
    Key? key,
    required this.modelId,
    required this.builder,
    this.defaultChild = const Center(child: CircularProgressIndicator()),
    this.type = Stream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bas("type");
    bas(type);
    return (type == Stream)
        ? StreamBuilder<T?>(
            stream: null,  //dbUtil.getModelAsStream2(modelId), 
            builder: _builder)
        : FutureBuilder<T?>(
            future: dbUtil.getModelAsFuture(modelId), builder: _builder);

    /*  return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: DBUtils().getModelReference<T>(modelId).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData ||
            snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic>? map = snapshot.data?.data();

          return this.builder(context, map);
        } else
          return defaultChild;
      },
    ); */
  }

  Widget _builder(BuildContext context, AsyncSnapshot<T?> snapshot) {
    bas("snapshot.data");
    bas(snapshot.data);

    if (snapshot.connectionState == ConnectionState.done ||
        snapshot.connectionState == ConnectionState.active) {
      return builder(context, snapshot.data);
    } else {
      return defaultChild;
    }
  }
}
