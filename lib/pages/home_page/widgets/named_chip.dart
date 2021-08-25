import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NamedChipWidget extends StatelessWidget {
  const NamedChipWidget({Key? key, this.labelText, this.valueText}) : super(key: key);

  final String? labelText;
  final String? valueText;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              labelText?.toLowerCase() ?? '~',
              style: GoogleFonts.asap(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(color: Colors.white10),
            child: Text(
              valueText?.toLowerCase() ?? '~',
              style: GoogleFonts.asap(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
