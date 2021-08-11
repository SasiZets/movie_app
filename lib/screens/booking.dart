import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';

class Booking extends StatefulWidget {
  final int noOfSeats;

  const Booking({Key? key, required this.noOfSeats}) : super(key: key);

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  List<String> selectedSeatsNames = [];
  List<bool> selectedSeats = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i <= 35; i++) selectedSeats.add(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              kSelectedMovieProvider(context).getMovieName(),
            ),
            Text(
              '${widget.noOfSeats} Ticket${widget.noOfSeats == 1 ? '' : 's'}',
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey.shade900,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Screen',
                style: kContentStyle,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
            ),
            itemBuilder: (context, index) => makeSelectableContainer(
                getSeatNumber(
                  index,
                ),
                index),
            itemCount: 36,
          ),
          selectedSeatsNames.length == widget.noOfSeats
              ? ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  child: Text(
                    'Book',
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  String getSeatNumber(int index) {
    int _num = index + 1;
    if (_num >= 1 && _num <= 6) return 'A$_num';
    if (_num >= 7 && _num <= 12) return 'B${_num - 6}';
    if (_num >= 13 && _num <= 18) return 'C${_num - 12}';
    if (_num >= 19 && _num <= 24) return 'D${_num - 18}';
    if (_num >= 25 && _num <= 30) return 'E${_num - 24}';
    if (_num >= 31 && _num <= 36) return 'F${_num - 30}';
    return '';
  }

  Widget makeSelectableContainer(String text, int index) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (selectedSeatsNames.length >= widget.noOfSeats &&
                !selectedSeats[index])
            ? () {}
            : () {
                !selectedSeats[index]
                    ? selectedSeatsNames.add(text)
                    : selectedSeatsNames.remove(text);
                selectedSeats[index] = !selectedSeats[index];
                setState(() {});
              },
        child: Container(
          decoration: BoxDecoration(
            color: selectedSeats[index] ? Colors.teal : Colors.transparent,
            border: Border.all(
              color: Colors.teal,
              width: 3.0,
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
