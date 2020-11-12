import 'package:flutter/material.dart';
import 'package:quiz/settings.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class ResultPage extends StatefulWidget {
  final String total; // current total questions
  final String ptotal; // previous total questions
  final String area; // current category
  final String parea; // previous category
  final int correct; // current number of correct answers
  final String pcorrect; // previous number of correct answers
  final int incorrect; // current number of incorrect answers
  final String pincorrect; // previous number of incorrect answers
  final String pnotanswered; // previous number of not answers 
  final String pscore; // previous score
  final List incorrect_array; // current incorrect answers list
  final Map<String, dynamic> questiondata; // current quiz data

  ResultPage(
      {Key key,
      @required this.total,
      @required this.ptotal,
      @required this.area,
      @required this.parea,
      @required this.correct,
      @required this.pcorrect,
      @required this.incorrect,
      @required this.pincorrect,
      @required this.pnotanswered,
      @required this.pscore,
      @required this.incorrect_array,
      @required this.questiondata})
      : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  // explanations widget
  List<Widget> explanations() {
    this.widget.incorrect_array.sort();
    var index = 0;
    // explanations title
    final widgets = List<Widget>()
      ..add(Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(24),
        child: Text(
          'Total Questions: ${this.widget.total}',
          style: TextStyle(
              color: Colors.lime,
              fontSize: 22,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic),
        ),
      ));
    // explanations container
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
        // explanation
        ..addAll(
          this.widget.incorrect_array.map((i) {
            index++;
            return detail(
                index, i, this.widget.questiondata['$i']['explanation']);
          }),
        );
    }
    return widgets;
  }

  //explanation widget
  Widget detail(int number, int index, String explanation) {
    String correct = "answer ${this.widget.questiondata['$index']['correct']}";
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: CircleAvatar(
                backgroundColor: Colors.deepPurple,
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
                  child: Text(
                      '${this.widget.questiondata[index.toString()]["question"]}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center),
                )),
          ],
        ),
        
        Row(
          children: <Widget>[
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      '${this.widget.questiondata[index.toString()][correct]}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
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
              child: Text('$explanation'),
            ),
          ],
        )
      ],
    );
  }

  // this function is called when click the save button
  // save the result data
  resultsave() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('${this.widget.area}total', this.widget.total);
    prefs.setString('${this.widget.area}correct', this.widget.correct.toString());
    prefs.setString('${this.widget.area}incorrect', this.widget.incorrect.toString());
    prefs.setString('${this.widget.area}notanswered',(int.parse(this.widget.total) -this.widget.incorrect -this.widget.correct).toString());
    prefs.setString('${this.widget.area}score',(this.widget.correct / int.parse(this.widget.total) * 100).toInt().toString());
    prefs.setString('${this.widget.area}', this.widget.area);
  }

  // this function is called when click the reset button
  // initialize the previous result data
  resultreset() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('${this.widget.area}total', '');
    prefs.setString('${this.widget.area}correct', '');
    prefs.setString('${this.widget.area}incorrect', '');
    prefs.setString('${this.widget.area}notanswered','');
    prefs.setString('${this.widget.area}score','');
  }

  // overriding the setstate function to be called only if mounted
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  // overriding the main page
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final TextStyle titleStyle = TextStyle(
        color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.w500);
    final TextStyle currentStyle = TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold);
    final TextStyle previousStyle = TextStyle(
        color: Theme.of(context).cursorColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold);

    return DefaultTabController(
      length: 2,
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context);
        tabController.addListener(() {});
        return Scaffold(
          body: TabBarView(
            children: <Widget>[
              // previous and current result tab
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Theme.of(context).cursorColor,
                  Theme.of(context).cursorColor
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 16.0),
                  child: Column(
                    children: <Widget>[
                      // total questions container
                      Container(
                        height: screenHeight * 0.13,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          elevation: 10,
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Total Questions", style: titleStyle),
                              Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    this.widget.ptotal!=''
                                        ? Expanded(
                                            flex: 5,
                                            child: Center(
                                                child: Text(
                                                    "${this.widget.ptotal}",
                                                    style: previousStyle)))
                                        : Text(' '),
                                    Expanded(
                                        flex: 5,
                                        child: Center(
                                            child: Text("${this.widget.total}",
                                                style: currentStyle))),
                                  ])
                            ],
                          )),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      // score container
                      Container(
                        height: screenHeight * 0.13,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          elevation: 10,
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Score", style: titleStyle),
                              Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    this.widget.pscore!=''
                                        ? Expanded(
                                            flex: 5,
                                            child: Center(
                                                child: Text(
                                                    "${this.widget.pscore}%",
                                                    style: previousStyle)))
                                        : Text(' '),
                                    Expanded(
                                        flex: 5,
                                        child: Center(
                                            child: Text(
                                                "${(this.widget.correct / int.parse(this.widget.total) * 100).toInt()}%",
                                                style: currentStyle))),
                                  ])
                            ],
                          )),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      // correct answers container
                      Container(
                        height: screenHeight * 0.13,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          elevation: 10,
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Correct Answers", style: titleStyle),
                              Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    this.widget.pcorrect!=''
                                        ? Expanded(
                                            flex: 5,
                                            child: Center(
                                                child: Text(
                                                    "${this.widget.pcorrect}",
                                                    style: previousStyle)))
                                        : Text(' '),
                                    Expanded(
                                        flex: 5,
                                        child: Center(
                                            child: Text(
                                                "${this.widget.correct.toString()}",
                                                style: currentStyle))),
                                  ])
                            ],
                          )),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      // incorrect answers container
                      Container(
                        height: screenHeight * 0.13,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          elevation: 10,
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Incorrec Answers", style: titleStyle),
                              Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    this.widget.pincorrect!=''
                                        ? Expanded(
                                            flex: 5,
                                            child: Center(
                                                child: Text(
                                                    "${this.widget.pincorrect}",
                                                    style: previousStyle)))
                                        : Text(' '),
                                    Expanded(
                                        flex: 5,
                                        child: Center(
                                            child: Text(
                                                "${this.widget.incorrect.toString()}",
                                                style: currentStyle))),
                                  ])
                            ],
                          )),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      // not answers container
                      Container(
                        height: screenHeight * 0.13,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          elevation: 10,
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Not Answered", style: titleStyle),
                              Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    this.widget.pnotanswered!=''
                                        ? Expanded(
                                            flex: 5,
                                            child: Center(
                                                child: Text(
                                                    "${this.widget.pnotanswered}",
                                                    style: previousStyle)))
                                        : Text(' '),
                                    Expanded(
                                        flex: 5,
                                        child: Center(
                                            child: Text(
                                                "${int.parse(this.widget.total) - this.widget.incorrect - this.widget.correct}",
                                                style: currentStyle))),
                                  ])
                            ],
                          )),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      // explanation button 
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                              width: screenWidth * 0.7,
                              height: screenHeight * 0.08,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  "Explanation",
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                onPressed: () => {tabController.index = 1},
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              //---------------------------

              // explanation result tab
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Theme.of(context).cursorColor,
                  Theme.of(context).cursorColor
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // expalnations list
                      ...explanations(),
                      // buttons container
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                                width: screenWidth * 0.2,
                                child: RaisedButton(
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
                                width: screenWidth * 0.2,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Text("Quit"),
                                  onPressed: () => {
                                    exit(0),
                                  },
                                )),
                            SizedBox(
                                width: screenWidth * 0.2,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Text("Save"),
                                  onPressed: () => {resultsave()},
                                )),
                            SizedBox(
                                width: screenWidth * 0.2,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Text("Reset"),
                                  onPressed: () => {resultreset()},
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //---------------------------
            ],
          ),
        );
      }),
    );
  }
}
