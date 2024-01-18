import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Log_in extends StatefulWidget {
  const Log_in({super.key});

  @override
  State<Log_in> createState() => _Log_inState();
}

class _Log_inState extends State<Log_in> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void Login(String email, password)async{
    try{
      Response response = await post(
          Uri.parse('https://reqres.in/api/login'),
          body:{
            'email': email,
            'password':password,
          }
      );
      if(response.statusCode==200){
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print('Login successfully');
      }else{
        print('Login Failed');
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
                  Login(emailController.text.toString(),passwordController.text.toString());
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  height: 50,
                  child: Center(
                    child: Text('Log_in', style: TextStyle(
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
