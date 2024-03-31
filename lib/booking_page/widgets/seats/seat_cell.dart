import 'package:flutter/material.dart';

import '../../bloc/seats_bloc.dart';
import '../../values/colors.dart';

class GridSeatCell extends StatelessWidget {
  final Function(SeatModel)? onGridSeatClicked;
  final SeatModel model;

  const GridSeatCell({
    super.key,
    required this.model,
    this.onGridSeatClicked,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onGridSeatClicked != null
          ? () {
              onGridSeatClicked!(model);
            }
          : null,
      child: SeatCell(model.state),
    );
  }
}

class SeatCell extends StatelessWidget {
  static const double size = 12.5, margin = 4, radius = 2;
  final SeatState state;

  const SeatCell(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case SeatState.None:
        return Container(
          margin: const EdgeInsets.all(margin),
          width: size,
          height: size,
        );
      case SeatState.Reserved:
        return Container(
          margin: const EdgeInsets.all(margin),
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(radius)),
            color: primaryColor,
          ),
        );
      case SeatState.Available:
      case SeatState.Selected:
        return AvailableSeatCell(
          selected: state == SeatState.Selected,
        );
      default:
        throw ArgumentError();
    }
  }
}

class AvailableSeatCell extends ImplicitlyAnimatedWidget {
  final bool selected;

  const AvailableSeatCell({super.key, required this.selected})
      : super(duration: const Duration(milliseconds: 150), curve: Curves.linear);

  @override
  _AvailableSeatCellState createState() => _AvailableSeatCellState();
}

class _AvailableSeatCellState extends AnimatedWidgetBaseState<AvailableSeatCell> {
  Tween<double>? _scaleTween;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(SeatCell.margin),
      width: SeatCell.size,
      height: SeatCell.size,
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor, width: widget.selected ? 0 : 1.2),
        borderRadius: const BorderRadius.all(Radius.circular(SeatCell.radius)),
      ),
      child: Transform.scale(
        scale: _scaleTween?.evaluate(animation) ?? 1.0,
        child: const SelectedImage(),
      ),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _scaleTween = visitor(
      _scaleTween,
      widget.selected ? 1.0 : 0.0,
      (dynamic value) => Tween<double>(begin: widget.selected ? 1.0 : 0.0),
    ) as Tween<double>;
  }
}

class SelectedImage extends StatelessWidget {
  const SelectedImage({super.key});

  @override
  Widget build(Object context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(SeatCell.radius)),
        color: pink,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(2.8),
          child: Image.asset(
            'assets/images/ic_check.png',
            package: 'ui_challenge_1',
          ),
        ),
      ),
    );
  }
}
