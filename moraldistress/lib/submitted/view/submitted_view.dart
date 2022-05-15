import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:moraldistress/assets/constants.dart' as Constants;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moraldistress/assets/colors.dart' as uvacolors;
import 'package:moraldistress/submitted/submitted.dart';
import 'package:moralpainapi/moralpainapi.dart' as api;
import 'package:url_launcher/url_launcher.dart';

class SubmittedView extends StatefulWidget {
  @override
  SubmittedViewState createState() => SubmittedViewState();
}

class SubmittedViewState extends State<SubmittedView> {
  final resourcesSheetMinChildSize = 0.1;
  final resourcesSheetInitialChildSize = 0.1;
  final resourcesSheetMaxChildSize = .75;
  var _resourcesShowing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.APPBAR_TEXT),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Flexible(flex: 2, child: thankYouHeader(context)),
            Flexible(
                flex: 1,
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      Constants.SUBMITTED_BODY,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyText1,
                    ))),
            Flexible(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    Constants.SUBMITTED_BODY2,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyText1,
                  )),
              flex: 1,
            ),
            Flexible(flex: 4, child: SizedBox()),
          ]),
          NotificationListener<DraggableScrollableNotification>(
              onNotification: (notification) {
                // NB (nphair): Be sure to round to handle precision of doubles.
                var rounded =
                    double.parse((notification.extent).toStringAsFixed(3));
                if (rounded == notification.maxExtent) {
                  showResources();
                } else if (rounded == notification.minExtent) {
                  hideResources();
                }
                return true;
              },
              child: DraggableScrollableSheet(
                  minChildSize: resourcesSheetMinChildSize,
                  maxChildSize: resourcesSheetMaxChildSize,
                  initialChildSize: resourcesSheetInitialChildSize,
                  snap: true,
                  builder: (context, scrollableController) {
                    return BlocBuilder<ResourcesBloc, ResourcesState>(
                        builder: (context, state) {
                      if (state is ResourcesLoaded) {
                        var cards = state.resources.resources!;
                        return Container(
                            child: ListView.builder(
                                itemCount: cards.length + 1,
                                controller: scrollableController,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index == 0) {
                                    return resiliencyHeader();
                                  }

                                  // NB: Have to minus 1 to account for header.
                                  var resource = cards[index - 1];
                                  return resiliencyTile(resource);
                                }));
                      } else {
                        return Container();
                      }
                    });
                  }))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<ResourcesBloc>().add(VisitedResourcesSubmitEvent());
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          child: Icon(Icons.home_rounded)),
    );
  }

  void showResources() => setState(() {
        _resourcesShowing = true;
      });

  void hideResources() => setState(() {
        _resourcesShowing = false;
      });

  Widget resiliencyHeader() {
    if (_resourcesShowing) {
      return Material(
          child: ListTile(title: Icon(Icons.arrow_drop_down_outlined)));
    }
    return Material(child: ListTile(title: Icon(Icons.arrow_drop_up_outlined)));
  }

  Widget resiliencyTile(api.ResiliencyResource resource) {
    return Material(
        child: ListTile(
            leading: buildIcon(resource),
            title: Text(resource.title!),
            onTap: () {
              context
                  .read<ResourcesBloc>()
                  .add(ResourceVisitedEvent(resource.resourceId!));
              _launchURL(resource.url!);
            }));
  }

  Widget thankYouHeader(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        child: new Container(
            padding: EdgeInsets.all(10),
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
                BoxShadow(
                    color: uvacolors.UVABlueTints.shade100, spreadRadius: 2),
                BoxShadow(
                    color: uvacolors.UVABlueTints.shade200,
                    spreadRadius: 4,
                    blurRadius: 3),
              ],
              color: uvacolors.UVABlue,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Constants.SUBMITTED_TITLE,
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .apply(color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    Constants.SUBMITTED_SUBTITLE,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .apply(color: Colors.white),
                  )
                ])),
      );

  Widget buildIcon(api.ResiliencyResource resiliencyResource) {
    final input = resiliencyResource.icon!;
    final iconData = IconData(
        int.parse(input.codePoint!.replaceFirst('0x', ''), radix: 16),
        fontFamily: input.fontFamily);
    return Icon(iconData, size: 40.0);
  }

  void _launchURL(String url) async => await canLaunch(url)
      ? await launch(url, forceWebView: true, enableJavaScript: true)
      : throw 'Could not launch $url';
}

// TODO (nphair): Replace with a model.
class HelpfulLink {
  final String title;
  final String description;
  final IconData icon;
  final String url;

  const HelpfulLink(this.title, this.description, this.icon, this.url);
}
