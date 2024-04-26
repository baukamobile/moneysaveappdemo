import 'package:flutter/material.dart';
import 'package:moneyapp/models/style/style.dart';
import 'package:moneyapp/profile/ProfilePage.dart';
import 'package:moneyapp/widgets/auth/login_page.dart';
import 'package:moneyapp/widgets/splitPages.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatelessWidget {
  String apiUrl = "http://172.20.102.202:8000/api/register/";
  
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> register(BuildContext context) async {
    try {
      final response = await http.post(
        // Uri.parse(apiUrl),
        Uri.parse("http://172.22.101.26:8000/api/register/"),
        body: {
          'name': nameController.text,
          'email': emailController.text,
          'password': passwordController.text,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pushReplacement(context, 
        MaterialPageRoute(builder: (context) => SplitPages()));
        // MaterialPageRoute(
        //   builder: (context) => profilePage(name: nameController.text),
        // ));
        print('Register successful!');
      } else {
        print('Register failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Register failed: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back, color: Colors.black,)),
      ),
      body: 
      
      SafeArea(
        child: ListView(
          children: [
            Image.asset('img/loginimage.jpeg'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 600,
                color: Colors.white,
                  child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
      
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      )
                      ),
                ),
          
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 600,
                color: Colors.white,
                      child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
      
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      )
                      ),
                ),
          
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 600,
                color: Colors.white,
                     child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: "Password",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
      
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      )
                      ),
                ),
          
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                // Call the login function when the "Login" container is tapped
                register(context);
              },

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: 600,
                  color: Color.fromARGB(255, 71, 186, 130),
                  child: Text(
                    "Register",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
            
             
            ),
             Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                    Text('You have accounts?', style: TextStyle(fontFamily: AutofillHints.birthday, fontWeight: FontWeight.bold, fontSize: 20),),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                      child: Text('Login', style: TextStyle(color: Colors.green[300], fontFamily: AutofillHints.birthday, fontWeight: FontWeight.bold, fontSize: 20),)),
            
                ],
              ),
            )
         
          ],
        ),
      ),

    );
  }
}






