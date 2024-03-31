import 'package:concert_booking/booking_page/bloc/seats_bloc.dart';
import 'package:concert_booking/booking_page/values/numbers.dart';
import 'package:concert_booking/booking_page/widgets/seats/seat_cell.dart';
import 'package:flutter/material.dart';

class SeatsGuideWidget extends StatelessWidget {
  const SeatsGuideWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        makeHint('SELECTED', SeatState.Selected),
        makeHint('RESERVED', SeatState.Reserved),
        makeHint('AVAILABLE', SeatState.Available),
      ],
    );
  }

  Widget makeHint(String text, SeatState state) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: appDefaultFontSizes,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        SeatCell(state),
      ],
    );
  }
}