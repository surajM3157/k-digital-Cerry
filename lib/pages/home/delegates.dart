import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:get/get.dart';
import '../../constants/font_family.dart';
import '../../constants/images.dart';
import '../../route/route_names.dart';

class Delegates extends StatefulWidget {
   Delegates({super.key,required this.tabController});

  TabController tabController;

  @override
  State<Delegates> createState() => _DelegatesState();
}

class _DelegatesState extends State<Delegates> {
  
  
  List<ChatModel> delegates = [
    ChatModel(name: "William John", message: "Hi", profile: Images.profile1,isInvited: true),
    ChatModel(name: "Ethan Miller", message: "Hello", profile: Images.profile2,isInvited: false),
    ChatModel(name: "Mia Collins", message: "Hi", profile: Images.profile3,isInvited: false),
    ChatModel(name: "James parke", message: "Hi", profile: Images.profile4,isInvited: true),
    ChatModel(name: "Lucas anderson", message: "Good Morning", profile: Images.profile5,isInvited: true),
    ChatModel(name: "William John", message: "Hi", profile: Images.profile1,isInvited: true),
    ChatModel(name: "Ethan Miller", message: "Hello", profile: Images.profile2,isInvited: false),
    ChatModel(name: "Mia Collins", message: "Hi", profile: Images.profile3,isInvited: true),
    ChatModel(name: "James parke", message: "Hi", profile: Images.profile4,isInvited: false),
    ChatModel(name: "Lucas anderson", message: "Good Morning", profile: Images.profile5,isInvited: false),
  ];
  
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: widget.tabController,
        children: [
          ListView.separated(itemBuilder: (context,index){
            return Padding(
              padding: index ==0? EdgeInsets.only(top: 20):index ==delegates.length-1?EdgeInsets.only(bottom: 20):EdgeInsets.zero,
              child: inviteDelegateList(delegates[index]),
            );
          }, separatorBuilder: (context,index){
            return SizedBox(height: 20,);
          }, itemCount: delegates.length),
          ListView.separated(itemBuilder: (context,index){
            return Padding(
              padding: index ==0? EdgeInsets.only(top: 20):index ==delegates.length-1?EdgeInsets.only(bottom: 20):EdgeInsets.zero,
              child: chatListItem(name: delegates[index].name, message: delegates[index].message, profile: delegates[index].profile),
            );
          }, separatorBuilder: (context, index){
            return SizedBox(height: 20,);
          }, itemCount: delegates.length),
          ListView.separated(itemBuilder: (context,index){
            return Padding(
              padding: index ==0? EdgeInsets.only(top: 20):index ==delegates.length-1?EdgeInsets.only(bottom: 20):EdgeInsets.zero,
              child: requestDelegateList(delegates[index]),
            );
          }, separatorBuilder: (context,index){
            return SizedBox(height: 20,);
          }, itemCount: delegates.length),

    ]);
  }


  Widget requestDelegateList(ChatModel chatModel){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9),
      child: Row(
        children: [
          Container(
              height: 70,
              width: 70,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(chatModel.profile,fit: BoxFit.fill,))),
          SizedBox(width: 10,),
          Expanded(
            child: Container(
              // width: Get.width/1.35,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              decoration: BoxDecoration(
                  color: AppColor.secondaryColor,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(chatModel.name,
                            overflow:TextOverflow.ellipsis,
                            style: TextStyle(
                            fontFamily: appFontFamilyHeadings,fontWeight: FontWeight.w500,
                            fontSize: 15,color: AppColor.primaryColor
                        )),
                        SizedBox(height: 5,),
                        Text("10 mins ago",style: TextStyle(
                            fontFamily: appFontFamilyBody,fontWeight: FontWeight.w400,
                            fontSize: 10,color: AppColor.black
                        )),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 7,vertical: 5),
                        decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColor.primaryColor)
                        ),
                        child: Text("Accept",style: TextStyle(fontSize: 15,fontFamily: appFontFamilyHeadings,fontWeight: FontWeight.w500,color:AppColor.white),),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 7,vertical: 5),
                        decoration: BoxDecoration(
                            color: AppColor.secondaryColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColor.red)
                        ),
                        child: Text("Reject",style: TextStyle(fontSize: 15,fontFamily: appFontFamilyHeadings,fontWeight: FontWeight.w500,color:AppColor.red),),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget inviteDelegateList(ChatModel chatModel){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Container(
              height: 70,
              width: 70,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(chatModel.profile,fit: BoxFit.fill,))),
          SizedBox(width: 20,),
          Expanded(
            child: Container(
              // width: Get.width/1.5,
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
              decoration: BoxDecoration(
                  color: AppColor.secondaryColor,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(chatModel.name,style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                        fontFamily: appFontFamilyHeadings,fontWeight: FontWeight.w500,
                        fontSize: 15,color: AppColor.black
                    )),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    decoration: BoxDecoration(
                        color: chatModel.isInvited?AppColor.primaryColor:AppColor.secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColor.primaryColor)
                    ),
                    child: Text(chatModel.isInvited?"Invited":"Invite",style: TextStyle(fontSize: 15,fontFamily: appFontFamilyHeadings,fontWeight: FontWeight.w500,color:chatModel.isInvited?AppColor.white: AppColor.black),),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget chatListItem({required String name, required String message, required String profile}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Container(
              height: 70,
              width: 70,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(profile,fit: BoxFit.fill,))),
          SizedBox(width: 20,),
          GestureDetector(
            onTap: (){
              Get.toNamed(Routes.chat);
            },
            child: Container(
              width: Get.width/1.5,
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                gradient:  LinearGradient(
                  colors: [AppColor.primaryColor, AppColor.red],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Container(
                width: Get.width/1.5,
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,style: TextStyle(
                        fontFamily: appFontFamilyHeadings,fontWeight: FontWeight.w600,
                        fontSize: 14,color: AppColor.FF161616
                    )),
                    SizedBox(height: 5,),
                    Text(message,style: TextStyle(
                        fontFamily: appFontFamilyBody,fontWeight: FontWeight.w400,
                        fontSize: 14,color: AppColor.FF161616
                    )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ChatModel{
  ChatModel({required this.name, required this.message, required this.profile,required this.isInvited});
  String name;
  String message;
  String profile;
  bool isInvited;
}