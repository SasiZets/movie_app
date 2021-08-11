import 'package:flutter/material.dart';
import 'package:movie_app/services/movie_apis.dart';
import 'package:movie_app/widgets/movie_card.dart';

class MoviesByPeople extends StatefulWidget {
  final String peopleID;

  const MoviesByPeople({
    Key? key,
    required this.peopleID,
  }) : super(key: key);

  @override
  _MoviesByPeopleState createState() => _MoviesByPeopleState();
}

class _MoviesByPeopleState extends State<MoviesByPeople> {
  bool loading = false;

  Map<String, dynamic> _data = {};

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      loading = true;
    });
    var response = await MovieApis.getMoviesByActor(
      'sort_by=popularity.desc&include_adult=true&include_video=false&page=1&with_people=${widget.peopleID}&with_watch_monetization_types=flatrate',
    );

    print('Movie Description: ' + response.toString());

    if (response['success'] == null) {
      _data.addAll(response);
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: _data['results'].length,
            itemBuilder: (context, index) {
              List _movies = _data['results'];
              return MovieCard(
                imageUrl: MovieApis.getImage(_movies[index]['backdrop_path']),
                name: _movies[index]['original_title'],
                genre: '',
                rating: _movies[index]['vote_average'].toString(),
                year: _movies[index]['release_date'].toString().substring(0, 4),
              );
            },
          );
  }
}
