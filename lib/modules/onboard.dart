import 'package:flutter/material.dart';
import 'package:shopapp/component/component.dart';
import 'package:shopapp/models/models.dart';
import 'package:shopapp/modules/login/login.dart';
import 'package:shopapp/networks/local/chachehelper.dart';
import 'package:shopapp/shared/style/const.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoard extends StatefulWidget {
  OnBoard({super.key});

  @override
  _OnBoard createState() {
    return _OnBoard();
  }
}

class _OnBoard extends State<OnBoard> {
  PageController swipe = PageController();
  bool last = false;
  List<Borading> board = [
    Borading(
        image: "assets/images/onboard.png",
        title: "Online Cart",
        detail:
            "Select and memorize your futurepurchases with smart online shopping cart "),
    Borading(
        image: "assets/images/onboard.png",
        title: "Sales and Gifts",
        detail: "Holiday sales . Birthday Gifts"),
    Borading(
        image: "assets/images/onboard.png",
        title: "Client Review",
        detail: "honest feedback from our clients ")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          defaultTextButton(
              context: context,
              function: () {
                CacheHelper.setData(key: "onboard", value: true)!.then((value) {
                  defaultnavigatorRemove(context, Login());
                });
              },
              text: "Skip")
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                    onPageChanged: (index) {
                      if (index == 2) {
                        setState(() {
                          last = true;
                        });
                      }
                    },
                    controller: swipe,
                    physics: const BouncingScrollPhysics(),
                    itemCount: board.length,
                    itemBuilder: (context, index) =>
                        item(context, board[index])),
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                      controller: swipe,
                      count: board.length,
                      effect: const ExpandingDotsEffect(
                          dotColor: Colors.grey,
                          activeDotColor: primary,
                          dotHeight: 8,
                          dotWidth: 8,
                          spacing: 5,
                          expansionFactor: 4)),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (last) {
                        CacheHelper.setData(key: "onboard", value: true)!
                            .then((value) {
                          defaultnavigatorRemove(context, Login());
                        });
                      }
                      swipe.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.decelerate);
                    },
                    child: const Icon(Icons.arrow_forward_ios),
                  )
                ],
              )
            ],
          )),
    );
  }

  Widget item(BuildContext context, Borading board) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage(board.image))),
          Text(board.title, style: Theme.of(context).textTheme.bodyText1),
          const SizedBox(
            height: 10,
          ),
          Text(board.detail, style: Theme.of(context).textTheme.bodyText2),
        ],
      );
}
