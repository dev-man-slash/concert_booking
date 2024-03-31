import 'package:concert_booking/booking_page/bloc/bloc.dart';
import 'package:concert_booking/booking_page/widgets/curved_line/curved_line_animated.dart';
import 'package:concert_booking/booking_page/widgets/total_price.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'values/colors.dart';
import 'widgets/header_section.dart';
import 'widgets/seats/seats_grid.dart';
import 'widgets/seats/seats_guide.dart';
import 'widgets/seats/selected_seats.dart';
import 'bloc/seats_bloc.dart';
import 'extensions.dart';

class UiChallenge1 extends StatefulWidget {
  const UiChallenge1({super.key});

  @override
  State<UiChallenge1> createState() => _UiChallenge1State();
}

class _UiChallenge1State extends State<UiChallenge1> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: primaryColor,
        // accentColor: accentColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.josefinSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      child: BlocProvider<SeatsBloc>(
        blocBuilder: () => SeatsBloc(),
        child: Builder(
          builder: (context) {
            return Scaffold(
              backgroundColor: bgColor,
              body: Center(
                child: SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 28,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: HeaderSection(),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        child: AnimatedCurveLine(
                          colorsToAnimate: [
                            sceneColor1,
                            sceneColor2,
                            sceneColor3,
                            sceneColor4
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      const SeatsGrid(),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        height: 0.7,
                        color: const Color(0xffA2A2A2).withOpacity(0.3),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: SeatsGuideWidget(),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      const Expanded(
                        child: SelectedSeatsWidget(),
                      ),
                      StreamBuilder(
                        stream: BlocProvider.of<SeatsBloc>(context)
                            .onAnythingChanged(),
                        builder: (context, value) {
                          final seatsBloc = BlocProvider.of<SeatsBloc>(context);
                          final selectedItems = seatsBloc.getSelectedItems();
                          return Column(
                            children: [
                              if (selectedItems.isNotEmpty) ...[
                                const SizedBox(
                                  height: 4,
                                ),
                                TotalPrice(
                                  price: selectedItems.totalPrice(),
                                ),
                              ],
                              Container(
                                width: double.infinity,
                                height: 46,
                                margin: const EdgeInsets.only(
                                  left: 42,
                                  right: 42,
                                  top: 16,
                                  bottom: 22,
                                ),
                                child: ElevatedButton(
                                  onPressed: selectedItems.isNotEmpty
                                      ? () {
                                          setState(() {
                                            seatsBloc.clearAllItems();
                                          });
                                        }
                                      : null,
                                  child: const Text(
                                    "CONFIRM SEATS",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                  // color: accentColor,
                                  // disabledColor: accentColor.withOpacity(0.1),
                                ),
                              ),
                            ],
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
