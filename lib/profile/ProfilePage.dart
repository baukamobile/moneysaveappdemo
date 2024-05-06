import 'package:flutter/material.dart';
import 'package:moneyapp/bottombar/bottombar.dart';
import 'package:moneyapp/widgets/auth/login_page.dart';

class profilePage extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  String name;
  profilePage({required this.name});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (ctx)=>LoginPage()));
          }, icon: Icon(Icons.logout, color: Colors.white,))
        ],
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 71, 186, 130),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('img/plane.png'),
            ),
            SizedBox(height: 20),
            Text(
              
              'Hello',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Flutter Developer',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 20),
            _buildInfoCard(Icons.email, 'Email', 'johndoe@example.com'),

            _buildInfoCard(Icons.location_on, 'Location', 'New York, USA'),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomBar(),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String subtitle) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
