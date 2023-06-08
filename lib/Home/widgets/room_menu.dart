// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:project_msi/Home/widgets/detail/room_detail.dart';

class Room {
  final String room_class;
  final String price;
  final String image;
  final String room_type;
  final String detail_room;
  final String detail1;
  final String detail2;
  final String detail3;

  Room({
    required this.room_class,
    required this.image,
    required this.price,
    required this.room_type,
    required this.detail_room,
    required this.detail1,
    required this.detail2,
    required this.detail3,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      room_class: json['room_class'],
      image: json['image'],
      price: json['price'],
      room_type: json['room_type'],
      detail_room: json['detail_room'],
      detail1: json['detail1'],
      detail2: json['detail2'],
      detail3: json['detail3'],
    );
  }
}

class ApiRoom {
  static Future<List<Room>> fetchRooms(String url) async {
    final results = await http.get(Uri.parse(url));
    if (results.statusCode == 200) {
      final data = jsonDecode(results.body)['data'];
      return List<Room>.from(data.map((room) => Room.fromJson(room)));
    } else {
      throw Exception('Failed to fetch rooms');
    }
  }
}

class MenuRoom extends StatefulWidget {
  const MenuRoom({Key? key}) : super(key: key);

  @override
  State<MenuRoom> createState() => _MenuRoomState();
}

class _MenuRoomState extends State<MenuRoom> {
  late Future<List<Room>> standartRooms;
  late Future<List<Room>> mediumRooms;
  late Future<List<Room>> vipRooms;
  @override
  void initState() {
    super.initState();
    standartRooms =
        ApiRoom.fetchRooms('http://localhost:3000/room/detail/standart');
    mediumRooms =
        ApiRoom.fetchRooms('http://localhost:3000/room/detail/medium');
    vipRooms = ApiRoom.fetchRooms('http://localhost:3000/room/detail/vip');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 60, right: 60),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 600.0,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        40.0,
                      ),
                    ),
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/image/populer1.png",
                      ),
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.black45, BlendMode.darken),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Room List",
                      style: GoogleFonts.raleway(
                        fontSize: 96,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              FutureBuilder(
                future: standartRooms,
                builder: (context, AsyncSnapshot<List<Room>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final List<Room> standartRoomList = snapshot.data!;
                    return Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Standart Room",
                              style: GoogleFonts.raleway(
                                fontSize: 40.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              height: 1,
                              width: 470,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50.0,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: standartRoomList.map((room) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailRoom(room: room)),
                                    );
                                  },
                                  child: Card(
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 300,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0x19000000),
                                                blurRadius: 24,
                                                offset: const Offset(0, 11),
                                              ),
                                            ],
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                            child: Image.asset(
                                              "assets/kamar/${room.image}",
                                              fit: BoxFit.cover,
                                              alignment: Alignment.center,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 2,
                                            vertical: 10,
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                room.room_type,
                                                style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 13.0,
                                              ),
                                              Text(
                                                'Rp. ${room.price}',
                                                style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: 50.0),
              FutureBuilder(
                future: mediumRooms,
                builder: (context, AsyncSnapshot<List<Room>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final List<Room> mediumRoomList = snapshot.data!;
                    return Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Medium Room",
                              style: GoogleFonts.raleway(
                                fontSize: 40.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              height: 1,
                              width: 470,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50.0,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: mediumRoomList.map((room) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailRoom(room: room)),
                                    );
                                  },
                                  child: Card(
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 300,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0x19000000),
                                                blurRadius: 24,
                                                offset: const Offset(0, 11),
                                              ),
                                            ],
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                            child: Image.asset(
                                              "assets/kamar/${room.image}",
                                              fit: BoxFit.cover,
                                              alignment: Alignment.center,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 2,
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                room.room_type,
                                                style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 13.0,
                                              ),
                                              Text(
                                                'Rp. ${room.price}',
                                                style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                          child: Text(
                                            room.room_type,
                                            style: GoogleFonts.inter(
                                              color: const Color(0xFF6A6A6A),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: 50.0),
              FutureBuilder(
                future: vipRooms,
                builder: (context, AsyncSnapshot<List<Room>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final List<Room> vipRoomList = snapshot.data!;
                    return Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "VIP Room",
                              style: GoogleFonts.raleway(
                                fontSize: 40.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              height: 1,
                              width: 470,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50.0,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: vipRoomList.map((room) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailRoom(room: room)),
                                    );
                                  },
                                  child: Card(
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 300,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0x19000000),
                                                blurRadius: 24,
                                                offset: const Offset(0, 11),
                                              ),
                                            ],
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                            child: Image.asset(
                                              "assets/kamar/${room.image}",
                                              fit: BoxFit.cover,
                                              alignment: Alignment.center,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 2,
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                room.room_type,
                                                style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 13.0,
                                              ),
                                              Text(
                                                'Rp. ${room.price}',
                                                style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                          child: Text(
                                            room.room_type,
                                            style: GoogleFonts.inter(
                                              color: const Color(0xFF6A6A6A),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
