import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/material.dart';

import 'package:moraldistress/assets/constants.dart' as Constants;
import 'package:moraldistress/assets/colors.dart' as uvacolors;
import '../../thermometer/thermometer.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_authenticator/src/constants/authenticator_constants.dart';
import 'package:amplify_authenticator/src/keys.dart';
import 'package:amplify_authenticator/src/state/auth_state.dart';
import 'package:amplify_authenticator/src/state/inherited_auth_bloc.dart';
import 'package:amplify_authenticator/src/utils/list.dart';
import 'package:amplify_authenticator/src/widgets/component.dart';
import 'package:amplify_authenticator/src/widgets/progress.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Constants.APPBAR_TEXT)),
      body: CustomPaint(
          painter: HomePainter(),
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(4),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0)))),
                  child: const Text(Constants.HOME_BUTTON_TEXT),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ThermometerRoute()),
                    );
                  },
                ),
                MySignOutButton()
              ]))),
    );
  }
}

class MySignOutButton extends StatelessAuthenticatorComponent {
  /// {@macro amplify_authenticator.sign_out_button}
  const MySignOutButton({Key? key = keySignOutButton}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AuthenticatorState state,
    AuthStringResolver stringResolver,
  ) {
    final ButtonResolver buttonResolver = stringResolver.buttons;

    return ElevatedButton(
      onPressed: state.signOut,
      child: Text(
        buttonResolver.signout(context),
      ),
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(4),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0)))),
    );
  }
}

class HomePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    if (isPortrait(size)) {
      paintPortrait(canvas, size);
    } else {
      paintLandscape(canvas, size);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

  bool isPortrait(Size size) {
    return size.height > size.width;
  }

  void paintPortrait(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint uvaBlue = Paint();
    uvaBlue..color = uvacolors.UVABlue.withAlpha(200);
    Paint uvaOrange = Paint();
    uvaOrange..color = uvacolors.UVAOrange.shade100;

    final largeCirleOffset = Offset(width * .52, height * .92);
    final largeCircleRadius = width * .40;
    canvas.drawCircle(largeCirleOffset, largeCircleRadius, uvaBlue);

    final mediumCirlceOffset = Offset(width * .8, height * .96);
    final mediumCircleRadius = width * .25;
    canvas.drawCircle(mediumCirlceOffset, mediumCircleRadius, uvaBlue);

    final smallCirlceOffset = Offset(width * .2, height * .55);
    final smallCircleRadius = width * .15;
    canvas.drawCircle(smallCirlceOffset, smallCircleRadius, uvaBlue);

    final tinyCirlceOffset = Offset(width * .85, height * .12);
    final tinyCircleRadius = width * .04;
    canvas.drawCircle(tinyCirlceOffset, tinyCircleRadius, uvaOrange);
  }

  void paintLandscape(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint uvaBlue = Paint();
    uvaBlue..color = uvacolors.UVABlue.withAlpha(200);
    Paint uvaOrange = Paint();
    uvaOrange..color = uvacolors.UVAOrange.shade100;

    final largeCirleOffset = Offset(width * .05, height * .5);
    final largeCircleRadius = width * .18;
    canvas.drawCircle(largeCirleOffset, largeCircleRadius, uvaBlue);

    final mediumCirlceOffset = Offset(width * .5, height * .9);
    final mediumCircleRadius = width * .13;
    canvas.drawCircle(mediumCirlceOffset, mediumCircleRadius, uvaBlue);

    final smallCirlceOffset = Offset(width * .3, height * .25);
    final smallCircleRadius = width * .02;
    canvas.drawCircle(smallCirlceOffset, smallCircleRadius, uvaOrange);
  }
}
