import 'package:cari_hesapp_lite/constants/constants.dart';
import 'package:cari_hesapp_lite/enums/route_names.dart';
import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:cari_hesapp_lite/views/welcome_screen/onboarding/onboarding_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<OnBoardingViewModel>(context);

    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          const Spacer(
            flex: 1,
          ),
          Expanded(
              flex: 5,
              child: PageView.builder(
                onPageChanged: (value) {
                  bas(value);

                  viewModel.changeIndex(value);
                },
                itemCount: viewModel.list.length,
                itemBuilder: (context, index) =>
                    builColumnBody(context, viewModel.list[index]),
              )),
          Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 2,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: viewModel.list.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: context.paddingLow,
                              child: Selector<OnBoardingViewModel, int>(
                                selector: (p0, p1) => p1.index,
                                builder: (_, value, __) {
                                  return CircleAvatar(
                                    backgroundColor: kAccentColor
                                        .withOpacity(value == index ? 1 : 0.2),
                                    radius: value == index
                                        ? context.width * 0.015
                                        : context.width * 0.01,
                                  );
                                },
                              ));
                        },
                      )),
                  const Spacer(),
                  if (viewModel.index > 1)
                    FloatingActionButton.extended(
                        backgroundColor: kPrimaryColor,
                        label: const Text("Başla"),
                        onPressed: () {
                          Navigator.popAndPushNamed(
                              context, RouteNames.AuthWrapper.route);
                        })
                  else
                    Image.asset(
                      "assets/svg/959753-200.png",
                      width: kFloatingActionButtonMargin * 4,
                    )
                ],
              ))
        ],
      ),
    ));
  }
}

Column builColumnBody(BuildContext context, OnboardModel onboardItem) {
  return Column(
    children: [
      Text(onboardItem.title,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.black)),
      Expanded(flex: 5, child: buildSvgPicture(onboardItem.imagePath)),
      buildColumnDescription(context, onboardItem)
    ],
  );
}

Column buildColumnDescription(BuildContext context, OnboardModel onboardItem) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          onboardItem.description,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.black45),
        ),
      )
    ],
  );
}

SvgPicture buildSvgPicture(String imagePath) {
  return SvgPicture.asset(imagePath);
}
