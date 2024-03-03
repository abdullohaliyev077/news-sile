import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NeuBox extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  final String text4;
  final String imagePath1;
  final String imagePath2;
  NeuBox(
      {super.key,
      required this.imagePath1,
      required this.imagePath2,
      required this.text1,
      required this.text2,
      required this.text3,
      required this.text4});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Container(
      margin: EdgeInsets.only(right: 10),
      height: height * .5,
      width: width * .7,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.secondary,
          boxShadow: [
            //darker shadow on bottom right
            // BoxShadow(
            //     color: Colors.grey.shade500,
            //     blurRadius: 15,
            //     offset: Offset(
            //       -4,
            //       -4,
            //     )),

            // //lighter shadow on top left
            // BoxShadow(
            //     color: Colors.white,
            //     blurRadius: 15,
            //     offset: Offset(
            //       -4,
            //       -4,
            //     )),
          ]),
      child: Column(
        children: [
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath1,
                fit: BoxFit.cover,
              ),
            ),
            height: height * 0.3,
            width: width * 0.7,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12)),
          ),
          //trending +time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$text1',
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Color.fromARGB(255, 108, 108, 108),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '$text2',
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Color.fromARGB(255, 108, 108, 108),
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Text(
            maxLines: 3,
            '$text3',
            style:
                GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 14),
          Row(
            children: [
              Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      imagePath2,
                      fit: BoxFit.cover,
                    )),
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 79, 161, 250),
                    borderRadius: BorderRadius.circular(100)),
              ),
              SizedBox(width: 6),
              Text(
                'text4',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: Color.fromARGB(255, 108, 108, 108),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
