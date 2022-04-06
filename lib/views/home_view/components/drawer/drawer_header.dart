import 'package:cari_hesapp_lite/components/scroll_column.dart';
import 'package:cari_hesapp_lite/constants/constants.dart';
import 'package:cari_hesapp_lite/services/firebase/auth/service/auth_service.dart';
import 'package:cari_hesapp_lite/utils/extensions.dart';
import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:cari_hesapp_lite/utils/view_route_util.dart';
import 'package:cari_hesapp_lite/views/profile_view/profile_view.dart';
import 'package:cari_hesapp_lite/views/profile_view/profile_view_model.dart';
import 'package:flutter/material.dart';

import '../../../../utils/user_provider.dart';

class Header extends StatelessWidget {
  Header({
    Key? key,
  }) : super(key: key);

  UserProvider userProvider = UserProvider();

  @override
  Widget build(BuildContext context) {
    bas("userProvider.userModel.photoUrl");
    bas(userProvider.userModel?.toMap());

    bas(userProvider.userModel?.photoURL);

    return DrawerHeader(
      // curve: Curves.elasticIn,
      // padding: EdgeInsets.all(0),
      // decoration: BoxDecoration(),
      child: MyColumn(
        isSeperator: false,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            child: Container(
              decoration: const ShapeDecoration(
                  color: kPrimaryColor, shape: CircleBorder()),
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      (userProvider.userModel?.photoURL.isEmptyOrNull ?? true)
                          ? defaultImage
                          : Image.network(userProvider.userModel!.photoURL!)
                              .image,
                ),
              ),
            ),
            onTap: () {
              goToView(context,
                  viewToGo: ProfileView(),
                  viewModel:
                      ProfileViewModel( AuthService().currentUserId!));
            },
          ),
          const Divider(),
          GestureDetector(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AuthService().currentUserEmail?.substring(0, 17) ?? "__",
                  style: const TextStyle(fontSize: 15, fontFamily: "Quicksand"),
                  overflow: TextOverflow.clip,
                ),
                const Icon(
                  Icons.settings,
                  size: 20,
                  color: Colors.black54,
                )
              ],
            ),
            onTap: () {
              goToView(context,
                  viewToGo: ProfileView(),
                  viewModel:
                      ProfileViewModel( AuthService().currentUserId!));
            },
          ),
          const Divider(),
          GestureDetector(
            onTap: () {
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userProvider.sirketModel?.unvani ?? "null",
                  style: const TextStyle(fontSize: 20, fontFamily: "Quicksand"),
                ),
                const Icon(
                  Icons.settings,
                  size: 20,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
