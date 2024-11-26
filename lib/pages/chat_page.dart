import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:piwotapp/constants/font_family.dart';
import 'package:piwotapp/widgets/chat_bubble.dart';
import '../constants/images.dart';
import '../services/chat_service.dart';
import '../shared prefs/pref_manager.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  // List<Widget> messages = [
  //   ChatBubble(isMe: true, message: "Good Morning", timeStamp: "1:20pm"),
  //   ChatBubble(isMe: false, message: "Not much, just chilling. How about you?", timeStamp: "1:20pm"),
  //   ChatBubble(isMe: true, message: "Ok", timeStamp: "1:20pm"),
  // ];

  final ScrollController _scrollController = ScrollController();
  Future<void> _scrollToBottom() async {
    // Delay ensures ListView is fully rendered before scrolling
    await Future.delayed(const Duration(milliseconds: 100));
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  // void _scrollToBottom() {
  //   if (_scrollController.hasClients) {
  //     _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  //   }
  // }

  String receiverName = '';
  String receiverId = '';
  String profile = '';

  @override
  void initState() {
    receiverName = Get.arguments['receiverName'];
    receiverId = Get.arguments['receiverId'];
    profile = Get.arguments['profile']??"";
    super.initState();
  }

  ChatService chatService = ChatService();


  sendMessage()async{
    if(messageController.text.isNotEmpty){
      await chatService.sendMessage(receiverId, messageController.text,receiverName);
      messageController.clear();
      _scrollToBottom();
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    _scrollToBottom();
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
            SizedBox(
              height: 45,
                width: 45,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                    child: profile!= ""?Image.network(profile,fit: BoxFit.fill,):Image.asset(Images.defaultProfile,fit: BoxFit.fill,))),
            const SizedBox(width: 10,),
            Expanded(child: Text(receiverName,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,fontFamily: appFontFamily,color: AppColor.primaryColor),overflow: TextOverflow.ellipsis,))
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
         // Expanded(
         //   child: ListView.builder(
         //     controller: scrollController,
         //     itemCount: messages.length,
         //       itemBuilder: (context,index){
         //     return messages[index];
         //   }),
         // ),
          Expanded(child: _buildMessageList()),
         _inputMessage(),
        ],
      ),
    );
  }

  Widget _inputMessage(){
    return  Row(
      children: [
        Container(
          width: Get.width - 60,
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: TextFormField(
            controller: messageController,
            cursorColor: AppColor.primaryColor,
            maxLines: null, // Allows unlimited lines, adjusting height as needed
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(

              // prefixIcon: Icon(Icons.emoji_emotions_outlined,color: AppColor.primaryColor,),
              hintText: "Type here",
              labelStyle: const TextStyle(color: Colors.black,fontFamily: appFontFamily,fontWeight:FontWeight.w400,fontSize: 12),
              hintStyle: const TextStyle(color: Colors.black,fontFamily: appFontFamily,fontWeight:FontWeight.w400,fontSize: 14),
              fillColor: AppColor.secondaryColor,
              filled: true,
              contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0), borderSide: BorderSide(color:AppColor.secondaryColor)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0), borderSide: BorderSide(color:AppColor.secondaryColor)),
              errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0), borderSide: const BorderSide(color: Colors.red, width: 2.0)),
              focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0), borderSide: const BorderSide(color: Colors.red, width: 2.0)),
            ),
          ),
        ),
        GestureDetector(
          onTap: sendMessage,
          //     (){
          //   if(messageController.text.isNotEmpty){
          //     messages.add(ChatBubble(isMe: true, message: messageController.text, timeStamp: DateFormat('hh:mm a').format(DateTime.now())));
          //     messageController.clear();
          //     FocusScope.of(context).unfocus();
          //     scrollController.animateTo(scrollController.position.maxScrollExtent,
          //         duration: const Duration(seconds: 1), curve: Curves.easeIn);
          //     setState(() {
          //
          //     });
          //   }
          //
          //
          // },
          child: Container(
            height: 48,
            width: 48,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                gradient:LinearGradient(
                  colors: AppColor.gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(100)
            ),
            child: SvgPicture.asset(Images.sendIcon,),
          ),
        )
      ],
    );
  }

  Widget _buildMessageList(){
    return StreamBuilder(
        stream: chatService.getMessages(receiverId, Prefs.checkUserId),
        builder: (context,snapshot){
          if(snapshot.hasError){
            return Text("error ${snapshot.error}");
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Text("Loading...");
          }

          WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot document){
    Map<String, dynamic> data = document.data() as Map<String,dynamic>;

    return ChatBubble( message: chatService.decryptMessage(data['message'],'my_secure_passphrase'), isMe: (data['senderId']== Prefs.checkUserId), timeStamp: DateFormat('hh:mm a').format(data['timestamp'].toDate()),);
  }
}
