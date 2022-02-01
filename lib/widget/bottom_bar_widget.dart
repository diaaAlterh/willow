import 'package:flutter/material.dart';
import 'package:willow/constant/app_colors.dart';
import 'package:willow/constant/app_images.dart';
import 'package:willow/widget/animation_scale_widget.dart';

enum BottomBar { home, schedule, messages, more }

class BottomBarWidget extends StatefulWidget {
  BottomBar bottomBar;

  BottomBarWidget({Key? key, required this.bottomBar}) : super(key: key);

  @override
  _BottomBarWidgetState createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimationScaleWidget(
      horizontalOffset:100 ,
      verticalOffset: 0,
      child: Container(
        height: 75,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(left: 22, right: 22, bottom: 11),
        child: Card(
          color: Colors.white,
          elevation: 0.8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              bottomBarOption(BottomBar.home, 'Home', AppImages.home),
              bottomBarOption(BottomBar.schedule, 'Schedule', AppImages.calender),
              bottomBarOption(BottomBar.messages, 'Messages', AppImages.chat),
              bottomBarOption(BottomBar.more, 'More', AppImages.options),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomBarOption(BottomBar b, String text, String image) {
    return TextButton(
      onPressed: () {
        widget.bottomBar = b;
        setState(() {});
      },
      child: SizedBox(
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              image,
              color: widget.bottomBar == b
                  ? AppColors.blueButton
                  : AppColors.textBottomBar,
              height: 25,
              width: 25,
            ),
            Text(
              text,
              style: TextStyle(
                  fontSize: 12,
                  color: widget.bottomBar == b
                      ? AppColors.blueButton
                      : AppColors.textBottomBar),
            ),
          ],
        ),
      ),
    );
  }
}
