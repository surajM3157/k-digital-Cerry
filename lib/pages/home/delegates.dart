import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:get/get.dart';
import 'package:piwotapp/widgets/app_textfield.dart';
import '../../constants/font_family.dart';
import '../../constants/images.dart';
import '../../route/route_names.dart';
import '../../services/chat_service.dart';
import '../../shared prefs/pref_manager.dart';
import 'package:get/get.dart';

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

  TextEditingController searchDelegateController = TextEditingController();
  TextEditingController searchChatController = TextEditingController();
  ChatService chatService = ChatService();


  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: widget.tabController,
        children: [
          Column(
            children: [
              const SizedBox(height: 20,),
              AppTextField(hintText: "Search Delegates",controller: searchDelegateController,prefixIcon: Icon(Icons.search,color: AppColor.FF9B9B9B,),),
              Expanded(
                child: ListView.separated(itemBuilder: (context,index){
                  return Padding(
                    padding: index ==0? const EdgeInsets.only(top: 16):index ==delegates.length-1?const EdgeInsets.only(bottom: 16):EdgeInsets.zero,
                    child: inviteDelegateList(delegates[index]),
                  );
                }, separatorBuilder: (context,index){
                  return const SizedBox.shrink();
                }, itemCount: delegates.length),
              ),
            ],
          ),
          Column(
            children: [
              const SizedBox(height: 20,),
              AppTextField(hintText: "Search Delegates",controller: searchChatController,prefixIcon: Icon(Icons.search,color: AppColor.FF9B9B9B,),),
              const SizedBox(height: 20,),
              // Expanded(
              //   child: ListView.separated(itemBuilder: (context,index){
              //     return Padding(
              //       padding: index ==0? const EdgeInsets.only(top: 20):index ==delegates.length-1?const EdgeInsets.only(bottom: 20):EdgeInsets.zero,
              //       child: chatListItem(name: delegates[index].name, message: delegates[index].message, profile: delegates[index].profile),
              //     );
              //   }, separatorBuilder: (context, index){
              //     return const SizedBox(height: 20,);
              //   }, itemCount: delegates.length),
              // ),
              Expanded(child: _buildUserList())
            ],
          ),
          ListView.separated(itemBuilder: (context,index){
            return Padding(
              padding: index ==0? const EdgeInsets.only(top: 20):index ==delegates.length-1?const EdgeInsets.only(bottom: 20):EdgeInsets.zero,
              child: requestDelegateList(delegates[index],index),
            );
          }, separatorBuilder: (context,index){
            return const SizedBox();
          }, itemCount: delegates.length),

    ]);
  }

  Widget _buildUserList(){
    return StreamBuilder<QuerySnapshot>(stream:
    FirebaseFirestore.instance.collection("users").snapshots(),
      builder: (context,snapshot){
        if(snapshot.hasError){
          return Text("Error");
        }
        if(snapshot.connectionState ==ConnectionState.waiting){
          return Text("Loading...");
        }
        return ListView(
          children: snapshot.data!.docs.map<Widget>((doc) => _buildUserListItem(doc)).toList(),
        );
      },);
  }

  Widget _buildUserListItem(DocumentSnapshot document){
    Map<String,dynamic> data = document.data()! as Map<String, dynamic>;


    print("other username ${data['name']}");

    if(Prefs.checkUsername != data['name']){
      return ListTile(
        title: Row(
          children: [
            SizedBox(
                height: 70,
                width: 70,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: data['profile']!= null?Image.network(data['profile'],fit: BoxFit.fill,):Image.asset(Images.profile1,fit: BoxFit.fill,))),
            const SizedBox(width: 20,),
            Container(
              width: Get.width/1.5,
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              decoration: BoxDecoration(
                  color: AppColor.white,
                  border: Border.all(color: AppColor.black.withOpacity(0.12)),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data['name']),
                  StreamBuilder(
                      stream: chatService.getMessages(Prefs.checkMobileNo, data['uid']),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Text("Loading...");
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Text("No messages yet");
                        }
                        var lastMessageDoc = snapshot.data!.docs.last;
                        var lastMessageData = lastMessageDoc.data() as Map<String, dynamic>;

                        return Text(
                          lastMessageData['message'], // Display the message content
                          style: TextStyle(color: Colors.grey),
                        );
                      }
                  )
                ],
              ),
            ),
          ],
        ),
        onTap: (){
          Get.toNamed(Routes.chat,arguments: {
            'receiverName':data['name'],
            'receiverId':data['uid']
          });
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) =>  ChatPage(receiverUserEmail: data['name'], receiverUserId: data['uid'],)),
          // );
        },
      );
    }else{
      return Container();
    }
  }


  Widget requestDelegateList(ChatModel chatModel,int index){
    return Container(
      height: 200,
      width: Get.width,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColor.white,
          border: Border.all(color: AppColor.black.withOpacity(0.12)),
          borderRadius: const BorderRadius.all(Radius.circular(8))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  height: 70,
                  width: 70,
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: AppColor.black,
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(chatModel.profile,fit: BoxFit.cover,))),
              const SizedBox(width: 10,),
              Flexible(
                child : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(chatModel.name,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,fontFamily: appFontFamily,color: AppColor.primaryColor),),
                    const SizedBox(height: 10,),
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
                margin: const EdgeInsets.only(left: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                decoration: BoxDecoration(
                    color: AppColor.FFE7E7E7,
                    borderRadius: const BorderRadius.all(Radius.circular(9))
                ),
                child: Center(child: Text("Fintech",style: TextStyle(fontFamily: appFontFamily,fontSize: 10,fontWeight: FontWeight.w400,color: AppColor.FF161616),)),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                decoration: BoxDecoration(
                    color: AppColor.FFE7E7E7,
                    borderRadius: const BorderRadius.all(Radius.circular(9))
                ),
                child: Center(child: Text("Leading",style: TextStyle(fontFamily: appFontFamily,fontSize: 10,fontWeight: FontWeight.w400,color: AppColor.FF161616),)),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                decoration: BoxDecoration(
                    color: AppColor.FFE7E7E7,
                    borderRadius: const BorderRadius.all(Radius.circular(9))
                ),
                child: Center(child: Text("Venture Capital/ Funding",style: TextStyle(fontFamily: appFontFamily,fontSize: 10,fontWeight: FontWeight.w400,color: AppColor.FF161616),)),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          index==0?Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text("You are now friends",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,fontFamily: appFontFamily,color: AppColor.black),),
          ):Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Image.asset(Images.mutualFriendsIcon),
    const SizedBox(width: 5,),
    Text("Mutual Friends",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,fontFamily: appFontFamily,color: AppColor.black),),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          index == 0?Container(
    width: 129,height: 35,
    margin: const EdgeInsets.only(left: 10),
    decoration: BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(8)),
    gradient:LinearGradient(
    colors: [AppColor.primaryColor, AppColor.red],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    ),
    ),
    child: Center(child: Text("Send Message",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: AppColor.white,fontFamily: appFontFamily),)),
    ):Row(
            children: [
              Container(
                width: 100,height: 35,
                margin: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  gradient:LinearGradient(
                    colors: [AppColor.primaryColor, AppColor.red],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(child: Text("Accept",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: AppColor.white,fontFamily: appFontFamily),)),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                  width: 100,height: 35,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
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
      margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
      decoration: BoxDecoration(
        color: AppColor.white,
          border: Border.all(color: AppColor.black.withOpacity(0.12)),
          borderRadius: const BorderRadius.all(Radius.circular(8))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  height: 70,
                  width: 70,
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: AppColor.black,
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(chatModel.profile,fit: BoxFit.cover,))),
              const SizedBox(width: 10,),
              Flexible(
                child : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(chatModel.name,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,fontFamily: appFontFamily,color: AppColor.primaryColor),),
                    const SizedBox(height: 10,),
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
                margin: const EdgeInsets.only(left: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                decoration: BoxDecoration(
                  color: AppColor.FFE7E7E7,
                  borderRadius: const BorderRadius.all(Radius.circular(9))
                ),
                child: Center(child: Text("Fintech",style: TextStyle(fontFamily: appFontFamily,fontSize: 10,fontWeight: FontWeight.w400,color: AppColor.FF161616),)),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                decoration: BoxDecoration(
                  color: AppColor.FFE7E7E7,
                  borderRadius: const BorderRadius.all(Radius.circular(9))
                ),
                child: Center(child: Text("Leading",style: TextStyle(fontFamily: appFontFamily,fontSize: 10,fontWeight: FontWeight.w400,color: AppColor.FF161616),)),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                decoration: BoxDecoration(
                  color: AppColor.FFE7E7E7,
                  borderRadius: const BorderRadius.all(Radius.circular(9))
                ),
                child: Center(child: Text("Venture Capital/ Funding",style: TextStyle(fontFamily: appFontFamily,fontSize: 10,fontWeight: FontWeight.w400,color: AppColor.FF161616),)),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          Row(
            children: [
              Container(
                width: 100,height: 35,
                margin: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
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
                margin: const EdgeInsets.only(left: 10),
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(9)),
                  gradient:LinearGradient(
                    colors: [AppColor.primaryColor, AppColor.red],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Container(
                    width: 100,height: 35,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
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
          SizedBox(
              height: 70,
              width: 70,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(profile,fit: BoxFit.fill,))),
          const SizedBox(width: 20,),
          GestureDetector(
            onTap: (){
              Get.toNamed(Routes.chat);
            },
            child: Container(
              width: Get.width/1.5,
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
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
                  const SizedBox(height: 5,),
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