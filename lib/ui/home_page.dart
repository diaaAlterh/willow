import 'package:flutter/material.dart';
import 'package:willow/constant/app_colors.dart';
import 'package:willow/constant/app_images.dart';
import 'package:willow/widget/animation_scale_widget.dart';
import 'package:willow/widget/bottom_bar_widget.dart';
import 'package:willow/helper/linking_screens.dart';
import 'package:willow/ui/doctor_info_page.dart';
import 'package:willow/widget/category_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Category category = Category.accepted;
  BottomBar bottomBar = BottomBar.schedule;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Schedule',
          style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        leading: IconButton(
          tooltip: 'Open navigation menu',
          icon: Image.asset(
            AppImages.drawer,
            height: 28,
            width: 28,
          ),
          padding: const EdgeInsets.only(left: 20),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            tooltip: 'Settings',
            icon: Image.asset(
              AppImages.settings,
              height: 28,
              width: 28,
            ),
            padding: const EdgeInsets.only(right: 20),
            onPressed: () {},
          )
        ],
      ),
      bottomNavigationBar: BottomBarWidget(
        bottomBar: bottomBar,
      ),
      body: Column(
        children: [
          CategoryWidget(
            category: category,
            firstOption: 'Upcoming',
            secondOption: 'Accepted',
            firstTab: () {
              category = Category.upcoming;
              setState(() {});
            },
            secondTab: () {
              category = Category.accepted;
              setState(() {});
            },
          ),
          if (category == Category.upcoming)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.booking,
                    width: 240,
                    height: 120,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'No Available Bookings',
                    style: TextStyle(color: AppColors.black, fontSize: 18),
                  )
                ],
              ),
            ),
          if (category == Category.accepted) thisWeek(),
          if (category == Category.accepted)
            Expanded(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return AnimationScaleWidget(
                        position: index, verticalOffset: 50, child: card(index));
                  }),
            ),
        ],
      ),
    );
  }

  Widget thisWeek() {
    return Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(top: 20),
        height: 35,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Container(
          margin: const EdgeInsets.only(left: 22),
          child: Text(
            'This Week',
            style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w500,
                fontSize: 15),
          ),
        ));
  }

  Widget card(int index) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Card(
        elevation: 0.8,
        child: InkWell(
          onTap: () {
            linkingScreens.goToNextScreen(context, DoctorInfoPage(index));
          },
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8, right: 8, left: 8),
                child: ListTile(
                  title: Text(
                    'Eva Reid',
                    style: TextStyle(
                        color: AppColors.cardTitle,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top:4.0),
                    child: Text(
                      'Online Consultation',
                      style: TextStyle(color: AppColors.cardTitle, fontSize: 16),
                    ),
                  ),
                  trailing: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 25,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Hero(
                            tag: 'userPhoto$index',
                            child: Image.asset(AppImages.placeholder))),
                  ),
                ),
              ),
              const Divider(),
              Container(
                margin: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          AppImages.date,
                          height: 18,
                          width: 18,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('November 17, 12:30 PM'),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.green,
                          radius: 4,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('Confirmed'),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 22, right: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.blueButton,
                          ),
                          height: 40,
                          width: 160,
                          child: const Center(
                            child: Text(
                              'Start examination',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.blueAccent.withOpacity(0.2),
                          ),
                          width: 100,
                          height: 40,
                          child: Center(
                            child: Text(
                              'Reshedule',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.blueAccent),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
