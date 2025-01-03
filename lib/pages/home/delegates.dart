import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:piwotapp/constants/api_urls.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:get/get.dart';
import 'package:piwotapp/responses/friend_list_response.dart';
import 'package:piwotapp/responses/guest_list_response.dart';
import 'package:piwotapp/responses/pending_request_response.dart';
import 'package:piwotapp/services/notification_service.dart';
import 'package:piwotapp/widgets/app_textfield.dart';
import '../../constants/font_family.dart';
import '../../constants/images.dart';
import '../../repository/api_repo.dart';
import '../../responses/sent_requests_response.dart';
import '../../route/route_names.dart';
import '../../services/chat_service.dart';
import '../../shared prefs/pref_manager.dart';
import '../../widgets/app_themes.dart';
import '../../widgets/custom_tabbar_indicator.dart';

class Delegates extends StatefulWidget {
  final int tabIndex;
  Delegates({super.key, this.tabController, this.tabIndex = 0});

  TabController? tabController;

  @override
  State<Delegates> createState() => _DelegatesState();
}

class _DelegatesState extends State<Delegates>
    with SingleTickerProviderStateMixin {
  FriendListResponse? _friendListResponse;
  List<String> friendList = [];

  GuestListResponse? _guestListResponse;
  List<GuestListData> guestList = [];

  PendingRequestResponse? _pendingRequestResponse;
  List<PendingRequestData> pendingRequestList = [];
  List<String> sentRequestList = [];

  String requestStatus = "";
  Timer? debounceTimer;
  String chatSearchText = "";
  bool isConnected = true;
  var lastMessageDoc;

  void onSearchChanged(String query) {
    setState(() {});
    if (debounceTimer?.isActive ?? false) debounceTimer!.cancel();
    debounceTimer = Timer(const Duration(milliseconds: 1500), () {
      fetchGuestList(searchDelegateController.text);
    });
  }

  fetchFriendList() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;
      setState(() {});
    } else {
      isConnected = true;

      Future.delayed(Duration.zero);
      // Future.delayed(Duration.zero, () {
      //   showLoader(context);
      // });

      var response = await ApiRepo().getFriendListResponse();

      if (response.data != null && response.data!.isNotEmpty) {
        _friendListResponse = response;
        for (String friend in _friendListResponse!.data![0].friends!) {
          friendList.add(friend);
        }
        print("floorPlanList ${friendList.length}");
        print("friendList $friendList");
        print("userId ${Prefs.checkUserId}");
      }
      fetchGuestList('');
      fetchSentRequestList();

      setState(() {});
    }
  }

  fetchSentRequestList() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;
      setState(() {});
    } else {
      isConnected = true;

      sentRequestList.clear();
      var response = await ApiRepo().sendRequestsResponse();

      if (response.data != null) {
        for (SentRequestsData sentRequest in response!.data!) {
          print("sentRequest ${sentRequest.requestSentUserDetails?[0].sId}");
          sentRequestList.add(sentRequest.requestSentUserDetails?[0].sId ?? "");
        }

        print("sentRequestList $sentRequestList");
        fetchGuestList("");
      }

      setState(() {});
    }
  }

  fetchGuestList(String search) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;
      setState(() {});
    } else {
      isConnected = true;
      guestList.clear();
      Future.delayed(Duration.zero, () {
        // showLoader(context);
      });
      var response = await ApiRepo().getGuestListResponse(search);

      NotificationService notificationService = NotificationService();
      if (response.data != null) {
        _guestListResponse = response;
        for (GuestListData guest in _guestListResponse!.data!) {
          if (friendList.isEmpty) {
            guestList.add(guest);
          } else if (!friendList.contains(guest.sId)) {
            guestList.add(guest);
          }
          // notificationService.unsubscribeFromTopic(guest.sId ?? "");
          // print("done Unsubscription ${guest.sId}");
        }
        print("guestList $guestList");
      }

      setState(() {});
    }
  }

  fetchPendingRequest() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;
      setState(() {});
    } else {
      isConnected = true;
      // Future.delayed(Duration.zero, () {
      //   showLoader(context);
      // });
      Future.delayed(Duration.zero);
      pendingRequestList.clear();
      var response = await ApiRepo().pendingRequestResponse();

      if (response.data != null) {
        _pendingRequestResponse = response;
        for (PendingRequestData pendingRequest
            in _pendingRequestResponse!.data!) {
          pendingRequestList.add(pendingRequest);
        }

        print("guestList ${pendingRequestList.length}");
      }

      setState(() {});
    }
  }

  sendRequest(String receiverId) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;
      EasyLoading.showToast("No Internet",
          dismissOnTap: true,
          duration: const Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.center);
      setState(() {});
    } else {
      isConnected = true;
      Map<String, String> params = new Map<String, String>();
      params["from"] = Prefs.checkUserId;
      params["to"] = receiverId;

      Future.delayed(Duration.zero, () {
        // showLoader(context);
      });

      await ApiRepo().sendRequest(params, receiverId);
      fetchSentRequestList();
    }
  }

  handlePendingRequest(String status, String id) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;
      EasyLoading.showToast("No Internet",
          dismissOnTap: true,
          duration: const Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.center);
      setState(() {});
    } else {
      isConnected = true;

      Future.delayed(Duration.zero, () {
        // showLoader(context);
      });

      await ApiRepo().handleRequest(id, status);
      fetchPendingRequest();
    }
  }

  TextEditingController searchDelegateController = TextEditingController();
  TextEditingController searchChatController = TextEditingController();
  ChatService chatService = ChatService();
  TabController? _controller;

  @override
  void initState() {
    // _controller = TabController(length: 3, vsync: this);
    // fetchFriendList();
    if (_controller == null) {
      _controller =
          TabController(length: 3, vsync: this, initialIndex: widget.tabIndex);
    }

    print(" TabIndex123 -> ${widget.tabIndex}");
    fetchFriendList();
    widget.tabController?.addListener(_handleTabChange);
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        isConnected = false;
      } else {
        // Handle case when internet connection is available
        isConnected = true;
        fetchGuestList("");
        fetchFriendList();
        fetchPendingRequest();
      }
    });

    super.initState();
  }

  void _handleTabChange() {
    if (widget.tabController!.indexIsChanging) return;

    switch (widget.tabController?.index) {
      case 0:
        fetchGuestList("");
        break;
      case 1:
        fetchFriendList();
        break;
      case 2:
        fetchPendingRequest();
        break;
    }
  }
  // void _handleTabChange() {
  //   if (_controller?.indexIsChanging ?? false) return;
  //
  //   switch (_controller?.index) {
  //     case 0:
  //       fetchGuestList("");
  //       break;
  //     case 1:
  //       fetchFriendList();
  //       break;
  //     case 2:
  //       fetchPendingRequest();
  //       break;
  //   }
  // }

  @override
  void dispose() {
    // Dispose the TabController when the widget is disposed
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // _counter = Provider.of<int>(context);
    print('didChangeDependencies(), counter = ${widget.tabIndex}');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("timeIndexBuild-> ${widget.tabIndex}");

    return isConnected
        ? Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TabBar(
                controller: widget.tabController,
                labelPadding: const EdgeInsets.symmetric(horizontal: 25),
                indicatorColor: AppColor.primaryColor,
                indicator: CustomUnderlineTabIndicator(
                  borderSide:
                      BorderSide(width: 3.0, color: AppColor.primaryColor),
                  insets: const EdgeInsets.symmetric(vertical: -8),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                  ),
                ),
                tabs: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 17),
                    child: Text("Delegates",
                        style: AppThemes.labelTextStyle()
                            .copyWith(color: AppColor.primaryColor)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 17),
                    child: Text("Chat",
                        style: AppThemes.labelTextStyle()
                            .copyWith(color: AppColor.primaryColor)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 17),
                    child: Text("Request",
                        style: AppThemes.labelTextStyle()
                            .copyWith(color: AppColor.primaryColor)),
                  ),
                ],
              ),
              Container(
                height: 1,
                margin: const EdgeInsets.only(top: 1),
                width: double.infinity,
                color: AppColor.lightGrey,
              ),
              Expanded(
                child: TabBarView(
                  controller: widget.tabController,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 20),
                        AppTextField(
                          hintText: "Search Delegates",
                          controller: searchDelegateController,
                          prefixIcon:
                              Icon(Icons.search, color: AppColor.FF9B9B9B),
                          onChanged: onSearchChanged,
                        ),
                        Expanded(
                          child: guestList.isNotEmpty
                              ? ListView.separated(
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: index == 0
                                          ? const EdgeInsets.only(top: 16)
                                          : index == guestList.length - 1
                                              ? const EdgeInsets.only(
                                                  bottom: 16)
                                              : EdgeInsets.zero,
                                      child:
                                          inviteDelegateList(guestList[index]),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox.shrink();
                                  },
                                  itemCount: guestList.length,
                                )
                              : Center(
                                  child: Text(
                                    "No Delegates Available To Connect",
                                    style: TextStyle(
                                        color: AppColor.primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: appFontFamily,
                                        fontSize: 20),
                                  ),
                                ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 20),
                        AppTextField(
                          hintText: "Search Delegates",
                          controller: searchChatController,
                          prefixIcon:
                              Icon(Icons.search, color: AppColor.FF9B9B9B),
                          onChanged: (value) {
                            chatSearchText = value;
                            setState(() {});
                          },
                        ),
                        const SizedBox(height: 20),
                        Expanded(child: _buildUserList()),
                      ],
                    ),
                    pendingRequestList.isNotEmpty
                        ? ListView.separated(
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: index == 0
                                    ? const EdgeInsets.only(top: 20)
                                    : index == pendingRequestList.length - 1
                                        ? const EdgeInsets.only(bottom: 20)
                                        : EdgeInsets.zero,
                                child: requestDelegateList(
                                    pendingRequestList[index]),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox();
                            },
                            itemCount: pendingRequestList.length,
                          )
                        : Center(
                            child: Text(
                              "No Pending Requests",
                              style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: appFontFamily,
                                  fontSize: 20),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          )
        : const Center(
            child: Text(
            "OOPS! NO INTERNET.",
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontFamily: appFontFamily,
                fontSize: 20),
          ));
  }

  Widget _buildUserList() {
    return friendList.isNotEmpty
        ? StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("users")
                .orderBy("name") // Ensure the collection is ordered by name
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Error");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("");
              }
              // Client-side filtering (optional, based on your requirements)
              final allDocs = snapshot.data!.docs;
              final filteredDocs = allDocs.where((doc) {
                final name = (doc['name'] as String);
                return name
                    .toLowerCase()
                    .contains(chatSearchText.toLowerCase());
              }).toList();
              return ListView(
                children: filteredDocs
                    .map<Widget>((doc) => _buildUserListItem(doc))
                    .toList(),
              );
            },
          )
        : Center(
            child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "No delegates yet. Click 'Connect' to invite",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColor.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontFamily: appFontFamily,
                  fontSize: 20),
            ),
          ));
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    print("other username ${data['name']}");
    print("friendList $friendList");
    print("uid ${data['uid']}");

    if (Prefs.checkUserId != data['uid'] && friendList.contains(data['uid'])) {
      return ListTile(
        title: Row(
          children: [
            Container(
              height: 71,
              width: 71,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: AppColor.gradientColors)),
              child: SizedBox(
                  height: 70,
                  width: 70,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: data['profile'] != null
                          ? Image.network(
                              data['profile'],
                              fit: BoxFit.fill,
                            )
                          : Image.asset(
                              Images.defaultProfile,
                              fit: BoxFit.fill,
                            ))),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              flex: 4,
              child: Container(
                width: Get.width / 1.5,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                    color: AppColor.white,
                    border: Border.all(color: AppColor.black.withOpacity(0.12)),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['name'],
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontFamily: appFontFamily),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    StreamBuilder(
                        stream: chatService.getMessages(Prefs.checkUserId, data['uid']),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: Text("Loading..."));
                          }
                          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                            return const Text("No messages yet",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: appFontFamily));
                          }
                          lastMessageDoc = snapshot.data!.docs.last;
                          var lastMessageData =
                          lastMessageDoc.data() as Map<String, dynamic>;
                          return Text(
                            chatService.decryptMessage(
                                lastMessageData['message'], 'my_secure_passphrase'),
                            overflow: TextOverflow.ellipsis, // Ensures long messages are truncated
                            maxLines: 1, // Limits to 2 lines (adjust based on your design)
                            softWrap: true, // Allows message to wrap to the next line
                            style: TextStyle(
                                color: (lastMessageData['senderId'] == Prefs.checkUserId)
                                    ? Colors.grey
                                    : lastMessageData['isRead']
                                    ? Colors.grey
                                    : Colors.black,
                                fontWeight: (lastMessageData['senderId'] ==
                                    Prefs.checkUserId)
                                    ? FontWeight.normal
                                    : lastMessageData['isRead']
                                    ? FontWeight.normal
                                    : FontWeight.bold),
                          );
                        })
                  ],
                ),
              ),
            )

          ],
        ),
        onTap: () async {
          if (lastMessageDoc != null) {
            FirebaseFirestore.instance
                .collection("chat_rooms")
                .doc("${Prefs.checkUserId}_${data['uid']}")
                .collection('messages')
                .doc(lastMessageDoc.id) // Use the ID of the last document
                .update({'isRead': true});

            FirebaseFirestore.instance
                .collection("chat_rooms")
                .doc("${data['uid']}_${Prefs.checkUserId}")
                .collection('messages')
                .doc(lastMessageDoc.id)
                .update({'isRead': true});
          }
          Get.toNamed(Routes.chat, arguments: {
            'receiverName': data['name'],
            'receiverId': data['uid'],
            'profile': data['profile']
          });
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) =>  ChatPage(receiverUserEmail: data['name'], receiverUserId: data['uid'],)),
          // );
        },
      );
    } else {
      return Container();
    }
  }

  Widget requestDelegateList(PendingRequestData pendingRequestData) {
    return Container(
      height: 170,
      width: Get.width,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColor.white,
          border: Border.all(color: AppColor.black.withOpacity(0.12)),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                  height: 70,
                  width: 70,
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: AppColor.gradientColors),
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: pendingRequestData.requestSentUserDetails?[0]
                                  .guestProfileImage !=
                              null
                          ? Image.network(
                              ApiUrls.imageUrl +
                                  (pendingRequestData.requestSentUserDetails?[0]
                                          .guestProfileImage ??
                                      ""),
                              fit: BoxFit.fill,
                            )
                          : Image.asset(
                              Images.defaultProfile,
                              fit: BoxFit.cover,
                            ))),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (pendingRequestData
                                  .requestSentUserDetails?[0].firstName ??
                              "") +
                          " " +
                          (pendingRequestData
                                  .requestSentUserDetails?[0].lastName ??
                              ""),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          fontFamily: appFontFamily,
                          color: AppColor.primaryColor),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      (pendingRequestData
                                  .requestSentUserDetails?[0].designation ??
                              "") +
                          " | " +
                          (pendingRequestData
                                  .requestSentUserDetails?[0].companyName ??
                              ""),
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        fontFamily: appFontFamily,
                        color: AppColor.FF161616,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2, // Adjust maxLines as needed
                      softWrap: true,
                    ),
                  ],
                ),
              )
            ],
          ),
          // Row(
          //   children: [
          //     Container(
          //       margin: const EdgeInsets.only(left: 10),
          //       padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          //       decoration: BoxDecoration(
          //           color: AppColor.FFE7E7E7,
          //           borderRadius: const BorderRadius.all(Radius.circular(9))
          //       ),
          //       child: Center(child: Text("Fintech",style: TextStyle(fontFamily: appFontFamily,fontSize: 10,fontWeight: FontWeight.w400,color: AppColor.FF161616),)),
          //     ),
          //     Container(
          //       margin: const EdgeInsets.only(left: 10),
          //       padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          //       decoration: BoxDecoration(
          //           color: AppColor.FFE7E7E7,
          //           borderRadius: const BorderRadius.all(Radius.circular(9))
          //       ),
          //       child: Center(child: Text("Leading",style: TextStyle(fontFamily: appFontFamily,fontSize: 10,fontWeight: FontWeight.w400,color: AppColor.FF161616),)),
          //     ),
          //     Container(
          //       margin: const EdgeInsets.only(left: 10),
          //       padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          //       decoration: BoxDecoration(
          //           color: AppColor.FFE7E7E7,
          //           borderRadius: const BorderRadius.all(Radius.circular(9))
          //       ),
          //       child: Center(child: Text("Venture Capital/ Funding",style: TextStyle(fontFamily: appFontFamily,fontSize: 10,fontWeight: FontWeight.w400,color: AppColor.FF161616),)),
          //     ),
          //   ],
          // ),
          //  pendingRequestData.status?.toLowerCase() == "pending"? SizedBox.shrink() :SizedBox(height: 10,),
          // pendingRequestData.status?.toLowerCase() == "pending"? SizedBox.shrink():Padding(
          //    padding: const EdgeInsets.only(left: 10),
          //    child: Text(pendingRequestData.status?.toLowerCase() == "accepted"?"You are now friends":"You rejected request.",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,fontFamily: appFontFamily,color: AppColor.black),),
          //  ),
          const SizedBox(
            height: 10,
          ),
          pendingRequestData.status?.toLowerCase() == "pending"
              ? Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        handlePendingRequest(
                            "accepted", pendingRequestData.sId ?? "");
                        // pendingRequestList.remove(pendingRequestData);
                      },
                      child: Container(
                        width: 100,
                        height: 35,
                        margin: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          gradient: LinearGradient(
                            colors: AppColor.gradientColors,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Center(
                            child: Text(
                          "Accept",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: AppColor.white,
                              fontFamily: appFontFamily),
                        )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        handlePendingRequest(
                            "rejected", pendingRequestData.sId ?? "");
                        // pendingRequestList.remove(pendingRequestData);
                      },
                      child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          width: 100,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              color: AppColor.white,
                              border: Border.all(color: AppColor.red)),
                          child: Center(
                              child: Text(
                            "Reject",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: AppColor.red,
                              fontFamily: appFontFamily,
                            ),
                          ))),
                    ),
                  ],
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }

  Widget inviteDelegateList(GuestListData guestListData) {
    return guestListData.sId == Prefs.checkUserId
        ? const SizedBox.shrink()
        : Container(
            height: 150,
            width: Get.width,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
                color: AppColor.white,
                border: Border.all(color: AppColor.black.withOpacity(0.12)),
                borderRadius: const BorderRadius.all(Radius.circular(8))),
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
                          gradient:
                              LinearGradient(colors: AppColor.gradientColors),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: guestListData.guestProfileImage != null
                                ? Image.network(
                                    ApiUrls.imageUrl +
                                        (guestListData.guestProfileImage ?? ""),
                                    fit: BoxFit.fill,
                                  )
                                : Image.asset(
                                    Images.defaultProfile,
                                    fit: BoxFit.cover,
                                  ))),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (guestListData.firstName ?? "") +
                                " " +
                                (guestListData.lastName ?? ""),
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: appFontFamily,
                                color: AppColor.primaryColor),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Text(
                            (guestListData.designation ?? "") +
                                " | " +
                                (guestListData.companyName ?? ""),
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              fontFamily: appFontFamily,
                              color: AppColor.FF161616,
                              overflow: TextOverflow
                                  .ellipsis, // Prevents overflow by showing ellipsis
                            ),
                            maxLines: 2, // Adjust maxLines as needed
                            softWrap: true,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                // Row(
                //   children: [
                //     Container(
                //       margin: const EdgeInsets.only(left: 10),
                //       padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                //       decoration: BoxDecoration(
                //         color: AppColor.FFE7E7E7,
                //         borderRadius: const BorderRadius.all(Radius.circular(9))
                //       ),
                //       child: Center(child: Text("Fintech",style: TextStyle(fontFamily: appFontFamily,fontSize: 10,fontWeight: FontWeight.w400,color: AppColor.FF161616),)),
                //     ),
                //     Container(
                //       margin: const EdgeInsets.only(left: 10),
                //       padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                //       decoration: BoxDecoration(
                //         color: AppColor.FFE7E7E7,
                //         borderRadius: const BorderRadius.all(Radius.circular(9))
                //       ),
                //       child: Center(child: Text("Leading",style: TextStyle(fontFamily: appFontFamily,fontSize: 10,fontWeight: FontWeight.w400,color: AppColor.FF161616),)),
                //     ),
                //     Container(
                //       margin: const EdgeInsets.only(left: 10),
                //       padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                //       decoration: BoxDecoration(
                //         color: AppColor.FFE7E7E7,
                //         borderRadius: const BorderRadius.all(Radius.circular(9))
                //       ),
                //       child: Center(child: Text("Venture Capital/ Funding",style: TextStyle(fontFamily: appFontFamily,fontSize: 10,fontWeight: FontWeight.w400,color: AppColor.FF161616),)),
                //     ),
                //   ],
                // ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (sentRequestList.contains(guestListData.sId)) {
                        } else {
                          sendRequest(guestListData.sId ?? "");
                        }
                      },
                      child: Container(
                        width: 120,
                        height: 35,
                        margin: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          gradient: LinearGradient(
                            colors: AppColor.gradientColors,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Center(
                            child: Text(
                          sentRequestList.contains(guestListData.sId)
                              ? "Request Sent"
                              : "Connect",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: AppColor.white,
                              fontFamily: appFontFamily),
                        )),
                      ),
                    ),
                    // Container(
                    //   width: 100,height: 35,
                    //   margin: const EdgeInsets.only(left: 10),
                    //   padding: const EdgeInsets.all(1),
                    //   decoration: BoxDecoration(
                    //     borderRadius: const BorderRadius.all(Radius.circular(9)),
                    //     gradient:LinearGradient(
                    //       colors: [AppColor.primaryColor, AppColor.red],
                    //       begin: Alignment.topLeft,
                    //       end: Alignment.bottomRight,
                    //     ),
                    //   ),
                    //   child: Container(
                    //       width: 100,height: 35,
                    //       decoration: BoxDecoration(
                    //           borderRadius: const BorderRadius.all(Radius.circular(8)),
                    //           color: AppColor.white
                    //       ),
                    //       child: Center(child: Text("Send Note",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: AppColor.FF161616,fontFamily: appFontFamily,),))),
                    // ),
                  ],
                )
              ],
            ),
          );
  }

  Widget _chatListItem(
      {required String name,
      required String message,
      required String profile}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          SizedBox(
              height: 70,
              width: 70,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    profile,
                    fit: BoxFit.fill,
                  ))),
          const SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.chat);
            },
            child: Container(
              width: Get.width / 1.5,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  color: AppColor.white,
                  border: Border.all(color: AppColor.black.withOpacity(0.12)),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: TextStyle(
                          fontFamily: appFontFamily,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: AppColor.FF161616)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(message,
                      style: TextStyle(
                          fontFamily: appFontFamily,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColor.FF161616,
                          overflow: TextOverflow.ellipsis)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ChatModel {
  ChatModel(
      {required this.name,
      required this.message,
      required this.profile,
      required this.isInvited});
  String name;
  String message;
  String profile;
  bool isInvited;
}
