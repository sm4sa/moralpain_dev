import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:moralpain/assets/constants.dart' as Constant;
import 'package:moralpain/assets/colors.dart' as uvacolors;

class SubmittedRoute extends StatelessWidget {
  const SubmittedRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text(Constant.APPBAR_TEXT)),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(flex: 2, child: thankYouHeader(context)),
              Flexible(
                flex: 1,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                    child: Container(
                        constraints: BoxConstraints.expand(),
                        child: Text(
                          "If you need immediate relief please page PIC1712 to notify the MDC",
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.bodyText1,
                        ))),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                    child: Container(
                        constraints: BoxConstraints.expand(),
                        child: Text(
                          "Resiliency Resources",
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.bodyText1,
                        ))),
              ),
              Flexible(
                flex: 4,
                child: helpfulLinkView(context),
              ),
            ]));
  }

  Widget thankYouHeader(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        child: new Container(
            decoration: new BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,

                  colors: <Color>[
                    uvacolors.UVABlueTints,
                    uvacolors.UVABlueTints.shade50
                  ],
                  tileMode:
                      TileMode.clamp, // repeats the gradient over the canvas
                ),
                boxShadow: [
                  BoxShadow(color: uvacolors.UVABlue.shade100, spreadRadius: 5),
                  BoxShadow(
                      color: uvacolors.UVAOrange.shade200, spreadRadius: 2),
                ],
                color: uvacolors.UVABlue,
                borderRadius: new BorderRadius.only(
                  bottomLeft: Radius.elliptical(
                      MediaQuery.of(context).size.width / 2,
                      MediaQuery.of(context).size.height / 10),
                  bottomRight: Radius.elliptical(
                      MediaQuery.of(context).size.width / 2,
                      MediaQuery.of(context).size.height / 10),
                )),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Thank You!",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .apply(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Your MoD score is important to us and has been recorded",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .apply(color: Colors.white),
                    textAlign: TextAlign.center,
                  )
                ])),
      );

  // TODO (nphair): Figure out scroll clipping text.
  Widget helpfulLinkView(BuildContextcontext) => GridView.count(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: [
          HelpfulLink("Breathing Exercises", "description", Icons.air_rounded),
          HelpfulLink("Body Scan", "description", Icons.person_rounded),
          HelpfulLink("Chair Yoga", "description", Icons.chair_alt_rounded),
          HelpfulLink("Furry Friends", "description", Icons.pets_rounded)
        ].map(buildContainer).toList(),
      );

  Widget buildContainer(HelpfulLink link) {
    return Ink(
        decoration: BoxDecoration(
            color: uvacolors.UVAOrange,
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: InkWell(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(link.title),
                Icon(link.icon, size: 40),
                Text(link.description),
              ]),
          onTap: () {},
        ));
  }
}

// TODO (nphair): Replace with a model.
class HelpfulLink {
  final String title;
  final String description;
  final IconData icon;

  const HelpfulLink(this.title, this.description, this.icon);
}
