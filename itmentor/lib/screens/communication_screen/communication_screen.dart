import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class CommunicationScreen extends StatefulWidget {
  final String token;

  const CommunicationScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<CommunicationScreen> createState() => _CommunicationScreenState();
}

class _CommunicationScreenState extends State<CommunicationScreen> {
  List<ChatRoom> chatRooms = [];

  @override
  void initState() {
    super.initState();
    _fetchChatData();
  }

  Future<void> _fetchChatData() async {
    final url = Uri.https(Constants.uri, '/chat');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${widget.token}'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      debugPrint("$responseData");
      setState(() {
        chatRooms =
            responseData.map((data) => ChatRoom.fromJson(data)).toList();
      });
    } else {
      print('Failed to load chat data: ${response.statusCode}');
      // Handle the error if the API call fails
      // You can display an error message or handle it as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nhắn tin'),
        backgroundColor: Color.fromARGB(255, 94, 157, 144),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: chatRooms.length,
        itemBuilder: (BuildContext context, int index) {
          return ChatTile(
            chatRoom: chatRooms[index],
            token: widget.token,
            fetchChatData: _fetchChatData,
          );
        },
      ),
    );
  }
}

class ChatTile extends StatefulWidget {
  final ChatRoom chatRoom;
  final String token;
  final VoidCallback fetchChatData; // Callback to fetch chat data

  ChatTile(
      {required this.chatRoom,
      required this.token,
      required this.fetchChatData});

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
            widget.chatRoom.participants[0].id == user.id
                ? widget.chatRoom.participants[1].avatar
                : widget.chatRoom.participants[0].avatar),
      ),
      title: Text(
        widget.chatRoom.participants[0].id == user.id
            ? widget.chatRoom.participants[1].name
            : widget.chatRoom.participants[0].name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(widget.chatRoom.latestMessage),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailScreen(
              chatRoom: widget.chatRoom,
              token: widget.token,
            ),
          ),
        ).then((value) {
          // This block will be executed when returning from ChatDetailScreen
          if (value != null && value) {
            widget
                .fetchChatData(); // Recall the "get all chats" API using the callback
          }
        });
      },
    );
  }
}

class ChatDetailScreen extends StatefulWidget {
  final ChatRoom chatRoom;
  final String token;

  ChatDetailScreen({required this.chatRoom, required this.token});

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  late io.Socket socket;
  final TextEditingController _messageController = TextEditingController();
  late StreamController<List<ChatMessage>> _messagesController;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Initialize the stream controller
    _messagesController = StreamController<List<ChatMessage>>.broadcast(
      onListen: () {},
      onCancel: () {},
    );

    // Fetch messages before connecting to the socket
    _fetchMessages().then((initialData) {
      if (mounted) {
        _messagesController.add(initialData);
      }
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    });

    socket = io.io(
      'https://pbl6-production.up.railway.app',
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
        'extraHeaders': {'Authorization': 'Bearer ${widget.token}'},
      },
    );

    _initSocketListeners();
    socket.connect();
  }

  void _initSocketListeners() {
    socket.onConnect((_) {
      print('Socket connected: ${socket.id}');
      print('Socket connected status: ${socket.connected}');
      // Join the room when connected
      socket.emit('room');
    });

    socket.onDisconnect((_) {
      print('Socket disconnected');
    });

    socket.onConnectError((data) {
      debugPrint("connect failed");
    });

    socket.on('newMessage', (data) async {
      debugPrint('New Message: $data');
      // Fetch new messages
      final messages = await _fetchMessages();
      // Check if the stream controller is still open
      if (!_messagesController.isClosed) {
        // Add the new messages to the stream
        _messagesController.add(messages);
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  Future<List<ChatMessage>> _fetchMessages() async {
    final chatId = widget.chatRoom.id;
    debugPrint("$chatId");
    final url = Uri.https(Constants.uri, '/chat/$chatId');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${widget.token}'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      return responseData.map((data) => ChatMessage.fromJson(data)).toList();
    } else {
      print('Failed to load chat messages: ${response.statusCode}');
      return [];
    }
  }

  Future<void> _sendMessage() async {
    final url = Uri.https(Constants.uri, '/message');

    final data = {
      "text": _messageController.text,
      "chat": widget.chatRoom.id,
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.token}',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      // Send the 'newMessage' event to the room
      socket.emit('newMessage', {'room': widget.chatRoom.id});
      _messageController.clear();
      debugPrint("send message success");
    } else {
      print(
          'Failed to send message: ${response.statusCode} - - ${response.body}');
    }
  }

  @override
  void dispose() {
    _messagesController.close(); // Close the stream controller
    socket.disconnect(); // Disconnect the socket when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return WillPopScope(
      onWillPop: () async {
        socket.disconnect();
        // Signal to the previous screen that we want to refresh the chat list
        Navigator.pop(context, true);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.chatRoom.participants[0].id == user.id
                ? widget.chatRoom.participants[1].name
                : widget.chatRoom.participants[0].name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color.fromARGB(255, 94, 157, 144),
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<ChatMessage>>(
                stream: _messagesController
                    .stream, // Use _messagesController.stream here
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading messages'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No messages available'));
                  } else {
                    return Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                      ),
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, int index) {
                          final message = snapshot.data![index];
                          final isMyMessage = message.senderId == user.id;

                          return ChatMessageWidget(
                            message: message,
                            isMyMessage: isMyMessage,
                            chatRoom: widget.chatRoom,
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () async {
                        _sendMessage();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessageWidget extends StatelessWidget {
  final ChatMessage message;
  final bool isMyMessage;
  final ChatRoom chatRoom;

  ChatMessageWidget({
    required this.message,
    required this.isMyMessage,
    required this.chatRoom,
  });

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment:
            isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMyMessage)
            CircleAvatar(
              backgroundImage: NetworkImage(
                message.senderId == user.id
                    ? chatRoom.participants[0].avatar
                    : chatRoom.participants[1].avatar,
              ),
            ),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: isMyMessage ? Colors.blue : Colors.grey,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                message.text,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final String senderId;

  ChatMessage({required this.text, required this.senderId});

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      text: json['text'] ?? '',
      senderId: json['sender']['_id'] ?? '', // Update to get sender's ID
    );
  }
}

class ChatRoom {
  final String id;
  final List<Participant> participants;
  final String createdAt;
  final String updatedAt;
  final String latestMessage;
  final bool seen;
  final String sender;

  ChatRoom({
    required this.id,
    required this.participants,
    required this.createdAt,
    required this.updatedAt,
    required this.latestMessage,
    required this.seen,
    required this.sender,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      id: json['_id'] ?? '',
      participants: List<Participant>.from(json['participants']
          .map((participant) => Participant.fromJson(participant))),
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      latestMessage: json['latest_message'] ?? '',
      seen: json['seen'] ?? false,
      sender: json['sender'] ?? '',
    );
  }
}

class Participant {
  final String id;
  final String name;
  final String avatar;

  Participant({
    required this.id,
    required this.name,
    required this.avatar,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['_id'],
      name: json['name'],
      avatar: json['avatar'],
    );
  }
}
