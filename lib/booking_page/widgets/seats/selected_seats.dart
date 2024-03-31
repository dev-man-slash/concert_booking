import 'package:concert_booking/booking_page/bloc/bloc.dart';
import 'package:concert_booking/booking_page/bloc/seats_bloc.dart';
import 'package:concert_booking/booking_page/values/numbers.dart';
import 'package:flutter/material.dart';

import 'seat_cell.dart';

class SelectedSeatsWidget extends StatefulWidget {
  const SelectedSeatsWidget({super.key});

  @override
  State<SelectedSeatsWidget> createState() => _SelectedSeatsWidgetState();
}

class _SelectedSeatsWidgetState extends State<SelectedSeatsWidget> {
  GlobalKey<AnimatedListState> _myListKey = GlobalKey<AnimatedListState>();
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final seatsBloc = BlocProvider.of<SeatsBloc>(context);
    seatsBloc
        .onItemsCleared()
        .listen((List<MapEntry<SeatModel, int>> removedItems) {
      setState(() {
        _myListKey = GlobalKey<AnimatedListState>();
      });
    });
    seatsBloc
        .onItemAdded()
        .listen((MapEntry<SeatModel, int> insertedModelIndex) {
      final index = insertedModelIndex.value;
      _myListKey.currentState!.insertItem(index);
      Future.delayed(const Duration(milliseconds: 50))
          .then((value) => _scrollToEnd());
    });
    seatsBloc
        .onItemRemoved()
        .listen((MapEntry<SeatModel, int> removedModelIndex) {
      final model = removedModelIndex.key;
      final index = removedModelIndex.value;
      _myListKey.currentState!.removeItem(index,
          (context, animation) => removeAnimated(context, animation, model));
    });
  }

  void _scrollToEnd() {
    if (!_scrollController.hasClients) {
      return;
    }

    var scrollPosition = _scrollController.position;

    if (scrollPosition.maxScrollExtent > scrollPosition.minScrollExtent) {
      _scrollController.animateTo(
        scrollPosition.maxScrollExtent,
        duration: new Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  Widget removeAnimated(context, animation, model) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, widget) {
        return Transform.scale(
          scale: animation.value,
          child: SelectedSeatItemWidget(model: model),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: StreamBuilder(
                stream: BlocProvider.of<SeatsBloc>(context).onAnythingChanged(),
                builder: (context, snapshot) {
                  final isEmpty = BlocProvider.of<SeatsBloc>(context)
                      .getSelectedItems()
                      .isEmpty;
                  return Text(
                    isEmpty ? '' : 'YOUR SELECTED SEATS :',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: appDefaultFontSizes,
                    ),
                  );
                }),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: AnimatedList(
            controller: _scrollController,
            key: _myListKey,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index, animation) {
              final items =
                  BlocProvider.of<SeatsBloc>(context).getSelectedItems();
              return AnimatedBuilder(
                animation: animation,
                builder: (context, widget) {
                  return Transform.scale(
                    scale: animation.value,
                    child: SelectedSeatItemWidget(model: items[index]),
                  );
                },
              );
            },
            initialItemCount:
                BlocProvider.of<SeatsBloc>(context).getSelectedItems().length,
          ),
        ),
      ],
    );
  }
}

class SelectedSeatItemWidget extends StatelessWidget {
  final SeatModel model;

  const SelectedSeatItemWidget({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      margin: const EdgeInsets.only(bottom: 1),
      color: const Color(0xff0F1143),
      child: Row(
        children: [
          const SeatCell(SeatState.Selected),
          const SizedBox(
            width: 6,
          ),
          Text(
            'ROW ${getRowSymbol(model.row)}, SEAT ${model.column}',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          Expanded(child: Container()),
          Text(
            '${model.price.toDouble().toStringAsFixed(2)} \$',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  getRowSymbol(int row) => 'ABCDEFGH'[row];
}
