import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

final FirebaseAuth _auth = FirebaseAuth.instance;

  void signOut(){
  final authService = Provider.of<AuthService>(context,listen: false);

  try{
    authService.signOut();
  }catch (e){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat app'),
      actions: [IconButton(onPressed: signOut, icon: Icon(Icons.logout))],),

      body: _buildUserList(),
    );
  }
   Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading...');
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            return _buildUserListItem(snapshot.data!.docs[index]);
          },
        );
      },
    );
  }


  Widget _buildUserListItem(DocumentSnapshot document){
    Map<String,dynamic> data = document.data()! as Map<String,dynamic>;

    if(_auth.currentUser!.email != data['email']){
      return ListTile(
        title:Text( data['email']),
        onTap: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>
          ChatPage(
            receiverUserEmail: data['email'],
            receiverUserID: data['uid'],
            
            )));
        },
      );
    }else{
      return Container();
    }
  }
}
