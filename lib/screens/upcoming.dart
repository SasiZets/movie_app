import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/screens/movie_description.dart';
import 'package:movie_app/services/movie_apis.dart';
import 'package:movie_app/services/navigation.dart';
import 'package:movie_app/widgets/my_grid_tile.dart';

class Upcoming extends StatefulWidget {
  const Upcoming({Key? key}) : super(key: key);

  @override
  _UpcomingState createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
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
    var response = await MovieApis.getUpComing('');
    print('popular: ' + response.toString());
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
