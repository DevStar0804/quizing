import 'package:flutter/material.dart';
import 'package:test_flutter/settings.dart';

class ResultPage extends StatelessWidget {
  // final List<Question> questions;
  // final Map<int, dynamic> answers;
  final int marks;
  final String questionvalue;
  final int correct;
  final int incorrect;
  final List incorrect_array;
  final Map<String, dynamic> mydata;

  // int correctAnswers;
  ResultPage({Key key, @required this.questionvalue, @required this.marks, this.correct, this.incorrect, this.incorrect_array, this.mydata}): super(key: key);
  
  Widget explanationcard(BuildContext context, int number, String explanation){
    final TextStyle titleStyle = TextStyle(
        color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.w500);
    final TextStyle trailingStyle = TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold);
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(5.0),
        title: Text("Total Questions", style: titleStyle),
        trailing: Text("${this.questionvalue}", style: trailingStyle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // this.answers.forEach((index,value){
    //   if(this.questions[index].correctAnswer == value)
    //     correct++;
    // });
    final TextStyle titleStyle = TextStyle(
        color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.w500);
    final TextStyle trailingStyle = TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold);

    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.face_retouching_natural)),
                Tab(icon: Icon(Icons.flight_land)),
              ],
            ),
            title: Text('Result', style: TextStyle(fontSize:20),),
            elevation: 0,
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).accentColor
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(5.0),
                          title: Text("Total Questions", style: titleStyle),
                          trailing: Text("${this.questionvalue}", style: trailingStyle),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(5.0),
                          title: Text("Score", style: titleStyle),
                          trailing: Text("${this.marks.toString()}", style: trailingStyle),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(5.0),
                          title: Text("Correct Answers", style: titleStyle),
                          trailing: Text("${this.correct.toString()}", style: trailingStyle),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(5.0),
                          title: Text("Incorrect Answers", style: titleStyle),
                          trailing: Text("${this.incorrect.toString()}", style: trailingStyle),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(5.0),
                          title: Text("Not Answered", style: titleStyle),
                          trailing: Text("${int.parse(this.questionvalue)-this.incorrect-this.correct}", style: trailingStyle),
                        ),
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).accentColor
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(5.0),
                          title: Text("Total Questions", style: titleStyle),
                          trailing: Text("${this.questionvalue}", style: trailingStyle),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(5.0),
                          title: Text("Score", style: titleStyle),
                          trailing: Text("${this.marks.toString()}", style: trailingStyle),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(5.0),
                          title: Text("Correct Answers", style: titleStyle),
                          trailing: Text("${this.correct.toString()}", style: trailingStyle),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(5.0),
                          title: Text("Incorrect Answers", style: titleStyle),
                          trailing: Text("${this.incorrect.toString()}", style: trailingStyle),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(5.0),
                          title: Text("Not Answered", style: titleStyle),
                          trailing: Text("${int.parse(this.questionvalue)-this.incorrect-this.correct}", style: trailingStyle),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RaisedButton(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: Theme.of(context).accentColor.withOpacity(0.8),
                            child: Text("Goto Home"),
                            onPressed: () => {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ))
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
