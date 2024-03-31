import 'package:concert_booking/booking_page/bloc/bloc.dart';
import 'package:concert_booking/booking_page/bloc/seats_bloc.dart';
import 'package:flutter/material.dart';
import 'seat_cell.dart';

class SeatsGrid extends StatefulWidget {
  const SeatsGrid({super.key});

  @override
  State<SeatsGrid> createState() => _SeatsGridState();
}

class _SeatsGridState extends State<SeatsGrid> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: BlocProvider.of<SeatsBloc>(context).onAnythingChanged(),
        builder: (context, snapshot) {
          final allSeats =
              BlocProvider.of<SeatsBloc>(context).getAllSeatsState();
          final rows = allSeats
              .map(
                (columnsSeat) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: makeColumns(columnsSeat),
                ),
              )
              .toList();

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: rows,
          );
        });
  }

  List<Widget> makeColumns(List<SeatModel> seats) {
    return seats
        .map(
          (seatModel) => GridSeatCell(
            model: seatModel,
            onGridSeatClicked: (model) {
              if (model.state == SeatState.Available) {
                onSelect(model);
              } else if (model.state == SeatState.Selected) {
                onDeselect(model);
              }
            },
          ),
        )
        .toList();
  }

  void onDeselect(SeatModel model) =>
      BlocProvider.of<SeatsBloc>(context).removeItem(model);

  void onSelect(SeatModel model) =>
      BlocProvider.of<SeatsBloc>(context).addItem(model);
}
