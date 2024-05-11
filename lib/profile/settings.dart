import 'package:flutter/material.dart';
import 'package:moneyapp/bottombar/bottombar.dart';
import 'package:moneyapp/profile/notifications/notifications.dart';


class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
    title: Text('Profile'),
    centerTitle: true,
        backgroundColor: Color.fromARGB(255, 71, 186, 130),
      ),
      
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text('Currency'),
            subtitle: Text('Change the currency'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to currency settings page
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => CurrencySettingsPage()),
              // );
            },
          ),
          // Divider(),
          // ListTile(
          //   title: Text('Notifications'),
          //   subtitle: Text('Manage notifications'),
          //   trailing: Icon(Icons.arrow_forward_ios),
          //   onTap: () {
          //     // Navigate to notifications settings page
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => NotificationPage(title: 'MoneyApp notification',))
          //     );
          //   },
          // ),
        
          Divider(),
          ListTile(
            title: Text('Privacy'),
            subtitle: Text('Manage privacy settings'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to privacy settings page
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => PrivacySettingsPage()),
              // );
            },
          ),
          Divider(),
          ListTile(
            title: Text('About'),
            subtitle: Text('Learn more about the app'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to about page
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => AboutPage()),
              // );
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}

// Currency settings page
class CurrencySettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Settings'),
      ),
      body: Center(
        child: Text('Currency Settings Page'),
      ),
    );
  }
}

// Notifications settings page
class NotificationsSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications Settings'),
      ),
      body: Center(
        child: Text('Notifications Settings Page'),
      ),
    );
  }
}

// Privacy settings page
class PrivacySettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Settings'),
      ),
      body: Center(
        child: Text('Privacy Settings Page'),
      ),
    );
  }
}

// About page
class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Center(
        child: Text('About Page'),
      ),
      bottomNavigationBar: MyBottomBar(),
    );
  }
}
