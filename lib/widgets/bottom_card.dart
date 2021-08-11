import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/screens/booking.dart';
import 'package:movie_app/services/navigation.dart';

class BottomCard extends StatefulWidget {
  const BottomCard({
    Key? key,
  }) : super(key: key);

  @override
  _BottomCardState createState() => _BottomCardState();
}

class _BottomCardState extends State<BottomCard> {
  int selectedNoOfSeats = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade900,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  'How many seats',
                  style: kContentStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: DropdownButton<int>(
                  dropdownColor: Colors.grey.shade900,
                  items: [
                    makeItem(1),
                    makeItem(2),
                    makeItem(3),
                    makeItem(4),
                  ],
                  onChanged: (int? value) {
                    setState(() {
                      selectedNoOfSeats = value!;
                    });
                  },
                  value: selectedNoOfSeats,
                ),
              )
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    makePriceCard(
                      150,
                      'Balcony',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    makePriceCard(
                      120,
                      'First-Class',
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: ElevatedButton(
              onPressed: () {
                Navigation.changeScreen(
                  context: context,
                  screen: Booking(
                    noOfSeats: selectedNoOfSeats,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              child: Text(
                'Select Seats',
                style: TextStyle(
                  fontSize: 19,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget makePriceCard(int amount, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          Text(
            '₹$amount.0',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Available',
            style: kContentStyle,
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<int> makeItem(int value) {
    return DropdownMenuItem(
      value: value,
      child: Text(
        value.toString(),
        style: kContentStyle,
      ),
    );
  }
}
