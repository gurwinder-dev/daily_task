
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
      title:'Create an Account',
      home: const signUpScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class signUpScreen extends StatefulWidget {
  const signUpScreen({super.key});

  @override
  State<signUpScreen> createState() => _signUpScreenState();
}

class _signUpScreenState extends State<signUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('Create an Account', style: TextStyle(fontSize: 22,fontFamily:'title'),),
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
                  controller: _fullnameController,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: "Enter your name",
                    hintStyle: TextStyle(fontFamily: 'text'),
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ), 
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      isDense: true,
                      hintText: "Enter your Email",
                      hintStyle: TextStyle(fontFamily:'text'),
                      prefixIcon: Icon(Icons.email,size: 25,),
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

                      hintText: "Enter Password",
                      hintStyle: TextStyle(fontFamily:'text'),
                      suffixIcon: Icon(Icons.remove_red_eye_rounded,size:25,),
                      prefixIcon: Icon(Icons.lock,size: 25,),
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
                  child: Text('Sign Up', style: TextStyle(fontFamily:'text',fontSize: 16),),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [

                    Text("Already have an account?",style: TextStyle(fontSize: 16,fontFamily:'text'),),
                    Text(" Login", style: TextStyle(fontSize: 17,color: Colors.purple,fontFamily:'title'),)
                  ],)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
































































































































































































