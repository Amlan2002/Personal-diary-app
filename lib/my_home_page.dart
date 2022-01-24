import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_diary_app/models/note.dart';
import 'package:personal_diary_app/services/auth.dart';
import 'package:personal_diary_app/widgets/new_note.dart';
import 'package:personal_diary_app/widgets/note_list.dart';

class MyHomePage extends StatefulWidget {
final VoidCallback onSignOut;
final AuthBase auth;
  const MyHomePage({Key? key,required this.onSignOut, required this.auth}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState(onSignOut, auth);
}
class _MyHomePageState extends State<MyHomePage> {
 
final VoidCallback onSignOut;
final AuthBase auth;

  _MyHomePageState(this.onSignOut,  this.auth);
 
  
Future<void> _singOut() async {
    try {
    await auth.signOut();
    onSignOut();
    } catch (error) {
      print(error.toString());
    }
  }

  final List<note> _usernotes = [
    // note(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // note(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];

  void addNewnote(String txTitle, String txNote, DateTime chosenDate) {
    final newTx = note(
      title: txTitle,
      date: chosenDate,
      id: DateTime.now().toString(),
      textNote: txNote,
    );

    setState(() {
      _usernotes.add(newTx);
    });
  }

  void _startAddNewnote(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: Newnote(addNewnote),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deletenote(String id) {
    setState(() {
      _usernotes.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      title: Text(
        'Personal Diary',
      ),
      actions: <Widget>[
        // IconButton(
        //   icon: Icon(Icons.add),
        //   onPressed: () => _startAddNewnote(context),
        // ),
        FlatButton(
          onPressed:_singOut,
          child: Text('Logout', style: TextStyle(fontSize:18.0, color: Colors.white,fontWeight:FontWeight.bold),),
        ),
      ],
    );
    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          1,
      child: noteList(_usernotes, _deletenote),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: txListWidget,
            )
            //else do this(: symbol use for else condition)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewnote(context),
      ),
    );
  }
}
