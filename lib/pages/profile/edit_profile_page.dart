import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:piwotapp/widgets/app_button.dart';
import 'package:piwotapp/widgets/app_textfield.dart';
import 'package:piwotapp/widgets/gradient_border_textfield.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../constants/images.dart';
import '../../widgets/app_themes.dart';

class EditProfilPage extends StatefulWidget {
  const EditProfilPage({super.key});

  @override
  State<EditProfilPage> createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  final picker = ImagePicker();
  File? _image;
  bool tapCamera = false;
  bool tapGallery = false;

  var items = [
    'Industry 1',
    'Industry 2',
    'Industry 3',
    'Industry 4',
    'Industry 5',
  ];

  var gender = [
    'Male','Female'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.primaryColor,
        title: Padding(
          padding: const EdgeInsets.only(right: 60),
          child: Center(child: SvgPicture.asset(Images.logo, height: 40,width: 147)),
        ),
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios,size: 20,color: AppColor.white,)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,width: Get.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColor.primaryColor, AppColor.red],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(170),bottomLeft: Radius.circular(170))
              ),
              child: Transform.translate(
                offset: Offset(100, 120),
                child: Stack(
                  children: [
                    Container(
                      width: 191,height: 195,
                      decoration: BoxDecoration(
                          color: AppColor.white,
                          border: Border.all(color: AppColor.white),
                          borderRadius: BorderRadius.all(Radius.circular(100))
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(200),
                          child: Image.asset(Images.profileImg,height: 200,width: 200,fit: BoxFit.fill,)),
                    ),
                    Positioned(
                      bottom: 50,
                      left: 120,
                      child: Container(
                        height: 54,width: 54,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppColor.primaryColor, AppColor.red],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(50))
                        ),
                        child: Icon(Icons.camera_alt_outlined,color: AppColor.white,size: 30,),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 80,),
            AppTextField(hintText: "Type your Name",controller: nameController,labelText:"Name"),
            SizedBox(height: 20,),
            AppTextField(hintText: "Type your Email",controller: emailController,labelText:"Email"),
            SizedBox(height: 20,),
            AppTextField(
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime.now(),
                      builder: (BuildContext? context, Widget? child){
                        return Theme(
                            data: ThemeData.light().copyWith(
                              primaryColor: AppColor.primaryColor,
                              primaryColorLight: AppColor.primaryColor,
                              colorScheme: ColorScheme.light(primary: AppColor.primaryColor),
                              buttonTheme: ButtonThemeData(
                                  textTheme: ButtonTextTheme.primary
                              ),
                            ),
                            child: child!);
                      }
                  );
                  if (pickedDate != null) {
                    print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000

                    String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                    print(formattedDate); //formatted date output using intl package =>  2021-03-16
                    setState(() {

                      dobController.text = formattedDate; //set output date to TextField value.
                    });
                  } else {}
                },
                hintText: "Type your DOB",controller: dobController,labelText:"DOB"),
            SizedBox(height: 20,),
            Row(
              children: [
                Flexible(
                  flex: 1,
                    child: AppTextField(hintText: "Location",controller: emailController,labelText:"Location")),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: DropdownButtonFormField<String>(
                      items: gender.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {},
                      dropdownColor: AppColor.white,
                      iconSize: 30,
                      decoration: InputDecoration(
                        hintText: "Gender",
                        labelText: "Gender",
                        labelStyle:  TextStyle(color: AppColor.primaryColor,fontFamily: appFontFamily,fontWeight:FontWeight.w400,fontSize: 14),
                        hintStyle: TextStyle(color: Colors.black,fontFamily: appFontFamily,fontWeight:FontWeight.w400,fontSize: 14),
                        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        focusedBorder: GradientOutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          width: 2,
                          gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red]), // Remove standard borders
                        ),
                        enabledBorder: GradientOutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          width: 2,
                          gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red]), // Remove standard borders
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.red, width: 2.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.red, width: 2.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            AppTextField(hintText: "Type your Company Name",controller: companyController,labelText:"Company Name"),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DropdownButtonFormField<String>(
                items: items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {},
                dropdownColor: AppColor.white,
                iconSize: 30,
                decoration: InputDecoration(
                  hintText: "Select your Industry",
                  labelText: "Industry",
                  labelStyle:  TextStyle(color: AppColor.primaryColor,fontFamily: appFontFamily,fontWeight:FontWeight.w400,fontSize: 14),
                  hintStyle: TextStyle(color: Colors.black,fontFamily: appFontFamily,fontWeight:FontWeight.w400,fontSize: 14),
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  focusedBorder: GradientOutlineInputBorder(
                    width: 2,
                    borderRadius: BorderRadius.circular(10.0), gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red]),
                  ),
                  enabledBorder: GradientOutlineInputBorder(
                    width: 2,
                    borderRadius: BorderRadius.circular(10.0),gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red])
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            AppTextField(hintText: "Type your Designation",controller: designationController,labelText:"Designation"),
            SizedBox(height: 20,),
            AppButton(title: "Update", onTap: (){}),
            SizedBox(height: 20,),
          ],
        ),
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
                margin: EdgeInsets.only(top: 1),
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
                            Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.camera_alt,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
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
                            Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.upload,color: Colors.black),

                              SizedBox(
                                width: 10,
                              ),
                              const Text(
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
}



class GradientDropdownFormField extends StatelessWidget {
  final List<String> items;

  GradientDropdownFormField({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple], // Gradient colors
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(2), // Padding for the gradient border thickness
              decoration: BoxDecoration(
                color: Colors.white, // Background color for Dropdown
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonFormField<String>(
                items: items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {},
                dropdownColor: Colors.white,
                iconSize: 30,
                decoration: InputDecoration(
                  hintText: "Select your Industry",
                  labelText: "Industry",
                  labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 12),
                  hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none, // Border is handled by the container
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}