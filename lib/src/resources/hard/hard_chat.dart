class Chat {
  final String? image;
  final String? blurHash;
  final String? fullName;
  final String? lastMessage;
  final String? time;
  final int? pendingMessage;
  final bool? notification;
  Chat({
    this.fullName,
    this.image,
    this.blurHash,
    this.lastMessage,
    this.notification,
    this.pendingMessage,
    this.time,
  });
}

List<Chat> chats = [
  Chat(
    image:
        'https://avatars.githubusercontent.com/u/60530946?s=460&u=e342f079ed3571122e21b42eedd0ae251a9d91ce&v=4',
    fullName: 'lambiengcode',
    lastMessage: 'Follow github.com/hongvinhmobile',
    time: '5m',
    pendingMessage: 2,
    notification: true,
    blurHash: "LGI=0t9I~U4T^-9H-oMx0etPRjxu",
  ),
  Chat(
    image:
        'https://images.unsplash.com/photo-1516726817505-f5ed825624d8?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mnx8bW9kZWx8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    fullName: 'Kim Mich',
    lastMessage: 'Hi...Nice to meet u!',
    time: '12m',
    pendingMessage: 1,
    notification: true,
    blurHash: "L5H2EC=PM+yV0g-mq.wG9c010J}I",
  ),
  Chat(
    image:
        'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixid=MXwxMjA3fDB8MHxzZWFyY2h8M3x8bW9kZWx8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    fullName: 'Harold Nguyen',
    lastMessage: 'Fuck bitch!!!',
    time: '29m',
    pendingMessage: 4,
    notification: false,
    blurHash: "L5H2EC=PM+yV0g-mq.wG9c010J}I",
  ),
  Chat(
    image:
        'https://images.unsplash.com/photo-1481824429379-07aa5e5b0739?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NDh8fG1vZGVsfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    fullName: 'Lim Pinky',
    lastMessage: 'Okay, tommorrow',
    time: '1m',
    pendingMessage: 1,
    notification: true,
    blurHash: "L5H2EC=PM+yV0g-mq.wG9c010J}I",
  ),
  Chat(
    image:
        'https://images.unsplash.com/photo-1508606572321-901ea443707f?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NDJ8fG1vZGVsfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    fullName: 'Material',
    lastMessage: 'Do u want me?',
    time: '2h',
    pendingMessage: 0,
    notification: true,
    blurHash: "L5H2EC=PM+yV0g-mq.wG9c010J}I",
  ),
];
