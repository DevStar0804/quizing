import 'package:flutter/material.dart';
import 'package:test_flutter/quizpage.dart';


class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String timevalue ="30";
  String randomvalue ="no";
  String areavalue ="all";
  String questionvalue ="8";
  String _maxquestions;
  
  Widget dropdownmenuitem(String text, String value){
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
    return MaterialApp(
      home: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Settings'),
            centerTitle: true,
          ),
          body: TabBarView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[

                  Expanded(
                    flex: 5,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[

                          Row(children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.fromLTRB(8.0, 48.0, 8.0, 8.0),
                              child: Icon(Icons.timer),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(8.0, 48.0, 8.0, 8.0),
                              child: Text(
                                'Time per Question:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top:40.0),
                              child: DropdownButton<String>(
                                items: [
                                  dropdownmenuitem('30', '30'),
                                  dropdownmenuitem('60', '60'),
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
                                      border: Border(bottom: BorderSide(color: Colors.grey))
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            
                            ),

                            
                          ],),
                          
                          Row(children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Questions Max:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Enter a number of questions.',
                                  ),
                                  // keyboardType: TextInputType.number,
                                  onChanged: (String value){
                                    setState((){
                                      _maxquestions = value;
                                    });
                                  }
                                ),
                              )
                            ),
                          ],),
                          
                          Row(children: <Widget>[
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
                                  });
                                },
                                value: areavalue,
                                underline: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey))
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: DropdownButton<String>(
                                items: [
                                  dropdownmenuitem('4', '4'),
                                  dropdownmenuitem('8', '8'),
                                  dropdownmenuitem('12', '12'),
                                  dropdownmenuitem('16', '16'),
                                ],
                                isExpanded: false,
                                onChanged: (String value) {
                                  setState(() {
                                    questionvalue = value;
                                  });
                                },
                                value: questionvalue,
                                underline: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey))
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            
                            ),

                          ],),

                          Row(children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Randomize:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                )
                              ),
                            ),
                            DropdownButton<String>(
                              items: [
                                DropdownMenuItem<String>(
                                  child: Row(
                                      children: <Widget>[
                                        Text('YES'),
                                      ],
                                  ),
                                  value: 'yes',
                                ),
                                DropdownMenuItem<String>(
                                  child: Row(
                                    children: <Widget>[
                                      Text('NO'),
                                    ],
                                  ),
                                  value: 'no',
                                ),
                              ],
                              isExpanded: false,
                              onChanged: (String value) {
                                setState(() {
                                  randomvalue = value;
                                });
                              },
                              value: randomvalue,
                              underline: Container(
                                decoration: const BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey))
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              iconSize: 16,
                            ),
                          
                          ]),

                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    flex:5,
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
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context)=>QuizPage(timevalue:timevalue, randomvalue:randomvalue, questionvalue: questionvalue)
                                  ))
                                }
                              ),
                          ],)
                        
                        ],) ,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}