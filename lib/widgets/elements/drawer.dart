// import 'package:flutter/material.dart';
// import 'package:moneyapp/profile/settings.dart';
// import 'package:moneyapp/widgets/auth/login_page.dart';

// class CustomDrawer extends StatelessWidget {
  
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Container(
//         color: Colors.white, // Background color of the drawer
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Color.fromARGB(255, 71, 186, 130),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Text(
//                     'Menu',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Your App Name',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.home,
//                 color: Colors.black,
//               ),
//               title: Text(
//                 'Home',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 16,
//                 ),
//               ),
//               onTap: () {
//                 Navigator.pop(context); // Close the drawer
//                 Navigator.pushNamed(context, '/home'); 
//               },
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.settings,
//                 color: Colors.black,
//               ),
//               title: Text(
//                 'Settings',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 16,
//                 ),
//               ),
//               onTap: () {
//                 // Navigator.pop(context); // Close the drawer
                // Navigator.push(context, MaterialPageRoute(builder: (ctx)=> SettingsPage())); 
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsPage()));
//               },
//             ),
//             Divider(
//               color: Colors.black,
//               thickness: 0.5,
//               height: 20,
//               indent: 16,
//               endIndent: 16,
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.exit_to_app,
//                 color: Colors.black,
//               ),
//               title: Text(
//                 'Logout',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 16,
//                 ),
//               ),
//               onTap: () {
//                 Navigator.pop(context);
// Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
//                 // Perform logout action here
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:moneyapp/profile/settings.dart';
import 'package:moneyapp/widgets/auth/login_page.dart';

void main() {
  runApp(MaterialApp(
    title: 'Your App Name',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    initialRoute: '/', // Set the initial route
    routes: {
      '/': (context) => HomePage(), // Define the home page route
      '/settings': (context) => SettingsPage(), // Define the settings page route
      '/login': (context) => LoginPage(), // Define the login page route
    },
  ));
}
 void logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()), 
      (route) => false, 
    );
  }
class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white, // Background color of the drawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 71, 186, 130),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your App Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.black,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              title: Text(
                'Settings',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                // Navigator.pushNamed(context, '/settings');
                Navigator.push(context, MaterialPageRoute(builder: (ctx)=> SettingsPage())); 
              },
            ),
            Divider(
              color: Colors.black,
              thickness: 0.5,
              height: 20,
              indent: 16,
              endIndent: 16,
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                // Navigator.pop(context);
                // Navigator.pushNamed(context, '/login');
                                // Navigator.push(context, MaterialPageRoute(builder: (ctx)=> LoginPage())); 
                // Perform logout action here
                logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Text('Home Page Content'),
      ),
    );
  }
}
