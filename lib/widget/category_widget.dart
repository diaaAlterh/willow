import 'package:flutter/material.dart';
import 'package:willow/constant/app_colors.dart';
import 'package:willow/widget/animation_scale_widget.dart';

enum Category { upcoming, accepted, doctorInfo, workInfo }

class CategoryWidget extends StatefulWidget {
  Category category;
  String firstOption;
  String secondOption;
  Function firstTab;
  Function secondTab;

  CategoryWidget(
      {Key? key,
      required this.category,
      required this.firstOption,
      required this.secondOption,
      required this.firstTab,
      required this.secondTab})
      : super(key: key);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimationScaleWidget(
      horizontalOffset:50 ,
      verticalOffset: 0,
      child: Container(
        margin: const EdgeInsets.only(left: 22, right: 22, top: 20),
        width: MediaQuery.of(context).size.width,
        height: 57,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: AppColors.categoryBarBackground,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () => widget.firstTab(),
              child: Container(
                width: MediaQuery.of(context).size.width / 2.4,
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: widget.category == Category.upcoming ||
                          widget.category == Category.doctorInfo
                      ? Colors.white
                      : Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    widget.firstOption,
                    style: TextStyle(
                        color: widget.category == Category.upcoming ||
                                widget.category == Category.doctorInfo
                            ? AppColors.blueAccent
                            : AppColors.blueGray,
                        fontWeight: widget.category == Category.upcoming ||
                                widget.category == Category.doctorInfo
                            ? FontWeight.w600
                            : FontWeight.w100,
                        fontSize: 16),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => widget.secondTab(),
              child: Container(
                width: MediaQuery.of(context).size.width / 2.4,
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: widget.category == Category.accepted ||
                          widget.category == Category.workInfo
                      ? Colors.white
                      : Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    widget.secondOption,
                    style: TextStyle(
                        color: widget.category == Category.accepted ||
                                widget.category == Category.workInfo
                            ? AppColors.blueAccent
                            : AppColors.blueGray,
                        fontWeight: widget.category == Category.accepted ||
                                widget.category == Category.workInfo
                            ? FontWeight.w600
                            : FontWeight.w100,
                        fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
