import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:piwotapp/constants/api_urls.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:piwotapp/responses/friend_list_response.dart';
import 'package:piwotapp/responses/guest_list_response.dart';
import 'package:piwotapp/responses/pending_request_response.dart';
import 'package:piwotapp/services/notification_service.dart';
import 'package:piwotapp/widgets/app_textfield.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  Delegates({
    super.key,
    this.tabController,
    this.tabIndex = 0,
  });

  TabController? tabController;

  @override
  State<Delegates> createState() => _DelegatesState();
}

class _DelegatesState extends State<Delegates> with SingleTickerProviderStateMixin {
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

  final List<Map<String, dynamic>> userChatList = [];
  late final StreamSubscription<QuerySnapshot> _subscription;

  void _subscribeToUserCollection() {
    _subscription = FirebaseFirestore.instance
        .collection("users")
        .orderBy("name") // Ensure the collection is ordered by name
        .snapshots()
        .listen((snapshot) {
      final filteredDocs = snapshot.docs.where((doc) {
        final name = (doc['name'] as String);
        return name.toLowerCase().contains(chatSearchText.toLowerCase());
      }).toList();

      print("user list length ===> ${filteredDocs.length}");

      userChatList.clear();

      Timestamp currentTime = Timestamp.fromDate(DateTime.now());
      for (var element in filteredDocs) {
        Map<String, dynamic> data1 = element.data();
        data1.addEntries([
          MapEntry('message_time', currentTime),
          MapEntry('message_text', 'Loading...'),
          MapEntry('senderId', ''),
          MapEntry('isRead', true),
        ]);
        userChatList.add(data1);
      }
      setState(() {});
    }, onError: (error) {
      print("Error listening to users collection: $error");
    });
  }

  void onSearchChanged(String query) {
    setState(() {});
    if (debounceTimer?.isActive ?? false) debounceTimer!.cancel();
    debounceTimer = Timer(const Duration(milliseconds: 300), () {
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
        friendList.clear();
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
        for (SentRequestsData sentRequest in response.data!) {
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
        for (PendingRequestData pendingRequest in _pendingRequestResponse!.data!) {
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
          dismissOnTap: true, duration: const Duration(seconds: 1), toastPosition: EasyLoadingToastPosition.center);
      setState(() {});
    } else {
      isConnected = true;
      Map<String, String> params = <String, String>{};
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
          dismissOnTap: true, duration: const Duration(seconds: 1), toastPosition: EasyLoadingToastPosition.center);
      setState(() {});
    } else {
      isConnected = true;

      Future.delayed(Duration.zero, () {
        showLoader(context);
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
    _subscribeToUserCollection();
    print(" TabIndex-> ${widget.tabController}");
    widget.tabController!.index = widget.tabIndex;
    _handleTabChange();
    // _controller = TabController(length: 3, vsync: this);
    // fetchFriendList();
    _controller ??= TabController(length: 3, vsync: this, initialIndex: widget.tabIndex);

    print(" TabIndex123 -> ${widget.tabIndex}");
    // fetchFriendList();
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
        searchDelegateController.clear();
        fetchFriendList();
        break;
      case 1:
        searchChatController.clear(); // Reset search in Chat tab
        fetchFriendList();
        break;
      case 2:
        fetchPendingRequest();
        break;
    }
    print("widget.tabController?.index ${widget.tabController?.index}");
    // print("widget.tabController?.index ${widget.tabIndex}");
  }

  @override
  void dispose() {
    // Dispose the TabController when the widget is disposed
    _subscription.cancel();
    _controller?.dispose();
    searchDelegateController.dispose();
    searchChatController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // _counter = Provider.of<int>(context);
    print('didChangeDependencies(), counter = ${widget.tabIndex}');
    super.didChangeDependencies();
  }

  final Debouncer _debouncer = Debouncer(delay: const Duration(milliseconds: 500));
  ValueNotifier<bool> upadteUi = ValueNotifier(true);

  void shortList() {
    print("list updated ===>>>??? ${userChatList.length}");

    bool isRefreshList = true;
    userChatList.forEach((element) {
      if (element['message_text'] == "Loading...") {
        isRefreshList = false;
      }
    });

    if (isRefreshList) {
      // _debouncer(() {
      userChatList.sort((a, b) {
        return a['message_time'].compareTo(b['message_time']);
      });

      List<Map<String, dynamic>> temp = userChatList.reversed.toList();
      userChatList.clear();
      userChatList.addAll(temp);
      upadteUi.value = !upadteUi.value;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("timeIndexBuild-> ${widget.tabIndex}");

    List<Map<String, dynamic>> dumyList = [];
    if (friendList.isNotEmpty && userChatList.isNotEmpty) {
      for (var data in userChatList) {
        // Map<String, dynamic> data =  element.data()! as Map<String, dynamic>;
        if (Prefs.checkUserId != data['uid'] && friendList.contains(data['uid'])) {
          dumyList.add(data);
        }
      }
      userChatList.clear();
      userChatList.addAll(dumyList);
    }

    shortList();

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
                  borderSide: BorderSide(width: 3.0, color: AppColor.primaryColor),
                  insets: const EdgeInsets.symmetric(vertical: -8),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                  ),
                ),
                tabs: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 17),
                    child: Text("Delegates", style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 17),
                    child: Text("Chat", style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 17),
                    child: Text("Request", style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor)),
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
                          prefixIcon: Icon(Icons.search, color: AppColor.FF9B9B9B),
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
                                              ? const EdgeInsets.only(bottom: 16)
                                              : EdgeInsets.zero,
                                      child: inviteDelegateList(guestList[index]),
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
                    ValueListenableBuilder(
                        valueListenable: upadteUi,
                        builder: (context, value, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 20),
                              AppTextField(
                                hintText: "Search Delegates",
                                controller: searchChatController,
                                prefixIcon: Icon(Icons.search, color: AppColor.FF9B9B9B),
                                onChanged: (value) {
                                  chatSearchText = value;
                                  setState(() {});
                                },
                              ),
                              const SizedBox(height: 20),
                              Expanded(child: _buildUserList()),
                            ],
                          );
                        }),
                    pendingRequestList.isNotEmpty
                        ? ListView.separated(
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: index == 0
                                    ? const EdgeInsets.only(top: 20)
                                    : index == pendingRequestList.length - 1
                                        ? const EdgeInsets.only(bottom: 20)
                                        : EdgeInsets.zero,
                                child: requestDelegateList(pendingRequestList[index]),
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
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.w600, fontFamily: appFontFamily, fontSize: 20),
          ));
  }

  Widget _buildUserList() {
    return userChatList.isNotEmpty
        ? ListView.builder(
            itemCount: userChatList.length,
            itemBuilder: (context, index) {
              return _buildUserListItem(index);
            },
          )
       : Center(
            child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 16),
             child: Text(
              "No delegates yet.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColor.primaryColor, fontWeight: FontWeight.w600, fontFamily: appFontFamily, fontSize: 20),
            ),
          ));
  }

  Widget _buildUserListItem(int index) {
    friendList = friendList.toList();
    // Map<String, dynamic> data = userChatList[index];
    // print("other username ${userChatList[index]['name']}");
    // print("friendList $friendList");
    // print("uid ${userChatList[index]['uid']}");

    if (Prefs.checkUserId != userChatList[index]['uid'] && friendList.contains(userChatList[index]['uid'])) {
      friendList = friendList.toSet().toList();
      return ListTile(
        title: Row(
          children: [
            Container(
              height: 71,
              width: 71,
              padding: const EdgeInsets.all(1),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: AppColor.gradientColors)),
              child: SizedBox(
                  height: 70,
                  width: 70,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: GestureDetector(
                    onTap: () {
                      // Ensure context is valid for showDialog
                      if (userChatList[index]['profile'] != null && userChatList[index]['profile'].isNotEmpty) {
                        // If profile image is available, show it full-screen
                        _showFullScreenImage(userChatList[index]['profile'], context);  // Pass context here
                      } else {
                        // If profile image is not available, show toast message
                        Fluttertoast.showToast(
                          msg: "No profile photo",  // Message for the toast
                          toastLength: Toast.LENGTH_SHORT,  // Duration of the toast
                          gravity: ToastGravity.CENTER,  // Position of the toast
                          backgroundColor: Colors.black12,  // Toast background color
                          textColor: Colors.black,  // Text color
                          fontSize: 16.0,  // Font size of the toast
                        );
                      }
                    },
                    child: userChatList[index]['profile'] != null && userChatList[index]['profile'].isNotEmpty
                        ? Image.network(
                      userChatList[index]['profile'],
                      fit: BoxFit.fill,
                    )
                        : Image.asset(
                      Images.defaultProfile,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
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
                      userChatList[index]['name'],
                      style:
                          const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontFamily: appFontFamily),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    StreamBuilder(
                        stream: chatService.getMessages(Prefs.checkUserId, userChatList[index]['uid']),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            // if (userChatList[index]['message_text'] == '') {
                            return Text(
                              userChatList[index]['message_text'],
                              overflow: TextOverflow.ellipsis, // Ensures long messages are truncated
                              maxLines: 1, // Limits to 2 lines (adjust based on your design)
                              softWrap: true, // Allows message to wrap to the next line
                              style: TextStyle(
                                  color: (userChatList[index]['senderId'] == Prefs.checkUserId)
                                      ? Colors.grey
                                      : userChatList[index]['isRead']
                                          ? Colors.grey
                                          : Colors.black,
                                  fontWeight: (userChatList[index]['senderId'] == Prefs.checkUserId)
                                      ? FontWeight.normal
                                      : userChatList[index]['isRead']
                                          ? FontWeight.normal
                                          : FontWeight.bold),
                            );
                          }
                          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                            userChatList[index]['message_text'] = "No messages yet";
                            userChatList[index]['message_time'] =
                                Timestamp.fromDate(DateTime.now().subtract(const Duration(days: 500)));
                            userChatList[index]['senderId'] = '';
                            userChatList[index]['isRead'] = true;

                            return Text(userChatList[index]['message_text'],
                                style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.normal));
                          }

                          lastMessageDoc = snapshot.data?.docs.last;
                          var lastMessageData = lastMessageDoc.data() as Map<String, dynamic>;

                          if (userChatList[index]['message_text'] !=
                              chatService.decryptMessage(lastMessageData['message'], 'my_secure_passphrase')) {
                            userChatList[index]['message_text'] =
                                chatService.decryptMessage(lastMessageData['message'], 'my_secure_passphrase');
                            userChatList[index]['message_time'] = lastMessageData['timestamp'];
                            userChatList[index]['senderId'] = lastMessageData['senderId'];
                            userChatList[index]['isRead'] = lastMessageData['isRead'];
                            shortList();
                          } else {
                            userChatList[index]['message_text'] =
                                chatService.decryptMessage(lastMessageData['message'], 'my_secure_passphrase');
                            userChatList[index]['message_time'] = lastMessageData['timestamp'];
                            userChatList[index]['senderId'] = lastMessageData['senderId'];
                            userChatList[index]['isRead'] = lastMessageData['isRead'];
                          }

                          return Text(
                            userChatList[index]['message_text'] ?? "",
                            overflow: TextOverflow.ellipsis, // Ensures long messages are truncated
                            maxLines: 1, // Limits to 2 lines (adjust based on your design)
                            softWrap: true, // Allows message to wrap to the next line
                            style: TextStyle(
                                color: (userChatList[index]['senderId'] == Prefs.checkUserId)
                                    ? Colors.grey
                                    : userChatList[index]['isRead']
                                        ? Colors.grey
                                        : Colors.black,
                                fontWeight: (userChatList[index]['senderId'] == Prefs.checkUserId)
                                    ? FontWeight.normal
                                    : userChatList[index]['isRead']
                                        ? FontWeight.normal
                                        : FontWeight.bold),
                          );
                        }),
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
                .doc("${Prefs.checkUserId}_${userChatList[index]['uid']}")
                .collection('messages')
                .doc(lastMessageDoc.id) // Use the ID of the last document
                .update({'isRead': true});

            FirebaseFirestore.instance
                .collection("chat_rooms")
                .doc("${userChatList[index]['uid']}_${Prefs.checkUserId}")
                .collection('messages')
                .doc(lastMessageDoc.id)
                .update({'isRead': true});
          }
          Get.toNamed(Routes.chat, arguments: {
            'receiverName': userChatList[index]['name'],
            'receiverId': userChatList[index]['uid'],
            'profile': userChatList[index]['profile']
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
          const SizedBox(
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
                      child: pendingRequestData.requestSentUserDetails?[0].guestProfileImage != null
                          ? Image.network(
                              ApiUrls.imageUrl +
                                  (pendingRequestData.requestSentUserDetails?[0].guestProfileImage ?? ""),
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
                      "${pendingRequestData.requestSentUserDetails?[0].firstName ?? ""} "
                          "${pendingRequestData.requestSentUserDetails?[0].lastName ?? ""}",
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
                      "${(pendingRequestData.requestSentUserDetails?[0].designation != null && pendingRequestData.requestSentUserDetails?[0].companyName != null)
                          ? '${pendingRequestData.requestSentUserDetails?[0].designation} | ${pendingRequestData.requestSentUserDetails?[0].companyName}'
                          : (pendingRequestData.requestSentUserDetails?[0].designation ?? pendingRequestData.requestSentUserDetails?[0].companyName ?? '')}",
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

                    /*Text(
                      "${pendingRequestData.requestSentUserDetails?[0].designation ?? ""} | "
                          "${pendingRequestData.requestSentUserDetails?[0].companyName ?? ""}",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        fontFamily: appFontFamily,
                        color: AppColor.FF161616,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2, // Adjust maxLines as needed
                      softWrap: true,
                    ),*/
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
                        handlePendingRequest("accepted", pendingRequestData.sId ?? "");
                        // pendingRequestList.remove(pendingRequestData);
                      },
                      child: Container(
                        width: 100,
                        height: 35,
                        margin: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
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
                        handlePendingRequest("rejected", pendingRequestData.sId ?? "");
                        // pendingRequestList.remove(pendingRequestData);
                      },
                      child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          width: 100,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(8)),
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
                  gradient: LinearGradient(colors: AppColor.gradientColors),
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50), // Ensures image is circular
                  child: GestureDetector(
                    onTap: () {
                      // Check if the profile image is available
                      if (guestListData.guestProfileImage != null &&
                          guestListData.guestProfileImage!.isNotEmpty) {
                        // If profile image is available, show it full-screen
                        _showFullScreenImage(ApiUrls.imageUrl + guestListData.guestProfileImage!, context);
                      } else {
                        // If no profile image, show a toast message
                        Fluttertoast.showToast(
                          msg: "No profile photo",  // Toast message
                          toastLength: Toast.LENGTH_SHORT,  // Duration of toast
                          gravity: ToastGravity.CENTER,  // Position of the toast
                          backgroundColor: Colors.black12,  // Toast background color
                          textColor: Colors.black,  // Text color
                          fontSize: 16.0,  // Font size of the toast
                        );
                      }
                    },
                    child: guestListData.guestProfileImage != null &&
                        guestListData.guestProfileImage!.isNotEmpty
                        ? Image.network(
                      ApiUrls.imageUrl + guestListData.guestProfileImage!,
                      fit: BoxFit.cover, // Ensures image covers the circle
                    )
                        : Image.asset(
                      Images.defaultProfile, // Default profile image
                      fit: BoxFit.cover, // Ensures default image covers the circle
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${guestListData.firstName ?? ""} ${guestListData.lastName ?? ""}",
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
                      "${(guestListData.designation != null && guestListData.companyName != null)
                          ? '${guestListData.designation} | ${guestListData.companyName}'
                          : (guestListData.designation ?? guestListData.companyName ?? '')}",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        fontFamily: appFontFamily,
                        color: AppColor.FF161616,
                        overflow: TextOverflow.ellipsis, // Prevents overflow by showing ellipsis
                      ),
                      maxLines: 2, // Adjust maxLines as needed
                      softWrap: true,
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (sentRequestList.contains(guestListData.sId)) {
                    // Request is already sent, no action
                  } else {
                    sendRequest(guestListData.sId ?? "");
                  }
                },
                child: Container(
                  width: 120,
                  height: 35,
                  margin: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    gradient: LinearGradient(
                      colors: AppColor.gradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      sentRequestList.contains(guestListData.sId) ? "Request Sent" : "Connect",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: AppColor.white,
                          fontFamily: appFontFamily),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _showFullScreenImage(String imageUrl, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent, // Make background transparent
          child: Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // Close the dialog on tap
              },
              child: ClipOval( // Clip the image into a circle
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: 300,
                  height: 300,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _chatListItem({required String name, required String message, required String profile}) {
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
  ChatModel({required this.name, required this.message, required this.profile, required this.isInvited});
  String name;
  String message;
  String profile;
  bool isInvited;
}
