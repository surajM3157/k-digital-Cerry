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
        margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        padding: const EdgeInsets.only(top: 20,bottom: 20,right: 20,left: 20),
        decoration: BoxDecoration(
            color: isMe?AppColor.FFF9F8FF:null,
            gradient:isMe?null:LinearGradient(
              colors: [AppColor.primaryColor, AppColor.red],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
            bottomLeft:Radius.circular(25)
          ),
          border: isMe? Border.all(color: AppColor.black.withOpacity(0.10)):null
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
                  message,style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w400,
                  fontSize: 15,color: isMe?AppColor.black:AppColor.white
                ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  timeStamp,style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w400,
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
