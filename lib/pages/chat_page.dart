import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:piwotapp/constants/font_family.dart';
import 'package:piwotapp/widgets/app_textfield.dart';
import 'package:piwotapp/widgets/chat_bubble.dart';

import '../constants/images.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  
  List<Widget> messages = [
    ChatBubble(isMe: true, message: "Good Morning", timeStamp: "1:20pm"),
    ChatBubble(isMe: false, message: "Not much, just chilling. How about you?", timeStamp: "1:20pm"),
    ChatBubble(isMe: true, message: "Ok", timeStamp: "1:20pm"),
  ];
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,

        backgroundColor: AppColor.secondaryColor,
        titleSpacing: -15,
        centerTitle: false,
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios,size: 20,color: AppColor.primaryColor,)),
        title: Row(
          children: [
            Container(
              height: 45,
                width: 45,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                    child: Image.asset(Images.profile1,fit: BoxFit.fill,))),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("William John",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,fontFamily: appFontFamilyHeadings,color: AppColor.primaryColor),),
                Text("Last Seen 2:10 pm ago",style: TextStyle(fontFamily: appFontFamilyBody,fontSize: 10,fontWeight: FontWeight.w400,color: AppColor.black),)
              ],
            )
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
         Expanded(
           child: ListView.builder(
             controller: scrollController,
             itemCount: messages.length,
               itemBuilder: (context,index){
             return messages[index];
           }),
         ),

          Row(
            children: [
              Container(
                width: Get.width - 60,
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: TextFormField(
                  controller: messageController,
                  cursorColor: AppColor.primaryColor,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.emoji_emotions_outlined,color: AppColor.primaryColor,),
                    hintText: "Type here",
                    labelStyle: TextStyle(color: Colors.black,fontFamily: appFontFamilyBody,fontWeight:FontWeight.w400,fontSize: 12),
                    hintStyle: TextStyle(color: Colors.black,fontFamily: appFontFamilyBody,fontWeight:FontWeight.w400,fontSize: 14),
                    fillColor: AppColor.secondaryColor,
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0), borderSide: BorderSide(color:AppColor.secondaryColor)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0), borderSide: BorderSide(color:AppColor.secondaryColor)),
                    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  if(messageController.text.isNotEmpty){
                    messages.add(ChatBubble(isMe: true, message: messageController.text, timeStamp: DateFormat('hh:mm a').format(DateTime.now())));
                    messageController.clear();
                    FocusScope.of(context).unfocus();
                    scrollController.animateTo(scrollController.position.maxScrollExtent,
                        duration: Duration(seconds: 1), curve: Curves.easeIn);
                    setState(() {
                      
                    });
                  }
                
                  
                },
                child: Container(
                  height: 48,
                  width: 48,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      gradient:LinearGradient(
                        colors: [AppColor.primaryColor, AppColor.red],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    borderRadius: BorderRadius.circular(100)
                  ),
                  child: SvgPicture.asset(Images.sendIcon,),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
