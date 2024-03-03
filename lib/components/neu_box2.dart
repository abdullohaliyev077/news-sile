import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NeuBox2 extends StatelessWidget {
  final String imagePath1;
  final String imagePath2;
  final String text1;
  final String text2;
  final String text3;
 NeuBox2(
      {super.key,
      required this.imagePath1,
      required this.imagePath2,
      required this.text1,
      required this.text2,
      required this.text3});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath1,
                  fit: BoxFit.cover,
                ),
              ),
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.amber),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                //profile row
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            imagePath2,
                            fit: BoxFit.cover,
                          ),
                        ),
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.amber),
                      ),
                     SizedBox(width: 8),
                      Text(
                        text1,
                        style: GoogleFonts.poppins(
                            color: const Color.fromARGB(255, 108, 108, 108),
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                //description
                Text(
                  maxLines: 3,
                  text2,
                  style: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),

                //time
                Row(
                  children: [
                    Text(
                      text3,
                      style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: const Color.fromARGB(255, 108, 108, 108),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      height: 130,
      width: 330,
      decoration: BoxDecoration(
          // boxShadow: [
          //   //darker shadow on bottom right
          //   BoxShadow(
          //       color: Colors.grey.shade500,
          //       blurRadius: 18,
          //       offset: const Offset(
          //         2,
          //         2,
          //       )),

          //   //lighter shadow on top left
          //   BoxShadow(
          //       color: Colors.white,
          //       blurRadius: 15,
          //       offset: const Offset(
          //         2,
          //         2,
          //       )),
          // ],
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12)),
    );
  }
}
