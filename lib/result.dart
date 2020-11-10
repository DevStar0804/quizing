import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz/settings.dart';
import 'dart:io';

class ResultPage extends StatefulWidget {
  // final List<Question> questions;
  // final Map<int, dynamic> answers;
  final String questionvalue;
  final int correct;
  final int incorrect;
  final List incorrect_array;
  final Map<String, dynamic> questiondata;

  // int correctAnswers;
  ResultPage(
      {Key key,
      @required this.questionvalue,
      @required this.correct,
      @required this.incorrect,
      @required this.incorrect_array,
      @required this.questiondata})
      : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  bool isExplanation = false;
  List<Widget> explanation() {
    this.widget.incorrect_array.sort();
    var index=0;
    final widgets = List<Widget>()
      ..add(Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(24),
        child: Text(
          'Total Questions: ${this.widget.questionvalue}',
          style: TextStyle(
              color: Colors.lime,
              fontSize: 22,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic),
        ),
      ));
    if (this.widget.incorrect_array.isNotEmpty) {
      widgets
        ..add(
          Container(
            padding: const EdgeInsets.all(8.0),
            height: 32,
            color: Colors.indigo[700],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'WRONGS: ${this.widget.incorrect_array.length}',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
        ..addAll(
          this.widget.incorrect_array.map((i) {
            print(i);
            index++;
            return detail(index, i, this.widget.questiondata['$i']['explanation']);
          }),
        );
    }
    return widgets;
  }

  Widget detail(int number, int index, String explanation) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 4.0),
              child: CircleAvatar(
                backgroundColor: Colors.cyanAccent,
                radius: 12.0,
                child: Text(
                  '$number',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      Text('${this.widget.questiondata[index.toString()]["question"]}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:16,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center),
                )),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              child: Text('${this.widget.questiondata['1']['explanation']}'),
            ),
          ],
        )
      ],
    );
  }
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final TextStyle titleStyle = TextStyle(
        color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.w500);
    final TextStyle trailingStyle = TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold);

    return DefaultTabController(
      length: 2,
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context);
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {
            if (tabController.index == 0) {
              setState(() {this.isExplanation = false;});
            }
            else setState(() {this.isExplanation = true;});
          }
          print(tabController.index == 0);
        });
        return Scaffold(
          appBar: !isExplanation
              ? AppBar(
                  backgroundColor: Theme.of(context).cursorColor,
                  title: Text(
                    'Result',
                  ),
                  elevation: 0,
                  centerTitle: true,
                )
              : null,
          body: TabBarView(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Theme.of(context).cursorColor,
                  Theme.of(context).cursorColor
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 60,
                        child:Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          elevation: 10,
                          child: ListTile(
                            title: Text("Total Questions", style: titleStyle),
                            trailing: Text("${this.widget.questionvalue}",
                                style: trailingStyle),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        height: 60,
                        child:Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          elevation: 10,
                          child: ListTile(
                            title: Text("Score", style: titleStyle),
                            trailing: Text(
                                "${(this.widget.correct / int.parse(this.widget.questionvalue) * 100).toInt()}%",
                                style: trailingStyle),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        height: 60,
                        child:Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          elevation: 10,
                          child: ListTile(
                            title: Text("Correct Answers", style: titleStyle),
                            trailing: Text("${this.widget.correct.toString()}",
                                style: trailingStyle),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        height: 60,
                        child:Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          elevation: 10,
                          child: ListTile(
                            title: Text("Incorrect Answers", style: titleStyle),
                            trailing: Text("${this.widget.incorrect.toString()}",
                                style: trailingStyle),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        height: 60,
                        child:Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          elevation: 10,
                          child: ListTile(
                            title: Text("Not Answered", style: titleStyle),
                            trailing: Text(
                                "${int.parse(this.widget.questionvalue) - this.widget.incorrect - this.widget.correct}",
                                style: trailingStyle),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                              width: screenWidth * 0.25,
                              child: RaisedButton(
                                // padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text("Again"),
                                onPressed: () => {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ))
                                },
                              )),
                          SizedBox(
                              width: screenWidth * 0.25,
                              child: RaisedButton(
                                // padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text("Quit"),
                                onPressed: () => {
                                  exit(0),
                                },
                              )),
                          SizedBox(
                              width: screenWidth * 0.25,
                              child: RaisedButton(
                                // padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text("Save"),
                                onPressed: () => {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ))
                                },
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                              width: screenWidth * 0.7,
                              child: RaisedButton(
                                // padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text("Explanation"),
                                onPressed: () => {
                                  Timer(Duration(seconds: 1),(){tabController.index = 1;})
                                  
                                },
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Theme.of(context).cursorColor,
                  Theme.of(context).cursorColor
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                child: SingleChildScrollView(
                  // padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ...explanation(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                                width: screenWidth * 0.4,
                                child: RaisedButton(
                                  // padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Text("Again"),
                                  onPressed: () => {
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ))
                                  },
                                )),
                            SizedBox(
                                width: screenWidth * 0.4,
                                child: RaisedButton(
                                  // padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Text("Quit"),
                                  onPressed: () => {
                                    exit(0),
                                  },
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
