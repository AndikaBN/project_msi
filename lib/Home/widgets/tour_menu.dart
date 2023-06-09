import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import '../../models/tour_model.dart';
import '../../services/tour_service.dart';

class TourMenuPage extends StatefulWidget {
  const TourMenuPage({Key? key}) : super(key: key);

  @override
  State<TourMenuPage> createState() => _TourMenuPageState();
}

class _TourMenuPageState extends State<TourMenuPage> {
  List<TourMenu> _tours = []; // Daftar tur

  @override
  void initState() {
    super.initState();
    _fetchTours(); // Panggil metode untuk mengambil data tur saat widget dibuat
  }

  Future<void> _fetchTours() async {
    try {
      TourService tourService = TourService();
      List<TourMenu> tours = await tourService.fetchTourModel();
      setState(() {
        _tours = tours;
      });
    } catch (e) {
      // Tangani kesalahan jika gagal mengambil data tur
      print('Error fetching tours: $e');
    }
  }

  @override
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
                        "assets/image/populer3.png",
                      ),
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.black45, BlendMode.darken),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Wisata List",
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
                    "Wisata",
                    style: GoogleFonts.raleway(
                        fontSize: 40.0, fontWeight: FontWeight.w700),
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
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                childAspectRatio: 16 / 12,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                children: _tours.map((menu) => _buildTourItemCard(menu)).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTourItemCard(TourMenu menu) {
    return InkWell(
      onTap: () {},
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color                (0x19000000),
                    blurRadius: 24,
                    offset: Offset(0, 11),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.asset(
                  "assets/tour/${menu.image}",
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    menu.nama_tempat,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    menu.biaya,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                menu.lokasi_tempat,
                style: TextStyle(
                  color: const Color(0xFF6A6A6A),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

