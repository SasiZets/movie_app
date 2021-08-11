import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/screens/actor.dart';
import 'package:movie_app/services/movie_apis.dart';
import 'package:movie_app/services/navigation.dart';
import 'package:movie_app/widgets/bottom_card.dart';
import 'package:movie_app/widgets/designer_card.dart';

class MovieDescription extends StatefulWidget {
  final int movieID;
  const MovieDescription({Key? key, required this.movieID}) : super(key: key);

  @override
  _MovieDescriptionState createState() => _MovieDescriptionState();
}

class _MovieDescriptionState extends State<MovieDescription> {
  bool loading = false;
  List<Widget> genres = [];
  String type = '';

  final formatCurrency = new NumberFormat.simpleCurrency();

  Map<String, dynamic> _data = {};
  Map<String, dynamic> _similarData = {};

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      loading = true;
    });
    var response = await MovieApis.getMovieDescription(
        'append_to_response=credits',
        movieID: widget.movieID.toString());
    var similarResponse = await MovieApis.getSimilarMovies('',
        movieID: widget.movieID.toString());
    print('Movie Description: ' + response.toString());
    print('Similar Movies: ' + similarResponse.toString());
    if (response['success'] == null) {
      _data.addAll(response);
    }
    if (similarResponse['success'] == null) {
      _similarData.addAll(similarResponse);
    }
    _data['genres'].toList().forEach((e) {
      genres.add(DesignerCard(
        color: Colors.grey.shade600,
        text: (e['name']).toString(),
      ));
      type += (e['name'] + ', ');
    });
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _data.isEmpty
              ? Center(
                  child: Text(
                    'Data empty',
                  ),
                )
              : CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      expandedHeight: 204.75,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: false,
                        background: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  MovieApis.getImage(_data['backdrop_path']),
                              fit: BoxFit.cover,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.grey.shade900,
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.transparent,
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 8.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        DesignerCard(
                                          color: Colors.deepOrangeAccent,
                                          text: _data['release_date']
                                              .toString()
                                              .substring(0, 4),
                                        ),
                                        DesignerCard(
                                          color: Colors.deepOrangeAccent,
                                          text: (_data['vote_average'])
                                              .toString(),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      _data['original_title'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: genres,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => BottomCard(),
                            );
                          },
                          child: Text(
                            'BOOK-TICKET',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                              right: 16.0,
                              top: 16.0,
                            ),
                            child: Text(
                              'SYNOPSIS',
                              style: kHeadingStyle,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Text(
                              _data['overview'],
                              style: kContentStyle,
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            height: 220,
                            padding: EdgeInsets.all(
                              16,
                            ),
                            color: Colors.grey.shade800,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Cast',
                                  style: kHeadingStyle,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                SizedBox(
                                  height: 165,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: _data['credits']['cast'][index]
                                                    ['profile_path'] ==
                                                null
                                            ? SizedBox()
                                            : InkWell(
                                                onTap: () {
                                                  Navigation.changeScreen(
                                                    context: context,
                                                    screen: Actor(
                                                      name: _data['credits']
                                                              ['cast'][index]
                                                          ['original_name'],
                                                      imageUrl: _data['credits']
                                                              ['cast'][index]
                                                          ['profile_path'],
                                                      peopleID: _data['credits']
                                                                  ['cast']
                                                              [index]['id']
                                                          .toString(),
                                                    ),
                                                  );
                                                },
                                                child: Stack(
                                                  children: [
                                                    GridTile(
                                                      child: Hero(
                                                        tag: _data['credits']
                                                                ['cast'][index]
                                                            ['profile_path'],
                                                        child:
                                                            CachedNetworkImage(
                                                          placeholder:
                                                              (context, _) =>
                                                                  Image.asset(
                                                            'images/placeholder.jpg',
                                                          ),
                                                          imageUrl: MovieApis.getImage(
                                                              _data['credits'][
                                                                          'cast']
                                                                      [index][
                                                                  'profile_path']),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 165,
                                                      width: 110,
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Colors
                                                                .grey.shade900,
                                                            Colors.transparent,
                                                            Colors.transparent,
                                                          ],
                                                          begin: Alignment
                                                              .bottomCenter,
                                                          end: Alignment
                                                              .topCenter,
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      child: SizedBox(
                                                        width: 110,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                _data['credits']
                                                                            [
                                                                            'cast']
                                                                        [index][
                                                                    'original_name'],
                                                                style:
                                                                    kContentStyle,
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .person,
                                                                    color: Colors
                                                                        .deepOrangeAccent,
                                                                    size: 14,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 4,
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      _data['credits']['cast']
                                                                              [
                                                                              index]
                                                                          [
                                                                          'character'],
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            12,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                      );
                                    },
                                    itemCount: _data['credits']['cast'].length,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                              right: 16.0,
                              top: 16.0,
                            ),
                            child: Text(
                              'About',
                              style: kHeadingStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Original Title:',
                                        style: kSubHeadingStyle,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        _data['original_title'],
                                        style: kSubHeadingStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Status:',
                                        style: kSubHeadingStyle,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        _data['status'],
                                        style: kSubHeadingStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Runtime:',
                                        style: kSubHeadingStyle,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        (((_data['runtime'] ~/ 60) == 0)
                                                ? ''
                                                : '${_data['runtime'] ~/ 60}h') +
                                            ' ${_data['runtime'] % 60}m',
                                        style: kSubHeadingStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Type:',
                                        style: kSubHeadingStyle,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        type.substring(0, type.length - 2),
                                        style: kSubHeadingStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Premiere:',
                                        style: kSubHeadingStyle,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        DateFormat().add_yMMMMd().format(
                                            DateTime.parse(
                                                _data['release_date'])),
                                        style: kSubHeadingStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'budget:',
                                        style: kSubHeadingStyle,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        '${formatCurrency.format(_data['budget'])}',
                                        style: kSubHeadingStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Revenue:',
                                        style: kSubHeadingStyle,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        '${formatCurrency.format(_data['revenue'])}',
                                        style: kSubHeadingStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Homepage:',
                                        style: kSubHeadingStyle,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: InkWell(
                                        onTap: () {
                                          kLaunchURL(_data['homepage']);
                                        },
                                        child: Text(
                                          _data['homepage'],
                                          style: TextStyle(
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'IMDB:',
                                        style: kSubHeadingStyle,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: InkWell(
                                        onTap: () {
                                          kLaunchURL(
                                              'http://www.imdb.com/title/' +
                                                  _data['imdb_id']);
                                        },
                                        child: Text(
                                          'http://www.imdb.com/title/' +
                                              _data['imdb_id'],
                                          style: TextStyle(
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(

                          Container(
                            height: 420,
                            color: Colors.grey.shade800,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'Similar',
                                    style: kHeadingStyle,
                                  ),
                                ),
                                SizedBox(
                                  height: 369,
                                  width: MediaQuery.of(context).size.width,
                                  child: GridView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            childAspectRatio: 1 / 1.5),
                                    itemBuilder: (context, index) {
                                      return GridTile(
                                        child: _similarData['results'][index]
                                                    ['poster_path'] ==
                                                null
                                            ? Image.asset(
                                                'images/placeholder.jpg',
                                              )
                                            : CachedNetworkImage(
                                                placeholder: (context, _) =>
                                                    Image.asset(
                                                  'images/placeholder.jpg',
                                                ),
                                                imageUrl: MovieApis.getImage(
                                                    _similarData['results']
                                                        [index]['poster_path']),
                                              ),
                                      );
                                    },
                                    itemCount: _similarData['results'].length,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}
