import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heutagogy/hex_color.dart';
import 'package:heutagogy/main.dart';
import 'package:heutagogy/screens/courses_screen.dart';
import 'package:heutagogy/screens/login-resources/login.dart';
import 'package:heutagogy/screens/misc-screens/profile.dart';
import 'package:heutagogy/screens/offline-screens/offline_main_screen.dart';
import 'package:heutagogy/screens/progress/progress_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                  child: Text(
                "Heutagogy",
                style: GoogleFonts.droidSerif(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              )),
              decoration: BoxDecoration(
                color: HexColor("#ed2a26"),
              ),
            ),
            ListTile(
              title: Text("Home"),
              trailing: Icon(Icons.home),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return CoursesHomeScreen();
                    },
                  ),
                );
              },
            ),
            ListTile(
              title: Text("My Profile"),
              trailing: Icon(Icons.account_circle),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ProfilePage();
                    },
                  ),
                );
              },
            ),
            ListTile(
              title: Text("Downloaded Courses"),
              trailing: Icon(Icons.download_sharp),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return OfflineMainScreen();
                    },
                  ),
                );
              },
            ),
            ListTile(
              title: Text("My Progress"),
              trailing: Icon(Icons.assignment_turned_in),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ProgressScreen();
                    },
                  ),
                );
              },
            ),
            ListTile(
              title: Text("Settings"),
              trailing: Icon(Icons.settings),
            ),
            ListTile(
              title: Text("Logout"),
              trailing: Icon(Icons.logout),
              onTap: () async {
                final credentialsStorage = await SharedPreferences.getInstance();
                credentialsStorage.remove('rollNumber');
                credentialsStorage.remove('password');
                credentialsStorage.remove('photoURL');
                credentialsStorage.remove('name');
                credentialsStorage.remove('courses');
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      );
  }
}