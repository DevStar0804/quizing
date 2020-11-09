import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:test_flutter/result.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // this function is called before the build so that
    // and now we return the FutureBuilder to load and decode JSON
    return FutureBuilder(
      future: DefaultAssetBundle.of(context)
          .loadString("assets/examplecsvjson.json", cache: false),
      builder: (context, snapshot) {
        Map<String, dynamic> mydata = json.decode(snapshot.data.toString());

        if (mydata == null) {
          return Scaffold(
            body: Center(
              child: Text(
                "Loading",
              ),
            ),
          );
        } else {
          mydata.forEach((key, value) => {
                value['answer a'] = value['answer a'].toString(),
                value['answer b'] = value['answer b'].toString(),
                value['answer c'] = value['answer c'].toString(),
                value['answer d'] = value['answer d'].toString(),
                value['area'] = value['area'].toString(),
              });
          return SettingPage(mydata: mydata);
        }
      },
    );
  }
}

class SettingPage extends StatefulWidget {
  final Map<String, dynamic> mydata;
  SettingPage({Key key, @required this.mydata}) : super(key: key);
  @override
  _SettingPageState createState() => _SettingPageState(mydata);
}

class _SettingPageState extends State<SettingPage> {
  final Map<String, dynamic> mydata;
  _SettingPageState(this.mydata);

  Map<String, dynamic> questiondata;
  String timevalue = "30";
  String randomvalue = "no";
  String areavalue = "all";
  String questionvalue = "1";

  Color colortoshow = Colors.indigoAccent;
  Color right = Colors.green;
  Color wrong = Colors.red;
  int marks = 0;
  int i = 1;
  bool process = false;
  bool disableAnswer = false;
  int correct = 0;
  int incorrect = 0;
  int maxquestion = 1;

  // extra varibale to iterate
  int j = 1;
  int p = 0;
  int timer = 30;
  String showtimer = "30";
  var random_array;
  Timer test;
  var incorrect_array = [];
  int _currentValue = 1;

  Map<String, Color> btncolor = {
    "answer a": Colors.indigoAccent,
    "answer b": Colors.indigoAccent,
    "answer c": Colors.indigoAccent,
    "answer d": Colors.indigoAccent,
  };

  bool canceltimer = false;

  genrandomarray() {
    var distinctIds = [];
    var rand = new Random();
    var l = 1;
    for (int i = 0;;) {
      if (this.randomvalue == "yes")
        distinctIds.add(rand.nextInt(maxquestion) * 1 + 1);
      else {
        distinctIds.add(l);
        l++;
      }
      random_array = distinctIds.toSet().toList();
      incorrect_array = distinctIds.toSet().toList();
      if (random_array.length < int.parse(this.questionvalue)) {
        continue;
      } else {
        break;
      }
    }
    setState(() {
      i = random_array[0];
      // incorrect_array = random_array;
    });
    print(random_array);
  }

  void starttest() {
    this.process = true;
    starttimer();
    genrandomarray();
  }

  @override
  void initState() {
    this.maxquestion = mydata.length;
    this.questiondata = mydata;
    // this.questionvalue = mydata.length.toString();
    super.initState();
  }

  // overriding the setstate function to be called only if mounted
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void starttimer() async {
    const onesec = Duration(seconds: 1);
    timer = int.parse(this.timevalue);
    showtimer = this.timevalue;
    test = Timer.periodic(onesec, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          nextquestion();
        } else if (canceltimer == true) {
          t.cancel();
        } else {
          timer = timer - 1;
        }
        showtimer = timer.toString();
      });
    });
  }

  void nextquestion() {
    canceltimer = false;
    timer = int.parse(this.timevalue);
    setState(() {
      p++;
      if (j < int.parse(this.questionvalue)) {
        i = random_array[j];
        j++;
      } else {
        print(incorrect_array);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ResultPage(
              marks: marks,
              correct: correct,
              questionvalue: questionvalue,
              incorrect: incorrect,
              incorrect_array: incorrect_array,
              questiondata: questiondata),
        ));
      }
      btncolor["answer a"] = Colors.indigoAccent;
      btncolor["answer b"] = Colors.indigoAccent;
      btncolor["answer c"] = Colors.indigoAccent;
      btncolor["answer d"] = Colors.indigoAccent;
      disableAnswer = false;
    });
    starttimer();
  }

  void checkanswer(String k) {
    // in the previous version this was
    // mydata["1"]['correct'] == k
    // which i forgot to change
    // so nake sure that this is now corrected
    if (test != null) {
      if ('answer ' + questiondata[i.toString()]['correct'] == k) {
        // just a print sattement to check the correct working
        // debugPrint(mydata[2][i.toString()] + " is equal to " + mydata[1][i.toString()][k]);
        marks = marks + 5;
        // changing the color variable to be green
        colortoshow = right;
        correct++;
        incorrect_array.removeWhere((item) => item == i);
      } else {
        // just a print sattement to check the correct working
        // debugPrint(mydata[2]["1"] + " is equal to " + mydata[1]["1"][k]);
        colortoshow = wrong;
        incorrect++;
      }
      setState(() {
        // applying the changed color to the particular button that was selected
        btncolor[k] = colortoshow;
        canceltimer = true;
        disableAnswer = true;
      });
      // nextquestion();
      // changed timer duration to 1 second
      Timer(Duration(seconds: 1), nextquestion);
    }
  }

  Widget choicebutton(String k) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: MaterialButton(
        onPressed: () => checkanswer(k),
        child: Text(
          questiondata[i.toString()][k],
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Alike",
            fontSize: 16.0,
          ),
          maxLines: 1,
        ),
        color: btncolor[k],
        splashColor: Colors.indigo[700],
        highlightColor: Colors.indigo[700],
        minWidth: screenWidth * 0.35,
        height: 45.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }

  Widget dropdownmenuitem(String text, String value) {
    return DropdownMenuItem<String>(
      child: Row(
        children: <Widget>[
          Text(text),
        ],
      ),
      value: value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context);
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {
            if (tabController.index == 0) {
              if (test != null) {
                test.cancel();
                setState(() {
                  process = false;
                });
              }
            }
            // Your code goes here.
            // To get index of current tab use tabController.index
          }
        });
        return Scaffold(
          appBar: tabController.index == 0
              ? AppBar(
                  backgroundColor: Theme.of(context).cursorColor,
                  title: Text('Settings'),
                  centerTitle: true,
                )
              : null,
          body: TabBarView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 6,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              const Padding(
                                padding:
                                    EdgeInsets.fromLTRB(8.0, 48.0, 8.0, 8.0),
                                child: Icon(Icons.timer),
                              ),
                              const Padding(
                                padding:
                                    EdgeInsets.fromLTRB(8.0, 48.0, 8.0, 8.0),
                                child: Text(
                                  'Time per Question:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 40.0),
                                child: DropdownButton<String>(
                                  items: [
                                    dropdownmenuitem('30', '30'),
                                    dropdownmenuitem('60', '5'),
                                    dropdownmenuitem('90', '90'),
                                    dropdownmenuitem('120', '120'),
                                    dropdownmenuitem('150', '150'),
                                    dropdownmenuitem('180', '180'),
                                  ],
                                  isExpanded: false,
                                  onChanged: (String value) {
                                    setState(() {
                                      timevalue = value;
                                    });
                                  },
                                  value: timevalue,
                                  underline: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey))),
                                  ),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Max Questions :',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  '${this.maxquestion.toString()}',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              )),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Category:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: DropdownButton<String>(
                                  items: [
                                    dropdownmenuitem('All', 'all'),
                                    dropdownmenuitem('1', '1'),
                                    dropdownmenuitem('2', '2'),
                                    dropdownmenuitem('3', '3'),
                                    dropdownmenuitem('4', '4'),
                                  ],
                                  isExpanded: false,
                                  onChanged: (String value) {
                                    setState(() {
                                      areavalue = value;
                                      if (value == 'all') {
                                        questiondata = mydata;
                                        maxquestion = mydata.length;
                                      } else {
                                        questiondata = new Map();
                                        int n = 1;
                                        mydata.forEach((key, data) {
                                          if (data['area'] == value) {
                                            questiondata[n.toString()] = data;
                                            n++;
                                          }
                                        });
                                        maxquestion = questiondata.length;
                                      }
                                    });
                                  },
                                  value: areavalue,
                                  underline: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey))),
                                  ),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'N. of Questions:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new NumberPicker.horizontal(
                                        listViewHeight: 30,
                                        initialValue: int.parse(questionvalue),
                                        minValue: 1,
                                        maxValue: maxquestion,
                                        onChanged: (newValue) => setState(() =>
                                            questionvalue =
                                                newValue.toString())),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Randomize:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  )),
                            ),
                            new Radio(
                              value: 'yes',
                              groupValue: randomvalue,
                              onChanged: (value) {
                                setState(() {
                                  randomvalue = value;
                                });
                              },
                            ),
                            new Text(
                              'YES',
                              style: new TextStyle(fontSize: 16.0),
                            ),
                            new Radio(
                              value: 'no',
                              groupValue: randomvalue,
                              onChanged: (value) {
                                setState(() {
                                  randomvalue = value;
                                });
                              },
                            ),
                            new Text(
                              'NO',
                              style: new TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 36,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(35),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.blue,
                                              blurRadius: 2.0,
                                              spreadRadius: 2.5),
                                        ]),
                                    child: const Text(
                                      'Play Quiz',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  onTap: () => {
                                        if (int.parse(this.questionvalue) <=
                                            this.maxquestion)
                                          {
                                            starttest(),
                                            Timer(Duration(seconds: 1), () {
                                              tabController.index = 1;
                                            })
                                          }
                                      }),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              process
                  ? Column(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            child: Center(
                              child: Text(
                                i.toString() + '/${this.questionvalue}',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.topCenter,
                            child: Center(
                              child: Text(
                                showtimer,
                                style: TextStyle(
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Times New Roman',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.all(15.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              questiondata[i.toString()]['question'],
                              style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: "Quando",
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text('dfd'),
                        ),
                        Expanded(
                          flex: 4,
                          child: AbsorbPointer(
                            absorbing: disableAnswer,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      choicebutton('answer a'),
                                      choicebutton('answer b'),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      choicebutton('answer c'),
                                      choicebutton('answer d'),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Click the Play Quiz!',
                          style: TextStyle(fontSize: 32),
                        )
                      ],
                    ),
            ],
          ),
        );
      }),
    );
  }
}
