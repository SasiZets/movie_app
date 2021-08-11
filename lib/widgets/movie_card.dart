import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';

class MovieCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String genre;
  final String rating;
  final String year;

  const MovieCard(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.genre,
      required this.rating,
      required this.year})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CachedNetworkImage(
            placeholder: (context, _) => Image.asset(
              'images/placeholder_banner.jpg',
              fit: BoxFit.fitWidth,
            ),
            imageUrl: imageUrl,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.grey.shade900,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Text(
                      rating,
                      style: kContentStyle,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Icon(
                      Icons.star,
                      size: 17.5,
                      color: Colors.white,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      'Action, Crime, Thriller',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Text(
                      year,
                      style: kContentStyle,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
