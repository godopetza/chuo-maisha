import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'models.dart';

class Match extends Equatable {
  final String userId;
  final User matchedUser;
  final List<Chat>? chat;

  const Match({
    required this.userId,
    required this.matchedUser,
    this.chat,
  });

  static Match fromSnapshot(DocumentSnapshot snap, String userId) {
    Match match = Match(
      userId: userId,
      matchedUser: User.fromSnapshot(snap),
    );
    return match;
  }

  Match copyWith({
    String? userId,
    User? matchedUser,
    List<Chat>? chat,
  }) {
    return Match(
      matchedUser: matchedUser ?? this.matchedUser,
      userId: userId ?? this.userId,
      chat: chat ?? this.chat,
    );
  }

  @override
  List<Object?> get props => [userId, matchedUser, chat];

  static List<Match> matches = [
    Match(
      userId: '1',
      matchedUser: User.users[1],
      // chat: Chat.chats
      //     .where((chat) => chat.userId == 1 && chat.matchedUserId == 2)
      //     .toList(),
    ),
    Match(
      userId: '1',
      matchedUser: User.users[2],
      // chat: Chat.chats
      //     .where((chat) => chat.userId == 1 && chat.matchedUserId == 3)
      //     .toList(),
    ),
    Match(
      userId: '1',
      matchedUser: User.users[3],
      // chat: Chat.chats
      //     .where((chat) => chat.userId == 1 && chat.matchedUserId == 4)
      //     .toList(),
    ),
    Match(
      userId: '1',
      matchedUser: User.users[4],
      // chat: Chat.chats
      //     .where((chat) => chat.userId == 1 && chat.matchedUserId == 5)
      //     .toList(),
    ),
    Match(
      userId: '1',
      matchedUser: User.users[5],
      // chat: Chat.chats
      //     .where((chat) => chat.userId == 1 && chat.matchedUserId == 6)
      //     .toList(),
    ),
    Match(
      userId: '1',
      matchedUser: User.users[6],
      // chat: Chat.chats
      //     .where((chat) => chat.userId == 1 && chat.matchedUserId == 7)
      //     .toList(),
    ),
    Match(
      userId: '1',
      matchedUser: User.users[7],
      // chat: Chat.chats
      //     .where((chat) => chat.userId == 1 && chat.matchedUserId == 8)
      //     .toList(),
    ),
    Match(
      userId: '1',
      matchedUser: User.users[8],
      // chat: Chat.chats
      //     .where((chat) => chat.userId == 1 && chat.matchedUserId == 9)
      //     .toList(),
    ),
  ];
}
