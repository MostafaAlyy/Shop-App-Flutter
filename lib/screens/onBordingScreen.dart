import 'package:flutter/material.dart';
import 'package:shop_app/shared/network/local/sharedPreferns.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'LoginScreen.dart';

class onBondingScreen extends StatefulWidget {
  const onBondingScreen({Key? key}) : super(key: key);

  @override
  State<onBondingScreen> createState() => _onBondingScreenState();
}

class _onBondingScreenState extends State<onBondingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(199, 49, 140, 182),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(198, 33, 112, 149),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: SmoothPageIndicator(
            controller: boardController,
            count: 3,
            effect: ExpandingDotsEffect(
              dotColor: Colors.black,
              dotHeight: 10,
              dotWidth: 10,
              spacing: 4,
              expansionFactor: 4,
            ),
          ),
        ),
        actions: [
          MaterialButton(
            child: Text(
              "Skip",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
            onPressed: () {
              setState(() {
                islast = true;
                CashHelper.SaveData(key: "islast", value: islast);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Center(
            child: PageView.builder(
          itemBuilder: (context, index) => onBordingItem(index, context),
          itemCount: 3,
          controller: boardController,
          onPageChanged: (index) {
            setState(() {
              index == 2 ? islast = true : islast = false;
            });
          },
          physics: BouncingScrollPhysics(),
        )),
      ),
    );
  }
}

PageController boardController =
    PageController(initialPage: 0, viewportFraction: 1);
List<String> images = [
  "assets/images/onbording1.png",
  "assets/images/onbording2.png",
  "assets/images/onbording3.png",
];
List<String> onbordingTitle = [
  "Welcome to Shop App",
  "Fast Delivaring",
  "Tracking Your Order",
];
List<String> onbordingText = [
  "Easy Picking Up Whatever You WantFrom Your Home And Online Without Need To Shopping",
  "Quick And Fast Deliver For You With Preserved Deliver",
  "See Where Your Order Is And When It Will Arrive At Your Home",
];
bool islast = false;
Widget onBordingItem(index, context) {
  return Padding(
    padding: const EdgeInsets.all(0.0),
    child: Column(children: [
      Expanded(
        child: Image.asset(
          images[index],
          scale: 0.80,
        ),
      ),
      Text(onbordingTitle[index],
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 8.0),
        child: Text(onbordingText[index],
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white)),
      ),
      SizedBox(
        height: 30,
      ),
      Row(children: [
        SizedBox(width: 100),
        MaterialButton(
            color: Colors.deepOrange,
            minWidth: 200,
            height: 50,
            child: Icon(Icons.arrow_forward),
            onPressed: () {
              if (index == 2) {
                islast = true;
                CashHelper.SaveData(key: "islast", value: islast);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              } else {
                boardController.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              }
            }),
      ]),
      SizedBox(
        height: 45,
      ),
    ]),
  );
}
