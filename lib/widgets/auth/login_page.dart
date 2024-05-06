import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moneyapp/widgets/auth/register_page.dart';
import 'package:moneyapp/widgets/splitPages.dart';
import 'dart:core';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final String apiUrl = 
  // "http://192.168.192.204:8000/api/login/";
  "http://172.20.103.61:8000/api/login/";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  final http.Client client = http.Client();

Future<void> login(BuildContext context) async {
  try {
    final response = await client.post(
      Uri.parse(apiUrl),
      body: {
        'email': emailController.text,
        'password': passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SplitPages()),
      );
      print('Login successful!');
    } else {
      print('Login failed with status code: ${response.statusCode}');
    }
  } on SocketException catch (e) {
    print('SocketException: Failed to connect to the server. Error: $e');
  } on HttpException catch (e) {
    print('HttpException: Failed to fetch data. Error: $e');

  } on FormatException catch (e) {
    print('FormatException: Invalid server response. Error: $e');

  } catch (e) {
    print('Unexpected error during login: $e');

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
      backgroundColor: Colors.white,
      body: 
      SafeArea(
        child: ListView(
          children: [
            Image.asset('img/loginimage.jpeg', width: 300,),
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
                    hintText: 'Password',
                    
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
                login(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: 600,
                  color: Color.fromARGB(255, 71, 186, 130),
                  child: Text(
                    "Login",
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
                    Text('You dont have any accounts?', style: TextStyle(color: Colors.black, fontFamily: AutofillHints.birthday, fontWeight: FontWeight.bold, fontSize: 20),),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterPage()));
                      },
                      child: Text('Register', style: TextStyle(color: Colors.green[300],fontFamily: AutofillHints.birthday, fontWeight: FontWeight.bold, fontSize: 20),)),
            
                ],
              ),
            )
         
          ],
        ),
      ),

    );
  }
}


//ip address 172.22.101.255
// http://127.0.0.1:8000/api/login/

//  python3 manage.py runserver 172.22.101.26:8000 this my ip adress 
// in library. If i open my hotspot i will write ifconfig and search my
//ip adress