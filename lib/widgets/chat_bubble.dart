import 'package:flutter/cupertino.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:piwotapp/constants/font_family.dart';

class ChatBubble extends StatelessWidget {
   ChatBubble({super.key,required this.isMe,required this.message,required this.timeStamp});
  bool isMe;
  String message;
  String timeStamp;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe?Alignment.centerRight:Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        padding: EdgeInsets.only(top: 20,bottom: 20,right: 20,left: 20),
        decoration: BoxDecoration(
            color: isMe?AppColor.secondaryColor:AppColor.primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
            bottomLeft:Radius.circular(25)
          )
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  message,style: TextStyle(fontFamily: appFontFamilyBody,fontWeight: FontWeight.w400,
                  fontSize: 15,color: isMe?AppColor.black:AppColor.white
                ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  timeStamp,style: TextStyle(fontFamily: appFontFamilyBody,fontWeight: FontWeight.w400,
                  fontSize: 8,color: isMe?AppColor.black:AppColor.white
                ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
