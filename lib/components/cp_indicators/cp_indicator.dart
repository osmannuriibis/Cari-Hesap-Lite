import 'package:cari_hesapp_lite/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' as spinkit;

class CPIndicator extends StatelessWidget {
  final double? size;

   
    const CPIndicator({Key? key, 
     
     this.size = 50}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  spinkit.SpinKitCircle(
      size: size!,
      color: kPrimaryColor);
  }
}
/* import 'package:flutter/material.dart';
import 'package:ui_flutter/core/consts.dart';
import 'package:transformer_page_view/parallax.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class SlidersPage extends StatelessWidget {

  static const routeName = '/SlidersPage';
  final List<String> images = ['assets/images/01.png','assets/images/03.png','assets/images/02.png','assets/images/taxi-driver.png'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      /// ---------------------------------------------------------------------
      /// Build scrollable content with PageView.builder and TransformerPageView
      /// ---------------------------------------------------------------------
        body: new TransformerPageView(
            loop: true,
            viewportFraction: 0.8,

            /// ---------------------------------------------------------------------
            /// Build scrollable content with PageTransformerBuilder
            /// ---------------------------------------------------------------------
            transformer: new PageTransformerBuilder(
                builder: (Widget child, TransformInfo info) {
                  return new Padding(
                    padding: new EdgeInsets.all(10.0),
                    child: new Material(
                      elevation: 4.0,
                      textStyle: new TextStyle(color: Colors.white),
                      borderRadius: new BorderRadius.circular(10.0),
                      child: ClipRRect(
                        borderRadius: new BorderRadius.circular(10.0),
                        child: new Stack(
                          fit: StackFit.expand,
                          children: <Widget>[

                            /// ---------------------------------------------------------------------
                            /// Build scrollable content image with ParallaxImage.asset
                            /// ---------------------------------------------------------------------
                            new ParallaxImage.asset(
                              images[info.index],
                              position: info.position,
                            ),

                            /// ---------------------------------------------------------------------
                            /// Background shape
                            /// ---------------------------------------------------------------------
                            new DecoratedBox(
                              decoration: new BoxDecoration(
                                gradient: new LinearGradient(
                                  begin: FractionalOffset.bottomCenter,
                                  end: FractionalOffset.topCenter,
                                  colors: [
                                    const Color(0xFF000000),
                                    const Color(0x33FFC0CB),
                                  ],
                                ),
                              ),
                            ),


                            new Positioned(
                              child: new Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new SizedBox(
                                    height: 8.0,
                                  ),
                                ],
                              ),
                              left: 10.0,
                              right: 10.0,
                              bottom: 10.0,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
            itemCount: images.length)
    );
  }
}
 */