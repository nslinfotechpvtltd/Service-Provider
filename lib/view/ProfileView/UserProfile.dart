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

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool isLoading = true;
  String _fullName = "Loading..";
  String _email = "Loading..";
  String _number = "Loading..";
  String _location = "Loading..";
  String _postal = "Loading..";

  // void registerUser() async {
  //   isConnectedToInternet().then((internet) {
  //     if (internet != null && internet) {
  //       // showProgress(context, "Please wait.....");
  //       //print('Device Token $deviceTok');
  //       // Map<String, String> parms ={
  //       //   name:_fullNameController.text,
  //       //   email:_emailAddressFieldController.text,
  //       //   password:_passwordFieldController.text,
  //       //   device_type:"ios",
  //       //   deviceToken:"test",
  //       //   mobile:_phoneNumberController.text,
  //       //   gender:"male",
  //       //   //image:
  //       //   postalCode:_postalCodeController.text,
  //       // };
  //       //  print("$parms");
  //
  //       getString(userAuth).then((value) {
  //
  //         getProfile(value).then((response) {
  //
  //           if (response.status) {
  //             print(response.status.toString());
  //             setState(() {
  //               _fullName = response.data.user.name != null
  //                   ? response.data.user.name
  //                   : "No data found";
  //               _email = response.data.user.email != null
  //                   ? response.data.user.email
  //                   : "No data found";
  //               _number = response.data.user.mobile != null
  //                   ? response.data.user.mobile
  //                   : "No data found";
  //               _location = response.data.user.location != null
  //                   ? response.data.user.location
  //                   : "No data found";
  //               _postal = "12345";
  //               isLoading = false;
  //             });
  //             //setString(userAuth, "Bearer " + response.data.token);
  //             // pushAndRemoveUntilFun(context,MainScreen());
  //           } else {
  //
  //             setState(() {
  //               isLoading = false;
  //             });
  //
  //             if (!response.status) {
  //               print(response.error.toString());
  //
  //             }
  //           }
  //         });
  //       });
  //     } else {
  //       //  showDialogBox(context, internetError, pleaseCheckInternet);
  //       // dismissDialog(context);
  //     }
  //   });
  // }
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

          _fullName = getProfileDataModel.data.user.name;
          _email = getProfileDataModel.data.user.email;
          _number = getProfileDataModel.data.user.mobile;
          _location = getProfileDataModel.data.user.location;
          _postal = getProfileDataModel.data.user.postalCode;
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
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(right: 12.0, top: 30.0),
          child: Text(
            "Personal details",
            style: TextStyle(color: Colors.black),
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
        child: Column(
          children: [
            Container(
              color: CColors.missonNormalWhiteColor,
              margin: EdgeInsets.only(top: ScreenConfig.screenHeight * 0.05),
              width: ScreenConfig.screenWidth * 0.70,
              child: Column(
                children: [
                  Row(
                    children: [
                      // circleImageSha(), // Image.asset(ImagePath+"avatarSample.png"),
                      CircleAvatar(
                        backgroundColor: CColors.missonGrey,
                        radius: 47,
                        child: CircleAvatar(
                          backgroundImage: getProfileDataModel == null ||
                                  getProfileDataModel.data == null ||
                                  getProfileDataModel.data.user == null ||
                                  getProfileDataModel.data.user.image == null
                              ? AssetImage(avatar1)
                              : NetworkImage(
                                  "${getProfileDataModel.data.user.image}"),

                          radius: 45,
                        ),
                      ),

                      SizedBox(
                        width: ScreenConfig.screenWidth * 0.06,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _fullName,
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          SizedBox(
                            height: ScreenConfig.screenHeight * 0.01,
                          ),
                          InkWell(
                              onTap: () {
                                NavMe().NavPushLeftToRight(EditProfile());
                              },
                              child: Text(
                                "Edit profile",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: ScreenConfig.screenHeight * 0.03),
                      color: CColors.missonNormalWhiteColor,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, left: ScreenConfig.screenWidth * 0.1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(userIcon),
                                SizedBox(width: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Full Name",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: CColors.missonMediumGrey,
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            ScreenConfig.screenHeight * 0.01),
                                    Text(
                                      "$_fullName",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: ScreenConfig.screenHeight * 0.03),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(messageIcon),
                                SizedBox(width: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Email",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: CColors.missonMediumGrey),
                                    ),
                                    SizedBox(
                                        height:
                                            ScreenConfig.screenHeight * 0.01),
                                    Text(
                                      "$_email",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: ScreenConfig.screenHeight * 0.03),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(PhoneIcon),
                                SizedBox(width: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Contact Number",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: CColors.missonMediumGrey,
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            ScreenConfig.screenHeight * 0.01),
                                    Text(
                                      "$_number",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: ScreenConfig.screenHeight * 0.02),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(compassIcon),
                                SizedBox(width: 20),
                                Container(
                                  width: ScreenConfig.screenWidth * 0.80,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Location",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: CColors.missonMediumGrey,
                                        ),
                                      ),
                                      SizedBox(
                                          height:
                                              ScreenConfig.screenHeight * 0.01),
                                      Text(
                                        "$_location",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: ScreenConfig.screenHeight * 0.03),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(postboxIcon),
                                SizedBox(width: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "postal code",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: CColors.missonMediumGrey,
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            ScreenConfig.screenHeight * 0.02),
                                    Text(
                                      "$_postal",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            // Container(
                            //   child: Text(""),
                            // )
                          ],
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 30, top: 20),
                    //   child: Row(
                    //     children: [
                    //       SvgPicture.asset(""),
                    //       SizedBox(
                    //           width:20
                    //       ),
                    //       Column(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             "Settings",
                    //             style: TextStyle(
                    //                 fontSize: 18,
                    //                 color: Colors.black,
                    //               ),
                    //           ),
                    //           SizedBox(height: ScreenConfig.screenHeight * 0.01),
                    //           Text(
                    //             "Notifications, Change password, Help & support",
                    //             style: TextStyle(
                    //                 fontSize: 14,
                    //                 color: CColors.missonMediumGrey,
                    //             ),
                    //           )
                    //         ],
                    //       )
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
