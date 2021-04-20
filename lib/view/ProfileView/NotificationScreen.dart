import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:misson_tasker/model/ApiCaller.dart';
import 'package:misson_tasker/model/api_models/GetProfileDataModel.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/NavMe.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';
import 'package:misson_tasker/utils/SharedStrings.dart';
import 'package:misson_tasker/utils/StringsPath.dart';
import 'package:misson_tasker/utils/local_data.dart';
import 'package:misson_tasker/view/startup_screens/SplashScreen.dart';

import 'editProfile.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isLoading = true;

  GetProfileDataModel getProfileDataModel;
  String auth;
  bool isLoadingData = true;

  @override
  void initState() {
    // registerUser();
    getString(sharedPref.userToken).then((value) {
      auth = value;

      print("123 $value");
    }).whenComplete(() {
      ApiCaller().getProfileData(auth: auth).then((value) {
        getProfileDataModel = value;
      }).whenComplete(() {
        setState(() {
          isLoadingData = false;
        });
      });
    });
// getString(sharedPref.userToken).then((value) => auth=value).whenComplete(() {
//   print(" QWE$auth");
//
//   ApiCaller().getProfileData(auth: auth).then((value) {
//     getProfileDataModel=value;
//   }).whenComplete(() {
//     setState(() {
//       isLoadingData=false;
//
//       _fullName=getProfileDataModel.data.user.name;
//      _email =getProfileDataModel.data.user.email;
//        _number = getProfileDataModel.data.user.mobile;
//        _location = getProfileDataModel.data.user.location;
//        _postal = "1234";
//     });
//
//   });
// });

    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> listOfNotifications = [
    {
      "name": "Jimmy Warish",
      "message": "Accepted your request for job. ",
      "time": "1hr ago",
      "isNotification": true,
    },
    {
      "name": "Armando A. Morris",
      "message": "Accepted your request for job. ",
      "time": "1hr ago",
      "isNotification": true,
    },
    {
      "name": "Todd Snow",
      "message": "Accepted your request for job. ",
      "time": "1hr ago",
      "isNotification": true,
    }, {
      "name": "Jimmy Warish",
      "message": "Accepted your request for job. ",
      "time": "1hr ago",
      "isNotification": false,
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 12.0, top: 30.0),
        //     child: Align(
        //         alignment: Alignment.topRight, child: SvgPicture.asset("")),
        //   ),
        // ],
        centerTitle: false,
        toolbarHeight: ScreenConfig.screenWidth * 0.2,
        title: Padding(
          padding: const EdgeInsets.only(right: 12.0, top: 30.0),
          child: Padding(
            padding: EdgeInsets.only(bottom: ScreenConfig.screenHeight * 0.03),
            child: Text(
              "Notifications",
              style: TextStyle(color: Colors.black, fontFamily: "Product"),
            ),
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 30.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 24.0,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
          color: CColors.missonNormalWhiteColor,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: listCard(
                    title: "${listOfNotifications.elementAt(index)["name"]}",
                    subtitle: "${listOfNotifications.elementAt(index)["message"]}",
                    time: "${listOfNotifications.elementAt(index)["time"]}",
                    showBadge:listOfNotifications.elementAt(index)["isNotification"]),
              );
            },
            itemCount: listOfNotifications.length,
          )),
    );
  }

  listCard(
      {@required String title,
      @required String subtitle,
      @required String time,
      @required bool showBadge}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Row(
        children: [
          Container(
            child: CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage(avatar1),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "$title",
                        style: TextStyle(
                            fontFamily: "Product",
                            fontSize: ScreenConfig.fontSizelarge),
                      ),
                      Spacer(),
                      Visibility(visible: showBadge, child: SvgPicture.asset(dotLogo))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(flex:8,
                        child: Text(
                          "$subtitle",
                          style: TextStyle(
                              fontFamily: "Product",
                              fontSize: ScreenConfig.fontSizelarge,
                              color: CColors.missonMediumGrey),
                        ),
                      ),

                     Expanded(flex: 2,child:  Text("$time"))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
