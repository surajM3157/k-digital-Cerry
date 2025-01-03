import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging_platform_interface/src/remote_message.dart';
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

  bool isSendButtonEnabled = false;
  late Stream<QuerySnapshot> _chatStream;

  String receiverName = '';
  String receiverId = '';
  String profile = '';

  @override
  void initState() {
    super.initState();

    // Initialize the stream for messages
    receiverName = Get.arguments['receiverName'];
    receiverId = Get.arguments['receiverId'];
    profile = Get.arguments['profile'] ?? "";

    _chatStream = chatService.getMessages(receiverId, Prefs.checkUserId);

    // Add listener to the message input field
    messageController.addListener(() {
      setState(() {
        isSendButtonEnabled = messageController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    messageController.removeListener(() {});
    messageController.dispose();
    super.dispose();
  }

  ChatService chatService = ChatService();

  // Send message function
  sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await chatService.sendMessage(receiverId, messageController.text, receiverName);
      messageController.clear();
      setState(() {
        isSendButtonEnabled = false;
      });
      _scrollToBottom(); // Scroll to the bottom after sending the message
    }
  }

  Future<void> _scrollToBottom() async {
    if (scrollController.hasClients) {
      // This makes the list scroll to the bottom automatically after a new message is sent or received.
      await Future.delayed(Duration.zero);
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.secondaryColor,
        titleSpacing: -15,
        centerTitle: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: AppColor.primaryColor,
          ),
        ),
        title: Row(
          children: [
            SizedBox(
              height: 45,
              width: 45,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: profile != ""
                    ? Image.network(
                  profile,
                  fit: BoxFit.fill,
                )
                    : Image.asset(
                  Images.defaultProfile,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                receiverName,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: appFontFamily,
                    color: AppColor.primaryColor),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(child: _buildMessageList()),
          _inputMessage(),
        ],
      ),
    );
  }

  Widget _inputMessage() {
    return Padding(
      padding: const EdgeInsets.only(right: 15, bottom: 9, top: 9),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 50),
            child: Container(
              width: Get.width - 80, // Make space for the send button
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: messageController,
                cursorColor: AppColor.primaryColor,
                minLines: 1,  // Minimum height (will expand)
                maxLines: 5,  // Maximum height (you can increase/decrease based on your design)
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: "Type here...",
                  labelStyle: const TextStyle(
                      color: Colors.black,
                      fontFamily: appFontFamily,
                      fontWeight: FontWeight.w400,
                      fontSize: 12
                  ),
                  hintStyle: const TextStyle(
                      color: Colors.black,
                      fontFamily: appFontFamily,
                      fontWeight: FontWeight.w400,
                      fontSize: 14
                  ),
                  fillColor: AppColor.secondaryColor,
                  filled: true,
                  contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: AppColor.secondaryColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: AppColor.secondaryColor)),
                ),
                onChanged: (value) {
                  setState(() {
                    isSendButtonEnabled = value.trim().isNotEmpty;
                  });
                },
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: isSendButtonEnabled ? sendMessage : null,
              child: Container(
                height: 47,
                width: 47,
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: AppColor.gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: SvgPicture.asset(
                  Images.sendIcon,
                  color: isSendButtonEnabled ? null : Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Message list builder
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No messages yet"));
        }

        return ListView(
          controller: scrollController,
          reverse: false,
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  // Message item widget (Bubble)
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    return ChatBubble(
      message: chatService.decryptMessage(data['message'], 'my_secure_passphrase'),
      isMe: (data['senderId'] == Prefs.checkUserId),
      timeStamp: DateFormat('hh:mm a').format(data['timestamp'].toDate()),
    );
  }
}
