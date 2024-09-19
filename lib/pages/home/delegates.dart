import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:get/get.dart';
import '../../constants/font_family.dart';
import '../../constants/images.dart';
import '../../route/route_names.dart';
import '../../widgets/gradient_text.dart';

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
            return SizedBox.shrink();
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
            return SizedBox();
          }, itemCount: delegates.length),

    ]);
  }


  Widget requestDelegateList(ChatModel chatModel){
    return Container(
      height: 182,
      width: Get.width,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColor.white,
          border: Border.all(color: AppColor.black.withOpacity(0.12)),
          borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  height: 70,
                  width: 70,
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: AppColor.black,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(chatModel.profile,fit: BoxFit.cover,))),
              SizedBox(width: 10,),
              Flexible(
                child : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(chatModel.name,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,fontFamily: appFontFamily,color: AppColor.primaryColor),),
                    SizedBox(height: 10,),
                    Text("Co-Founder | Globally Grow Wealth Ventures",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,fontFamily: appFontFamily,color: AppColor.FF161616,overflow: TextOverflow.ellipsis, // Prevents overflow by showing ellipsis
                    ),maxLines: 2, // Adjust maxLines as needed
                      softWrap: true,),
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                decoration: BoxDecoration(
                    color: AppColor.FFE7E7E7,
                    borderRadius: BorderRadius.all(Radius.circular(9))
                ),
                child: Center(child: Text("Fintech",style: TextStyle(fontFamily: appFontFamily,fontSize: 10,fontWeight: FontWeight.w400,color: AppColor.FF161616),)),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                decoration: BoxDecoration(
                    color: AppColor.FFE7E7E7,
                    borderRadius: BorderRadius.all(Radius.circular(9))
                ),
                child: Center(child: Text("Leading",style: TextStyle(fontFamily: appFontFamily,fontSize: 10,fontWeight: FontWeight.w400,color: AppColor.FF161616),)),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                decoration: BoxDecoration(
                    color: AppColor.FFE7E7E7,
                    borderRadius: BorderRadius.all(Radius.circular(9))
                ),
                child: Center(child: Text("Venture Capital/ Funding",style: TextStyle(fontFamily: appFontFamily,fontSize: 10,fontWeight: FontWeight.w400,color: AppColor.FF161616),)),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Container(
                width: 100,height: 35,
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  gradient:LinearGradient(
                    colors: [AppColor.primaryColor, AppColor.red],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(child: Text("Accept",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: AppColor.white,fontFamily: appFontFamily),)),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                  width: 100,height: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: AppColor.white,
                    border: Border.all(color: AppColor.red)
                  ),
                  child: Center(child: Text("Reject",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: AppColor.red,fontFamily: appFontFamily,),))),
            ],
          )
        ],
      ),
    );
  }



  Widget inviteDelegateList(ChatModel chatModel){
    return Container(
      height: 182,
      width: Get.width,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.white,
          border: Border.all(color: AppColor.black.withOpacity(0.12)),
          borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  height: 70,
                  width: 70,
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: AppColor.black,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(chatModel.profile,fit: BoxFit.cover,))),
              SizedBox(width: 10,),
              Flexible(
                child : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(chatModel.name,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,fontFamily: appFontFamily,color: AppColor.primaryColor),),
                    SizedBox(height: 10,),
                    Text("Co-Founder | Globally Grow Wealth Ventures",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,fontFamily: appFontFamily,color: AppColor.FF161616,overflow: TextOverflow.ellipsis, // Prevents overflow by showing ellipsis
                      ),maxLines: 2, // Adjust maxLines as needed
                      softWrap: true,),
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                decoration: BoxDecoration(
                  color: AppColor.FFE7E7E7,
                  borderRadius: BorderRadius.all(Radius.circular(9))
                ),
                child: Center(child: Text("Fintech",style: TextStyle(fontFamily: appFontFamily,fontSize: 10,fontWeight: FontWeight.w400,color: AppColor.FF161616),)),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                decoration: BoxDecoration(
                  color: AppColor.FFE7E7E7,
                  borderRadius: BorderRadius.all(Radius.circular(9))
                ),
                child: Center(child: Text("Leading",style: TextStyle(fontFamily: appFontFamily,fontSize: 10,fontWeight: FontWeight.w400,color: AppColor.FF161616),)),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                decoration: BoxDecoration(
                  color: AppColor.FFE7E7E7,
                  borderRadius: BorderRadius.all(Radius.circular(9))
                ),
                child: Center(child: Text("Venture Capital/ Funding",style: TextStyle(fontFamily: appFontFamily,fontSize: 10,fontWeight: FontWeight.w400,color: AppColor.FF161616),)),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Container(
                width: 100,height: 35,
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  gradient:LinearGradient(
                    colors: [AppColor.primaryColor, AppColor.red],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(child: Text("Connect",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: AppColor.white,fontFamily: appFontFamily),)),
              ),
              Container(
                width: 100,height: 35,
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                  gradient:LinearGradient(
                    colors: [AppColor.primaryColor, AppColor.red],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Container(
                    width: 100,height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: AppColor.white
                    ),
                    child: Center(child: Text("Send Note",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: AppColor.FF161616,fontFamily: appFontFamily,),))),
              ),
            ],
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
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              decoration: BoxDecoration(
                  color: AppColor.white,
                  border: Border.all(color: AppColor.black.withOpacity(0.12)),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,style: TextStyle(
                      fontFamily: appFontFamily,fontWeight: FontWeight.w600,
                      fontSize: 14,color: AppColor.FF161616
                  )),
                  SizedBox(height: 5,),
                  Text(message,style: TextStyle(
                      fontFamily: appFontFamily,fontWeight: FontWeight.w400,
                      fontSize: 14,color: AppColor.FF161616
                  )),
                ],
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