import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/services/movie_apis.dart';
import 'package:movie_app/services/navigation.dart';
import 'package:movie_app/widgets/my_grid_tile.dart';

import 'movie_description.dart';

class TopRated extends StatefulWidget {
  const TopRated({Key? key}) : super(key: key);

  @override
  _TopRatedState createState() => _TopRatedState();
}

class _TopRatedState extends State<TopRated> {
  bool loading = false;

  List<dynamic> _data = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      loading = true;
    });
    var response = await MovieApis.getTopRated('');
    print('Top Rated: ' + response.toString());
    if (response['results'].length > 0) {
      _data.addAll(response['results']);
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade900,
      child: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _data.isEmpty
              ? Center(
                  child: Text(
                    'Data empty',
                  ),
                )
              : GridView.builder(
                  itemCount: _data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 1 / 1.8),
                  itemBuilder: (context, index) {
                    return MyGridTile(
                      onTap: () {
                        kSelectedMovieProvider(context)
                            .setMovieName(_data[index]['original_title']);
                        Navigation.changeScreen(
                          context: context,
                          screen: MovieDescription(
                            movieID: _data[index]['id'],
                          ),
                        );
                      },
                      data: _data,
                      index: index,
                    );
                  },
                ),
    );
  }
}
