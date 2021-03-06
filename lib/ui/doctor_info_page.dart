import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:willow/bloc/doctor_info_bloc.dart';
import 'package:willow/constant/app_colors.dart';
import 'package:willow/constant/app_images.dart';
import 'package:willow/helper/linking_screens.dart';
import 'package:willow/model/doctor_info_model.dart';
import 'package:willow/widget/animation_scale_widget.dart';
import 'package:willow/widget/category_widget.dart';

class DoctorInfoPage extends StatefulWidget {
  final int index;
  final int? doctorId;

  const DoctorInfoPage(this.index, this.doctorId, {Key? key}) : super(key: key);

  @override
  _DoctorInfoPageState createState() => _DoctorInfoPageState();
}

class _DoctorInfoPageState extends State<DoctorInfoPage> {
  Category category = Category.doctorInfo;

  List<String> cert = [
    AppImages.cert1,
    AppImages.cert2,
    AppImages.cert3,
    AppImages.cert4,
  ];

  bool basicInformation = false;
  bool certificates = false;
  bool insurance = false;

  final basicInformationKey = GlobalKey();
  final certificatesKey = GlobalKey();
  final insuranceKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  _getData() {
    doctorInfoBloc.fetch(widget.doctorId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DoctorInfoModel>(
          stream: doctorInfoBloc.info,
          builder: (context, AsyncSnapshot<DoctorInfoModel> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  customAppBar(
                      name: snapshot.data?.data.information.name ?? '',
                      specialization:
                          snapshot.data?.data.information.specialization ?? ''),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          rateBar(snapshot.data?.data.information.rate ?? 1.0),
                          brief(
                              profileView: snapshot
                                      .data?.data.information.profileViews ??
                                  0,
                              patients:
                                  snapshot.data?.data.information.patients ?? 0,
                              exp: snapshot.data?.data.information.experience ??
                                  0),
                          CategoryWidget(
                            category: category,
                            firstOption: 'Doctor Info',
                            secondOption: 'Work Info',
                            firstTab: () {
                              category = Category.doctorInfo;
                              setState(() {});
                            },
                            secondTab: () {
                              category = Category.workInfo;
                              basicInformation = false;
                              certificates = false;
                              insurance = false;
                              setState(() {});
                            },
                          ),
                          (category == Category.doctorInfo)
                              ? _doctorInfoList()
                              : _doctorWorkInfoList(),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text('No Internet Connection'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget customAppBar({
    required String name,
    required String specialization,
  }) {
    return Column(
      children: [
        Stack(
          children: [
            const SizedBox(height: 250,),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    AppImages.appBarBackground,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    fit: BoxFit.fill,
                  ),
                  // color: Colors.black,
                ),
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 30),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: IconButton(
                            tooltip: 'Back',
                            onPressed: () {
                              linkingScreens.goBack(context);
                            },
                            icon: Image.asset(
                              AppImages.back,
                              height: 27,
                              width: 27,
                            )),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                AppImages.appointment,
                                width: 27,
                                height: 27,
                              )),
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: IconButton(
                                onPressed: () {},
                                icon: Image.asset(
                                  AppImages.alert,
                                  width: 22,
                                  height: 22,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
              // color: Colors.yellow,
              alignment: Alignment.topRight,
              margin: const EdgeInsets.only(top:140.0,right: 20),
              // height: MediaQuery.of(context).orientation == Orientation.portrait?250:300,
              child: SizedBox(
                height: 125,
                width: 125,
                child: Hero(
                    tag: 'userPhoto${widget.index}',
                    child: Image.asset(AppImages.placeholder)),
              ),
            ),
            Container(
              // color: Colors.yellow,
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 10,top:200.0),
              child: SizedBox(
                // width: 250,
                // height: MediaQuery.of(context).orientation == Orientation.portrait?250:300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(left: 12),
                        width: 220,
                        child: Row(
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Image.asset(
                              AppImages.check,
                              height: 16,
                              width: 16,
                            )
                          ],
                        )),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 12),
                      width: 220,
                      child: Text(specialization,
                          style: const TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
              ),
            )

          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  Widget rateBar(double rate) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          RatingBar.builder(
            initialRating: rate,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemSize: 18,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 1),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: AppColors.star,
              size: 5,
            ),
            onRatingUpdate: (rating) {},
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 15,
            alignment: Alignment.topCenter,
          )
        ],
      ),
    );
  }

  Widget brief(
      {required int profileView, required int patients, required int exp}) {
    return Container(
      margin: const EdgeInsets.only(top: 20, right: 14, left: 14),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              const Text(
                'Profile View',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                '$profileView+',
                style: TextStyle(fontSize: 20, color: AppColors.blueAccent),
              ),
            ],
          ),
          Container(
            height: 60,
            width: 1,
            color: AppColors.border,
          ),
          Column(
            children: [
              const Text(
                'Patients',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                '$patients+',
                style: TextStyle(fontSize: 20, color: AppColors.blueAccent),
              ),
            ],
          ),
          Container(
            height: 60,
            width: 1,
            color: AppColors.border,
          ),
          Column(
            children: [
              const Text(
                'Experience',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                '$exp years',
                style: TextStyle(fontSize: 20, color: AppColors.blueAccent),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget tile(String image, String title, int position, Function function) {
    return AnimationScaleWidget(
      position: position,
      verticalOffset: 50,
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(left: 19, right: 19, top: 10),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          elevation: 0.5,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.blueAccent.withOpacity(0.3),
                radius: 18,
                child: Center(
                    child: Image.asset(
                  image,
                  height: 18,
                  width: 18,
                )),
              ),
              trailing: Container(
                height: 30,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: AppColors.blueAccent.withOpacity(0.3),
                ),
                child: TextButton(
                  onPressed: () => function(),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
                  ),
                  child: Center(
                    child: Text(
                      'Edit',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blueAccent),
                    ),
                  ),
                ),
              ),
              title: Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _doctorInfoList() {
    return Column(
      children: [
        tile(AppImages.info, 'Basic information', 1, () {
          basicInformation = !basicInformation;
          setState(() {});
        }),
        if (basicInformation)
          Container(
              margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
              child: const Text(
                'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem',
                style: TextStyle(height: 1.5),
              )),
        tile(AppImages.certificates, 'Certificates', 2, () {
          if (basicInformation == true && certificates == false) {
            _scrollController.animateTo(
              120,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          }
          certificates = !certificates;
          setState(() {});
        }),
        if (certificates)
          Container(
            height: 100,
            margin: const EdgeInsets.only(left: 25, right: 25, top: 10),
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    height: 100,
                    width: 150,
                    child: Image.asset(cert[index]),
                  );
                }),
          ),
        tile(AppImages.insurance, 'Insurance companies', 3, () {
          if ((basicInformation == true || certificates == true) &&
              insurance == false) {
            _scrollController.animateTo(
              180,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          }
          insurance = !insurance;
          setState(() {});
        }),
        if (insurance)
          Container(
            margin: const EdgeInsets.only(top: 10, left: 25, right: 25),
            child: Column(
              children: [
                SizedBox(
                  child: const Text(
                    'Romania Company',
                    style: TextStyle(fontSize: 18),
                  ),
                  height: 30,
                  width: MediaQuery.of(context).size.width,
                ),
                SizedBox(
                  child: const Text(
                    'Romania Co',
                    style: TextStyle(fontSize: 18),
                  ),
                  height: 30,
                  width: MediaQuery.of(context).size.width,
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _doctorWorkInfoList() {
    return Column(
      children: [
        tile(AppImages.info, 'Clinic Information', 4, () {}),
        tile(AppImages.conslutaion, 'Consultation ', 5, () {}),
        tile(AppImages.info, 'Assistant name', 6, () {}),
      ],
    );
  }
}
