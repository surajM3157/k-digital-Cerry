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
import 'package:fluttertoast/fluttertoast.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  ValueNotifier<bool> isSendButtonEnabled = ValueNotifier<bool>(false);

  final ScrollController _scrollController = ScrollController();

  Future<void> _scrollToBottom() async {
    // Delay ensures ListView is fully rendered before scrolling
    await Future.delayed(const Duration(milliseconds: 100));
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  String receiverName = '';
  String receiverId = '';
  String profile = '';

  @override
  void initState() {
    receiverName = Get.arguments['receiverName'];
    receiverId = Get.arguments['receiverId'];
    profile = Get.arguments['profile'] ?? "";

    print("init_receiverName-->> ${receiverId}");
    print("init_receiverName-->> ${profile}");
    print("init_receiverName-->> ${receiverName}");
    super.initState();

    // Listen to changes in the message input field
    messageController.addListener(() {
      final hasText = messageController.text
          .trim()
          .isNotEmpty;
      isSendButtonEnabled.value = hasText; // Update the send button state
    });
  }

  ChatService chatService = ChatService();

  sendMessage() async {
    if (messageController.text
        .trim()
        .isNotEmpty) {
      await chatService.sendMessage(
          receiverId, messageController.text.trim(), receiverName);
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
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: AppColor.primaryColor,
            )),
        title: Row(
          children: [
            SizedBox(
                height: 45,
                width: 45,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: profile.isNotEmpty
                ? GestureDetector(
                  onTap: () {
                    // Show the full-screen profile image when clicked
                    _showFullScreenImage(profile); // If profile image is set, show it
                  },
                  child: Image.network(
                    profile,  // Show the profile image if available
                    fit: BoxFit.fill,
                  ),
                )
                 : GestureDetector(
                  onTap: () {
                    // Show a toast message if profile is not set
                    Fluttertoast.showToast(
                      msg: "No profile photo",  // Message for the toast
                      toastLength: Toast.LENGTH_SHORT,  // Duration of the toast
                      gravity: ToastGravity.CENTER,  // Position of the toast
                      backgroundColor: Colors.black12,  // Toast background color
                      textColor: Colors.black,  // Text color
                      fontSize: 16.0,  // Font size of the toast
                    );
                  },
                  child: Image.asset(
                    Images.defaultProfile,  // Default image if profile is not set
                    fit: BoxFit.fill,
                  ),
                ),
              ),


            ),

          const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(
                  receiverName,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      fontFamily: appFontFamily,
                      color: AppColor.primaryColor),
                  overflow: TextOverflow.ellipsis,
                ))
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
                minLines: 1,
                // Minimum height (will expand)
                maxLines: 5,
                // Maximum height (you can increase/decrease based on your design)
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
              ),
            ),
          ),

          // Send button positioned at the bottom-right corner
          Positioned(
            bottom: 0,
            right: 0,
            child: ValueListenableBuilder<bool>(
              valueListenable: isSendButtonEnabled,
              // Listen to changes in the button state
              builder: (context, isEnabled, child) {
                return GestureDetector(
                  onTap: isEnabled ? () {
                    sendMessage(); // Send the message
                    messageController.clear(); // Clear the input text field
                  } : null, // Send button enabled only if text exists
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
                      color: isEnabled ? null : Colors
                          .grey, // Change icon color based on the state
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
        stream: chatService.getMessages(receiverId, Prefs.checkUserId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("error ${snapshot.error}");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading...");
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No Messages yet"));
          }
          WidgetsBinding.instance
              .addPostFrameCallback((_) => _scrollToBottom());
          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs
                .map((document) => _buildMessageItem(document))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    return ChatBubble(
      message:
      chatService.decryptMessage(data['message'], 'my_secure_passphrase'),
      isMe: (data['senderId'] == Prefs.checkUserId),
      timeStamp: DateFormat('hh:mm a').format(data['timestamp'].toDate()),
    );
  }

  void _showFullScreenImage(String imageUrl) {
    showDialog(
      context: context,
      barrierDismissible: true,  // This allows tapping outside the dialog to close it.
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,  // Make background transparent
          child: GestureDetector(
            onTap: () {
              // This will close the dialog if you tap anywhere outside the image.
              Navigator.pop(context);
            },
            child: Center(
              child: GestureDetector(
                onTap: () {
                  // This does nothing, effectively preventing the dialog from closing
                  // when you tap the image.
                },
                child: ClipOval(
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: 300,  // Size of the image in full screen
                    height: 300,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}


