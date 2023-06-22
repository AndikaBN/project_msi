import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import '../room_menu.dart';

class OrderForm extends StatefulWidget {
  final Room room;

  const OrderForm({Key? key, required this.room}) : super(key: key);

  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  DateTime? _checkInDate;
  DateTime? _checkOutDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 300, vertical: 30),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Pemesanan Kamar ${widget.room.code_room}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nama',
                  ),
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Nomor Telepon',
                  ),
                ),
                const SizedBox(height: 8.0),
                LayoutBuilder(
                  builder: (context, constraint) {
                    List<String> itemStringList = [widget.room.room_type];
                    return FormField<bool>(
                      initialValue: false,
                      enabled: true,
                      builder: (FormFieldState<bool> field) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            labelText: "Tipe Kamar",
                            errorText: field.errorText,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: false,
                              child: DropdownButton<String>(
                                isExpanded: false,
                                value: widget.room.room_type,
                                icon: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Icon(
                                    Icons.arrow_drop_down_outlined,
                                    size: 24.0,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color,
                                  ),
                                ),
                                iconSize: 16,
                                elevation: 16,
                                style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .fontSize,
                                  fontFamily: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .fontFamily,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color,
                                ),
                                underline: Container(
                                  height: 0,
                                  color: Colors.grey[300],
                                ),
                                onChanged: (String? newValue) {},
                                items: itemStringList
                                    .map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 0.0,
                                          vertical: 0.0,
                                        ),
                                        child: Text(value),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  controller:
                      TextEditingController(text: widget.room.room_class),
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: "Kelas Kamar",
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                InkWell(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _checkInDate = pickedDate;
                      });
                    }
                  },
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Check In',
                      labelStyle: TextStyle(
                        color: Colors.blueGrey,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueGrey,
                        ),
                      ),
                      suffixIcon: Icon(Icons.date_range),
                      helperText: "Kapan anda mau pesan?",
                    ),
                    child: Text(
                      _checkInDate != null
                          ? DateFormat('yyyy-MM-dd').format(_checkInDate!)
                          : '',
                      style: TextStyle(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  controller: TextEditingController(text: "Jumlah Kamar"),
                  enabled: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Jumlah Kamar",
                  ),
                ),
                InkWell(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _checkOutDate = pickedDate;
                      });
                    }
                  },
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Check Out',
                      labelStyle: TextStyle(
                        color: Colors.blueGrey,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueGrey,
                        ),
                      ),
                      suffixIcon: Icon(Icons.date_range),
                      helperText: "Kapan Anda Pulang?",
                    ),
                    child: Text(
                      _checkOutDate != null
                          ? DateFormat('yyyy-MM-dd').format(_checkOutDate!)
                          : '',
                      style: TextStyle(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  controller:
                      TextEditingController(text: "Rp. ${widget.room.price}"),
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: "Kelas Kamar",
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  height: 72,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(12.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderSuccess(
                            room: widget.room,
                          ),
                        ),
                      );
                    },
                    child: Text("Pesan Sekarang"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrderSuccess extends StatelessWidget {
  final Room room;

  const OrderSuccess({Key? key, required this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                size: 100,
                color: Colors.green,
              ),
              SizedBox(height: 16.0),
              Text(
                'Pemesanan Berhasil!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Terima kasih telah memesan kamar ${room.code_room}.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MenuRoom()),
                    (route) => false,
                  );
                },
                child: Text('Kembali ke Daftar Kamar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
