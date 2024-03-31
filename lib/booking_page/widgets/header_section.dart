import 'package:flutter/material.dart';

import '../values/numbers.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  final double imageSize = 52;
  final double iconsSize = 18;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: imageSize,
          height: imageSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00C4FF).withOpacity(0.7),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Image.asset(
            'assets/images/joker.png',
            width: imageSize,
            height: imageSize,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'JOKER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: appDefaultFontSizes,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Image.asset('assets/images/ic_calendar.png',
                        width: iconsSize, height: iconsSize),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      'DECEMBER 04, 2020',
                      style: TextStyle(
                          color: Color(0xffA2A2A2),
                          fontSize: appDefaultFontSizes),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Image.asset('assets/images/ic_time.png',
                        width: iconsSize, height: iconsSize),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      '20:30',
                      style: TextStyle(
                        color: Color(0xffA2A2A2),
                        fontSize: appDefaultFontSizes,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
