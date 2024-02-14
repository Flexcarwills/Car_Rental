
import 'package:flutter/material.dart';

class settingsScreen extends StatelessWidget{
   @override
    Widget build(BuildContext context){
       return Scaffold(
        appBar: AppBar(title: Text("Settings"),),
       
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Terms and Service'),
              onTap: (){
                 Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TermsAndServiceScreen()),
              );
              },
            ),

            ListTile(
              title: Text('support/Feedback'),
              onTap: () {
                Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => FeedbackScreen()),
                );
               } ,
            ),

         //   ListTile(
          //    title: Text('rate or share App'),
           //   onTap: () {
             //    Navigator.push(
            //       context,
             //      MaterialPageRoute(builder: (context) => RateorSharedscreen()),
             //   );
            //  },
           // ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => LogoutScreen()),
                );
              },
            ),
          ],
        ),
       
       );
    }
}

class TermsAndServiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Service'),
      ),
      body: Center(
        child: Text('Terms and Service Screen'),
      ),
    );
  }
}

class FeedbackScreen extends StatelessWidget{
   @override
   Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          title: Text('Feedback'),
        ),
        body: Center(
          child: Text('Feedback Screen'),
        ),
      );
   }
}

/*class RateorSharedScreenAextends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rate or Share'),
      ),
      body: Center(
        child: Text('Rate or ShareApp'),
      ),
    );
  }
}*/ 

class LogoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logout'),
      ),
      body: Center(
        child: Text('Logout  Screen'),
      ),
    );
  }
}


