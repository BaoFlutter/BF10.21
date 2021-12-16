
import 'package:az_chat/data_sources/firebase_services.dart';
import 'package:az_chat/models/app_user.dart';
import 'package:az_chat/models/room_chat.dart';
import 'package:az_chat/resources/utils/utils.dart';
import 'package:az_chat/views/conversation_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class ItemRoomChat extends StatelessWidget {
  const ItemRoomChat({
    Key? key,
    required this.roomChat,
    required this.userId,
    required this.firebaseService,
  }) : super(key: key);
  final String userId;
  final RoomChat roomChat;
  final FirebaseServices firebaseService;

  @override
  Widget build(BuildContext context) {
    String receiverId =
    roomChat.membersId!.firstWhere((element) => element != userId);
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: firebaseService.getStreamUser(receiverId),
        builder: (context, snapshot) {
          AppUser? receiver;
          if (snapshot.hasData) {
            final data = snapshot.data!.data();
            receiver = AppUser.fromJson(data!);
          }
          return receiver != null
              ? Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: InkWell(
              onTap: () {

                if (receiver != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ConversationScreen(
                            receiver: receiver!,
                            chatRoomId: roomChat.id,
                          )));
                }


              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 23,
                      backgroundColor: secondaryColor,
                      backgroundImage: receiver.photoUrl != null
                          ? NetworkImage(receiver.photoUrl!)
                          : null,
                      child: receiver.photoUrl != null
                          ? null
                          : Text(
                          Utils.nameInit(receiver.displayName ?? ""),
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue)),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(receiver.displayName ?? "",
                                    style: txtMedium(18)),
                                Spacer(),
                                Text(
                                  Utils.timeStamp(
                                      roomChat.timeStamp ?? Timestamp.now()),
                                  style: txtRegular(12),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    roomChat.message ?? "message",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: txtRegular(14),
                                  ),
                                ),
                                Expanded(flex: 1, child: Container())
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Divider()
                          ],
                        ))
                  ],
                ),
              ),
            ),
          )
              : Container();
        });
  }
}
