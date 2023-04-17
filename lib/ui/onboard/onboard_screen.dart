import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:panow_tech/models/onboard.dart';
import 'package:panow_tech/ui/control_screen.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  int currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthManager>(
        builder: (ctx, authManager, child) => SafeArea(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildListCard(),
                    _buildButton(context),
                    const SizedBox(height: 20),
                    _buildBarCurrent(),
                  ],
                ),
              ),
            ));
  }

  Widget _buildListCard() {
    return Container(
      height: MediaQuery.of(context).size.height * .75,
      color: grey,
      child: PageView.builder(
        onPageChanged: (value) {
          setState(() {
            currentScreen = value;
          });
        },
        itemCount: onBoardData.length,
        itemBuilder: (context, index) => OnBoardContent(
          onBoard: onBoardData[index],
        ),
      ),
    );
  }

  Widget _buildButton(context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * .6,
        decoration: BoxDecoration(
            color: primaryCorlor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(offset: Offset(2, 3), color: black26, blurRadius: 5)
            ]),
        child: Center(
          child: Text(
            currentScreen == onBoardData.length - 1 ? 'Start' : 'Continue',
            style: const TextStyle(
                color: white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                height: 1.5),
          ),
        ),
      ),
    );
  }

  Widget _buildBarCurrent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
          onBoardData.length,
          (index) => indicator(index: index),
        ),
      ],
    );
  }

  AnimatedContainer indicator({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: currentScreen == index ? 20 : 5,
      height: 5,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: currentScreen == index ? orange : black.withOpacity(.6),
      ),
    );
  }
}

class OnBoardContent extends StatelessWidget {
  final OnBoards onBoard;
  const OnBoardContent({Key? key, required this.onBoard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .5,
          width: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width - 40,
                    color: orange200,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 28,
                          height: 273,
                          child: SvgPicture.asset(
                            "assets/panow.svg",
                            color: white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                child: Image.asset(
                  onBoard.image,
                  height: 500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Text(
          onBoard.text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            height: 1.5,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textCorlor,
          ),
        ),
      ],
    );
  }
}
