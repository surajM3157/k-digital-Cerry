import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:piwotapp/constants/api_urls.dart';
import 'package:piwotapp/responses/guest_details_response.dart';
import 'package:piwotapp/widgets/app_button.dart';
import 'package:piwotapp/widgets/app_textfield.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../constants/images.dart';
import '../../repository/api_repo.dart';
import '../../widgets/app_themes.dart';

class EditProfilPage extends StatefulWidget {
  const EditProfilPage({super.key});

  @override
  State<EditProfilPage> createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streamController = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  final picker = ImagePicker();
  File? _image;
  bool tapCamera = false;
  bool tapGallery = false;
  String? _gender = "Male";
  String? _isAlumni = "No";
  String country = "";
  String iitName = "";
  String batch = "";
  String stream = "";
  String? profileImage;

  String selectedPrefix ="Mr";
  String selectedCode = "+91";
  bool isLoading = true;

  var countryItems = [
    'INDIA',
    'USA',
    'JAPAN',
    'SOUTH KOREA',
    'NEPAL',
  ];

  var iitItems =[
    "IIT-DELHI","IIT-BOMBAY", "IIT-CHENNAI", "IIT-KHARAGPUR", "IIT-GUWAHATI"
  ];

  var iitBatchItems =[
    "1970","1971","1972","1973",
    "1974","1975","1976","1977",
    "1978","1979","1980","1981",
    "1982","1983","1984","1985",
    "1986","1987","1988","1989","1990",
    "1991","1992","1993","1994","1995",
    "1996","1997","1998","1999","2000",
    "2001","2002","2003","2004","2005","2006"
  ];

  var genderList = [
    'Male','Female'
  ];

  GuestDetailsData? guestDetails;
  bool isConnected = true;


  fetchGuestDetails() async
  {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;
      setState(() {

      });
    }else {
      isConnected = true;
    Future.delayed(Duration.zero, () {
      showLoader(context);
    });

      var response = await ApiRepo().getGuestDetailsResponse();

      if( response.data != null)
      {
        guestDetails = response.data;
        firstNameController.text = AppThemes.capitalizeFirst(guestDetails?.firstName??"");
        lastNameController.text = AppThemes.capitalizeFirst(guestDetails?.lastName??"");
        emailController.text = guestDetails?.emailId??"";
        phoneNumberController.text = guestDetails?.mobileNumber.toString()??"";
        companyController.text = guestDetails?.companyName ??'';
        designationController.text = guestDetails?.designation ??"";
        cityController.text = guestDetails?.city??"";
        streamController.text = guestDetails?.stream??"";
        country = (countryItems.contains(guestDetails?.country) ? guestDetails?.country : null)??"";
        _gender = guestDetails?.gender??"";
        iitName = (iitItems.contains(guestDetails?.iitName) ? guestDetails?.iitName : null)??"";

        batch = (iitBatchItems.contains(guestDetails?.batch.toString()) ? guestDetails?.batch.toString() : null)??"";

        _isAlumni = guestDetails?.alumniOfIit == true?"Yes":"No";
        profileImage = guestDetails?.guestProfileImage ??"";
        isLoading = false;

      }

      setState(() {

      });}

    }

  @override
  void initState() {
    fetchGuestDetails();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        isConnected = false;
      } else {
        // Handle case when internet connection is available
        isConnected = true;
        fetchGuestDetails();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: isConnected?SingleChildScrollView(
        child: Stack(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 250,width: Get.width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColor.primaryColor, AppColor.red],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(170),bottomLeft: Radius.circular(170))
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 50,),
                        Center(child: SvgPicture.asset(Images.logo, height: 40,width: 147)),

                      ],
                    ),
                  ),
                  const SizedBox(height: 80,),
                  // AppTextField(hintText: "Type your Name*",controller: nameController,labelText:"Name*",prefixIcon: Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  //     child: DropdownButtonHideUnderline(
                  //       child: DropdownButton<String>(
                  //         value: selectedPrefix,
                  //         items: ['Mr', 'Ms', 'Mrs'].map((String prefix) {
                  //           return DropdownMenuItem<String>(
                  //             value: prefix,
                  //             child: Text(prefix,style: TextStyle(color: AppColor.primaryColor,fontFamily: appFontFamily,fontWeight:FontWeight.w400,fontSize: 14),),
                  //           );
                  //         }).toList(),
                  //         onChanged: (String? newValue) {
                  //           setState(() {
                  //             selectedPrefix = newValue!;
                  //             if(selectedPrefix == "Ms"||selectedPrefix == "Mrs"){
                  //               _gender = "Female";
                  //             }else{
                  //               _gender = "Male";
                  //             }
                  //           });
                  //         },
                  //       ),
                  //     )), autovalidateMode: AutovalidateMode.onUserInteraction,
                  //   inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[a-zA-Z\\s]")), ],
                  //   validator: (value)
                  //   {
                  //     if (value.toString() == "")
                  //     {
                  //       return 'Enter a valid name.';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  Row(
                    children: [
                      Expanded(
                        child: AppTextField(hintText: "Enter First Name*",controller: firstNameController,labelText:"First Name*",autovalidateMode: AutovalidateMode.onUserInteraction,
                          inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[a-zA-Z\\s]")), ],
                          validator: (value)
                          {
                            if (value.toString() == "")
                            {
                              return 'Enter valid first name.';
                            }
                            return null;
                          },
                        ),
                      ),
                      Expanded(
                        child: AppTextField(hintText: "Enter Last Name*",controller: lastNameController,labelText:"Last Name*",autovalidateMode: AutovalidateMode.onUserInteraction,
                          inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[a-zA-Z\\s]")), ],
                          validator: (value)
                          {
                            if (value.toString() == "")
                            {
                              return 'Enter valid last name.';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25,),
                  AppTextField(hintText: "Type your Email*",controller: emailController,labelText:"Email*",keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value)
                    {
                      if (value.toString() == ""||!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value.toString()))
                      {
                        return 'Enter a valid email.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25,),
                  AppTextField(hintText: "Type Phone number*",controller: phoneNumberController,labelText:"Phone Number*",keyboardType: TextInputType.phone,inputFormatters:[
                    LengthLimitingTextInputFormatter(10),
                  ],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value)
                    {
                      if (value.toString() == ""||value.toString().length!=10)
                      {
                        return 'Enter a valid phone number.';
                      }
                      return null;
                    },
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedCode,
                          items: ['+91', '+1', '+3'].map((String prefix) {
                            return DropdownMenuItem<String>(
                              value: prefix,
                              child: Text(prefix,style: TextStyle(color: AppColor.primaryColor,fontFamily: appFontFamily,fontWeight:FontWeight.w400,fontSize: 14),),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCode = newValue!;
                            });
                          },
                        ),
                      )),),
                  const SizedBox(height: 25,),
                  genderWidget(),
                  // const SizedBox(height: 25,),
                  // AppTextField(
                  //     readOnly: true,
                  //     suffixIcon: Icon(Icons.date_range,color: AppColor.primaryColor,),
                  //     onTap: () async {
                  //       DateTime? pickedDate = await showDatePicker(
                  //           context: context,
                  //           initialDate: DateTime.now(),
                  //           firstDate: DateTime(1900),
                  //           //DateTime.now() - not to allow to choose before today.
                  //           lastDate: DateTime.now(),
                  //           builder: (BuildContext? context, Widget? child){
                  //             return Theme(
                  //                 data: ThemeData.light().copyWith(
                  //                   primaryColor: AppColor.primaryColor,
                  //                   primaryColorLight: AppColor.primaryColor,
                  //                   colorScheme: ColorScheme.light(primary: AppColor.primaryColor),
                  //                   buttonTheme: const ButtonThemeData(
                  //                       textTheme: ButtonTextTheme.primary
                  //                   ),
                  //                 ),
                  //                 child: child!);
                  //           }
                  //       );
                  //       if (pickedDate != null) {
                  //         print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  //
                  //         String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                  //         print(formattedDate); //formatted date output using intl package =>  2021-03-16
                  //         setState(() {
                  //
                  //           dobController.text = formattedDate; //set output date to TextField value.
                  //         });
                  //       } else {}
                  //     },
                  //     hintText: "Type your DOB",controller: dobController,labelText:"DOB"),
                  const SizedBox(height: 25,),
                  AppTextField(hintText: "Type your Designation*",controller: designationController,labelText:"Designation*",inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[a-zA-Z\\s]")), ],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value)
                    {
                      if (value.toString() == "")
                      {
                        return 'Enter a valid designation.';
                      }
                      return null;
                    },),
                  const SizedBox(height: 25,),
                  AppTextField(hintText: "Type your Company Name*",controller: companyController,labelText:"Company Name*", autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value)
                    {
                      if (value.toString() == "")
                      {
                        return 'Enter a valid company name.';
                      }
                      return null;
                    },),
                  const SizedBox(height: 25,),
                  AppTextField(hintText: "Type your city*",controller: cityController,labelText:"Town/City*", autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value)
                    {
                      if (value.toString() == "")
                      {
                        return 'Enter a valid city.';
                      }
                      return null;
                    },),
                  const SizedBox(height: 25,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: isLoading == true?SizedBox.shrink():DropdownButtonFormField<String>(
                      value: country==""?null:country,
                      items: countryItems.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        country = value!;
                      },
                      dropdownColor: AppColor.white,
                      iconSize: 30,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value)
                      {
                        if (value.toString() == ""||value == null)
                        {
                          return 'Select a valid country.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Select your Country*",
                        labelText: "Country/Region*",
                        labelStyle:  TextStyle(color: AppColor.primaryColor,fontFamily: appFontFamily,fontWeight:FontWeight.w400,fontSize: 14),
                        hintStyle: const TextStyle(color: Colors.black,fontFamily: appFontFamily,fontWeight:FontWeight.w400,fontSize: 14),
                        contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        focusedBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: AppColor.black.withOpacity(0.12))
                        ),
                        enabledBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: AppColor.black.withOpacity(0.12))
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.red, width: 2.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.red, width: 2.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25,),
                  isAlumniWidget(),
                  _isAlumni == "Yes"?const SizedBox(height: 25,):const SizedBox.shrink(),
                  _isAlumni == "Yes"?Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text("If Yes, Please Select Your IIT: ",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,color: AppColor.primaryColor,fontSize: 14),),
                  ):const SizedBox.shrink(),
                  _isAlumni == "Yes"?const SizedBox(height: 10,):const SizedBox.shrink(),
                  _isAlumni == "Yes"?isLoading == true?SizedBox.shrink():Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: DropdownButtonFormField<String>(
                      value: iitName==""?null:iitName,
                      items: iitItems.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator:(_isAlumni=="Yes")? (value)
                      {
                        if (value.toString() == ""||value == null)
                        {
                          return 'Select a valid IIT.';
                        }
                        return null;
                      }:null,
                      onChanged: (value) {
                        iitName = value!;
                      },
                      dropdownColor: AppColor.white,
                      iconSize: 30,
                      decoration: InputDecoration(
                        hintText: "Select your IIT*",
                        labelText: "IIT*",
                        labelStyle:  TextStyle(color: AppColor.primaryColor,fontFamily: appFontFamily,fontWeight:FontWeight.w400,fontSize: 14),
                        hintStyle: const TextStyle(color: Colors.black,fontFamily: appFontFamily,fontWeight:FontWeight.w400,fontSize: 14),
                        contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        focusedBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: AppColor.black.withOpacity(0.12))
                        ),
                        enabledBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: AppColor.black.withOpacity(0.12))
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.red, width: 2.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.red, width: 2.0),
                        ),
                      ),
                    ),
                  ):const SizedBox.shrink(),
                  _isAlumni == "Yes"?const SizedBox(height: 25,):const SizedBox.shrink(),
                  _isAlumni == "Yes"?isLoading == true?SizedBox.shrink(): Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: DropdownButtonFormField<String>(
                      value: batch==""?null:batch,
                      items: iitBatchItems.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        batch = value!;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (_isAlumni=="Yes")?(value)
                      {

                        if (value.toString() == ""||value == null)
                        {
                          return 'Select a valid IIT Batch.';
                        }
                        return null;
                      }:null,
                      dropdownColor: AppColor.white,
                      iconSize: 30,
                      decoration: InputDecoration(
                        hintText: "Select your batch*",
                        labelText: "Batch*",
                        labelStyle:  TextStyle(color: AppColor.primaryColor,fontFamily: appFontFamily,fontWeight:FontWeight.w400,fontSize: 14),
                        hintStyle: const TextStyle(color: Colors.black,fontFamily: appFontFamily,fontWeight:FontWeight.w400,fontSize: 14),
                        contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        focusedBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: AppColor.black.withOpacity(0.12))
                        ),
                        enabledBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: AppColor.black.withOpacity(0.12))
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.red, width: 2.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.red, width: 2.0),
                        ),
                      ),
                    ),
                  ):const SizedBox.shrink(),
                  _isAlumni == "Yes"?const SizedBox(height: 25,):const SizedBox.shrink(),
                  _isAlumni == "Yes"? AppTextField(hintText: "Type your Stream",controller: streamController,labelText:"Stream",):const SizedBox.shrink(),
                  const SizedBox(height: 30,),
                  AppButton(title: "Update", onTap: (){
                    if(_formKey.currentState!.validate()){
                      print("form validated");
                      profileUpdate();
                    }
                  }),
                  const SizedBox(height: 30,),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                pickImageFromCameraAndGallery();
              },
              child: Container(
                width: 188,height: 188,
                margin: const EdgeInsets.only(left: 100,top: 120),
                padding: _image != null||profileImage!=""?null:const EdgeInsets.all(50),
                decoration: BoxDecoration(
                    color: AppColor.white,
                    border: Border.all(color: AppColor.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(100))
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: _image != null?Image.file(_image!, fit: BoxFit.fill,):profileImage!=""?Image.network(ApiUrls.imageUrl + (profileImage??""),fit: BoxFit.fill,):Image.asset(Images.profileDefault,height: 64,width: 64,fit: BoxFit.cover,)),
              ),
            ),
            GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20,top: 60),
                child: Icon(Icons.arrow_back_ios,color: AppColor.white,),
              ),
            ),
            Positioned(
              left: 240,
              top: 250,
              child: Container(
                height: 54,width: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red])
                  ),
                  child: Icon(Icons.camera_alt_outlined,color: AppColor.white,size: 30,)),
            )
          ],
        ),
      ):const Center(child: Text("OOPS! NO INTERNET.",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600,fontFamily: appFontFamily,fontSize: 20),)),
    );
  }

  Widget isAlumniWidget(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Are you an alumnis of any IIT?*",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,color: AppColor.primaryColor,fontSize: 14),),
          Row(
            children: [
              Row(
                children: [
                  Radio<String>(
                    value: 'Yes',
                    activeColor: AppColor.primaryColor,
                    groupValue: _isAlumni,
                    onChanged: (String? value) {
                      setState(() {
                        _isAlumni = value;
                      });
                    },
                  ),
                  Text('Yes',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: appFontFamily,color: AppColor.black),),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'No',
                    activeColor: AppColor.primaryColor,
                    groupValue: _isAlumni,
                    onChanged: (String? value) {
                      setState(() {
                        _isAlumni = value;
                      });
                    },
                  ),
                  Text('No',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: appFontFamily,color: AppColor.black),),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget genderWidget(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Gender",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,color: AppColor.primaryColor,fontSize: 14),),
         Row(
           children: [
             Row(
               children: [
                 Radio<String>(
                   value: 'Male',
                   activeColor: AppColor.primaryColor,
                   groupValue: _gender,
                   onChanged: (String? value) {
                     setState(() {
                       _gender = value;
                     });
                   },
                 ),
                 Text('Male',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: appFontFamily,color: AppColor.black),),
               ],
             ),
             Row(
               children: [
                 Radio<String>(
                   value: 'Female',
                   activeColor: AppColor.primaryColor,
                   groupValue: _gender,
                   onChanged: (String? value) {
                     setState(() {
                       _gender = value;
                     });
                   },
                 ),
                 Text('Female',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: appFontFamily,color: AppColor.black),),
               ],
             ),
             Row(
               children: [
                 Radio<String>(
                   value: 'Other',
                   activeColor: AppColor.primaryColor,
                   groupValue: _gender,
                   onChanged: (String? value) {
                     setState(() {
                       _gender = value;
                     });
                   },
                 ),
                 Text('Other',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: appFontFamily,color: AppColor.black),),
               ],
             ),
           ],
         )
        ],
      ),
    );
  }
  
  pickImageFromCameraAndGallery() {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setstate) {
              return Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 1),
                height: 80,
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Center(
                        child: GestureDetector(
                          onTap: () async {
                            await _imgFromCamera();
                            Get.back();
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Camera",
                                style: TextStyle(color: Colors.black, fontSize: 15),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: GestureDetector(
                          onTap: () async {
                            await _imgFromGallery();
                            Get.back();
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.upload,color: Colors.black),

                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Upload",
                                style: TextStyle(color: Colors.black, fontSize: 15),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  Future _imgFromGallery() async {
    //_image.clear();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    if (pickedFile != null) {
      var _file = File(pickedFile.path);
      _image = _file;
      tapGallery = true;
    } else {
      print('No image selected.');
    }
    setState(() {});
  }

  Future _imgFromCamera() async {
    //_image.clear();
    final pickedFile =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 25);

    if (pickedFile != null) {
      var _file = File(pickedFile.path);
      _image = _file;
      tapCamera = true;
    } else {
      print('No image selected.');
    }
    setState(() {});
  }

  void profileUpdate()async
  {

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;
      setState(() {
      });
      EasyLoading.showToast("No Internet",
          dismissOnTap: true,
          duration: const Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.center);
    }else {
      isConnected = true;
    Map<String, dynamic> params = new Map<String, dynamic>();
    params["last_name"] = lastNameController.text;
    params["first_name"] = firstNameController.text;
    params["email"] = emailController.text.trim();
    params["mobile_no"] = phoneNumberController.text.trim();
    params["company_name"] = companyController.text.trim();
    params["designation"] = designationController.text.trim();
    params["city"] = cityController.text.trim();
    params["country"] = country.trim();
    params["alumni_of_iit"] = _isAlumni=="Yes"?true:false;
    if(_isAlumni == "Yes"){
      params["iit_name"] = iitName;
      params["batch"] = batch;
      params["stream"] = streamController.text.trim();
    }
    if(_gender != null){
      params["gender"] = _gender!;
    }



    if(_image != null) {
      ApiRepo().updateProfile(params, image: _image);
    } else {
      ApiRepo().updateProfile(params);
    }
  }}
}

