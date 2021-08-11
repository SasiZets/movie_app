import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/screens/movies_by_people.dart';
import 'package:movie_app/services/movie_apis.dart';

class Actor extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String peopleID;
  const Actor(
      {Key? key,
      required this.imageUrl,
      required this.peopleID,
      required this.name})
      : super(key: key);

  @override
  _ActorState createState() => _ActorState();
}

class _ActorState extends State<Actor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: DefaultTabController(
        length: 2,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              bottom: TabBar(
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.movie,
                      color: Colors.white,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.tv,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff285578),
                        Color(0xff494477),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Hero(
                        tag: widget.imageUrl,
                        child: Container(
                          height: 150,
                          width: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              100.0,
                            ),
                            child: CachedNetworkImage(
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                              imageUrl: MovieApis.getImage(
                                widget.imageUrl,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        widget.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: TabBarView(
                  children: [
                    MoviesByPeople(peopleID: widget.peopleID),
                    Center(
                      child: Text(
                        'No Api Found',
                        style: kHeadingStyle,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
