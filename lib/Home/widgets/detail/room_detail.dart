import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../room_menu.dart';
import 'order_form.dart';

class DetailRoom extends StatefulWidget {
  final Room room;
  const DetailRoom({Key? key, required this.room}) : super(key: key);
  @override
  State<DetailRoom> createState() => _DetailRoomState();
}

class _DetailRoomState extends State<DetailRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 60, right: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 600.0,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(40.0),
                    ),
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/kamar/${widget.room.image}",
                      ),
                      fit: BoxFit.cover,
                      colorFilter: const ColorFilter.mode(
                          Colors.black45, BlendMode.darken),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.room.room_type,
                      style: GoogleFonts.raleway(
                        fontSize: 96,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              Row(
                children: [
                  Text(
                    "Detail ${widget.room.room_class} - ${widget.room.room_type}",
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
                height: 30.0,
              ),
              Text(
                widget.room.detail_room,
                style: GoogleFonts.inter(
                    fontSize: 24.0, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                'Sementara itu, untuk kamar ini dipatok dengan harga sekitar Rp ${widget.room.price} per malam.',
                style: GoogleFonts.inter(
                    fontSize: 24.0, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 50.0,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 500.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
                items: [
                  "assets/detailroom/${widget.room.detail1}",
                  "assets/detailroom/${widget.room.detail2}",
                  "assets/detailroom/${widget.room.detail3}",
                ].map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16.0),
                          ),
                          image: DecorationImage(
                            image: AssetImage(imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                height: 72,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderForm(room: widget.room),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.shopping_cart),
                      const SizedBox(width: 8.0),
                      const Text("Pesan Sekarang"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
