import 'package:flutter/material.dart';
import 'package:movie_app/screens/popular.dart';
import 'package:movie_app/screens/top_rated.dart';
import 'package:movie_app/screens/upcoming.dart';
import 'package:movie_app/widgets/drawer_tile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        drawer: Drawer(
          child: Container(
            color: Colors.grey.shade900,
            child: ListView(
              children: [
                DrawerHeader(
                  padding: EdgeInsets.zero,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff245276),
                          Color(0xff504B7C),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                ),
                DrawerTile(
                  iconData: Icons.movie,
                  text: 'Movies',
                ),
                DrawerTile(
                  iconData: Icons.live_tv,
                  text: 'TV Shows',
                ),
                DrawerTile(
                  iconData: Icons.chair,
                  text: 'Discover',
                ),
                DrawerTile(
                  iconData: Icons.person,
                  text: 'Popular People',
                ),
                Divider(),
                DrawerTile(
                  iconData: Icons.access_alarm,
                  text: 'Reminders',
                ),
                Divider(),
                DrawerTile(
                  iconData: Icons.help,
                  text: 'Contact Developer',
                ),
                DrawerTile(
                  iconData: Icons.help,
                  text: 'Google+ Community',
                ),
                DrawerTile(
                  iconData: Icons.lock_open,
                  text: 'Unlock Pro',
                ),
                DrawerTile(
                  iconData: Icons.settings,
                  text: 'Settings',
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          bottom: TabBar(tabs: [
            Tab(
              text: 'POPULAR',
            ),
            Tab(
              text: 'TOP-RATED',
            ),
            Tab(
              text: 'UPCOMING',
            ),
          ]),
          title: Text(
            'Book Movie',
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
              ),
            ),
          ],
        ),
        body: const TabBarView(
          children: [
            Popular(),
            TopRated(),
            Upcoming(),
          ],
        ),
      ),
    );
  }
}
