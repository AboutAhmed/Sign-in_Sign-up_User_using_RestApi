import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({super.key});

  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void signup(String email, password)async{
    try{
      Response response = await post(
        Uri.parse('https://reqres.in/api/register'),
        body:{
          'email': email,
              'password':password,
        }
      );
      if(response.statusCode==200){
        var data = jsonDecode(response.body.toString());
        print(data['id']);
        print('Account created successfully');
      }else{
        print('Failed');
      }
    }catch(e){
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          title: const Text(
            'Sign-Up & Login',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white70,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
              ),
             SizedBox(height: 20,),
             TextFormField(
               controller: passwordController,
          decoration: InputDecoration(
            hintText: 'Password',
          )
             ),
              SizedBox(height: 40,),
              GestureDetector(
                onTap:(){
                  signup(emailController.text.toString(),passwordController.text.toString());
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  height: 50,
                  child: Center(
                    child: Text('Sign-up', style: TextStyle(
                      fontSize: 20,
                    ),),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
