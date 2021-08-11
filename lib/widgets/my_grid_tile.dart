import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/services/movie_apis.dart';

class MyGridTile extends StatelessWidget {
  const MyGridTile({
    Key? key,
    this.onTap,
    required List data,
    required this.index,
  })  : _data = data,
        super(key: key);

  final List _data;
  final int index;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              fit: BoxFit.cover,
              placeholder: (context, _) => Image.asset(
                'images/placeholder.jpg',
              ),
              imageUrl: MovieApis.getImage(
                _data[index]['poster_path'],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              _data[index]['title'].length > 30
                  ? (_data[index]['title'].toString().substring(0, 30) + '...')
                  : _data[index]['title'],
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
