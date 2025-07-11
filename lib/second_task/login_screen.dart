

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const HeaticApp());
}

class HeaticApp extends StatelessWidget {
  const HeaticApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'Login to Heatic',
      home: const loginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}


class _loginScreenState extends State<loginScreen> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('Login to Heatic', style: TextStyle(fontSize: 22,fontFamily:'title'),),
        centerTitle:true,
        toolbarHeight: 200,
      ),
      body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
           //  SizedBox(height: 20),

                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    isDense: true,
                      hintText: "Enter Email",
                      hintStyle: TextStyle(fontFamily:'text'),
                      suffixIcon: Icon(Icons.email,size: 25,),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)
                      )),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16),

              TextFormField(

                  controller: _passwordController,
                  decoration: InputDecoration(
                    isDense: true,

                      hintText: "Password",
                      hintStyle: TextStyle(fontFamily:'text'),
                      suffixIcon: Icon(Icons.remove_red_eye_outlined,size:25,),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)
                      )),
                  obscureText: true,


                ),
                SizedBox(height: 24),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    minimumSize: const Size(double.infinity, 55),),  //
                  onPressed: (){},
                  child: Text('Login', style: TextStyle(fontFamily:'text',fontSize: 16),),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                [

                  Text("Don't have an account?",style: TextStyle(fontSize: 16,fontFamily:'text'),),
                  Text(" Sign up", style: TextStyle(fontSize: 17,color: Colors.purple,fontFamily:'title'),)
                ],)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
