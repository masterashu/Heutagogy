import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heutagogy/data_models.dart';
import 'package:heutagogy/tests/test1.dart';
import 'package:heutagogy/tests/test2.dart';
import 'package:heutagogy/tests/test3.dart';
import 'package:heutagogy/tests/test4.dart';
import 'package:heutagogy/tests/test5.dart';
import 'dart:math';

class MyLesson1Tests extends StatefulWidget {
  final LessonData lessonData;

  MyLesson1Tests(this.lessonData);

  @override
  Lesson1TestsState createState() => Lesson1TestsState(lessonData);
}

class Lesson1TestsState extends State<MyLesson1Tests> {
  LessonData lessonData;
  List<Step> mySteps;

  Lesson1TestsState(LessonData data){
    this.lessonData = data;
    this.mySteps = [];
    int maxLength = [
      lessonData.test1.length,
      lessonData.test2.length,
      lessonData.test3.length,
      lessonData.test4.length,
    ].reduce(max);
    for (int z = 0; z < maxLength; z++) {
      if (lessonData.test1 != null && z < lessonData.test1.length) {
        mySteps.add(Step(
          title: Text(''),
          content: Test1Page(lessonData.test1[z]),
          isActive: true,
          state: StepState.indexed,
        ));
      }
      if (lessonData.test2 != null && z < lessonData.test2.length) {
        mySteps.add(Step(
          title: Text(''),
          content: Test2Page(lessonData.test2[z]),
          isActive: true,
          state: StepState.indexed,
        ));
      }
      // if (lessonData.test5 != null && z < lessonData.test5.length) {
      //   mySteps.add(Step(
      //     title: Text(''),
      //     content: Test5Page(lessonData.test5[z]),
      //     isActive: true,
      //     state: StepState.indexed,
      //   ));
      // }
      if (lessonData.test3 != null && z < lessonData.test3.length) {
        mySteps.add(Step(
          title: Text(''),
          content: new Test3Page(
            lessonData.test3[z],
          ),
          isActive: true,
          state: StepState.indexed,
        ));
      }
      if (lessonData.test4 != null && z < lessonData.test4.length) {
        mySteps.add(Step(
          title: Text(''),
          content: Test4Page(lessonData.test4[z]),
          isActive: true,
          state: StepState.indexed,
        ));
      }
    }

//    mySteps.add(Step(
//      title: Text(''),
//      content: Test5Page(),
//      isActive: true,
//      state: StepState.indexed,
//    ));
  }

  int currentStep = 0;

  onStepTapped(step) {
    setState(() {
      currentStep = step;
    });
    print("On Step Tapped: " + step.toString());
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          (lessonData == null) ? "" : lessonData.title,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Theme(
        data: ThemeData(
          canvasColor: Colors.white,
        ),
        child: Stepper(
          type: StepperType.horizontal,
          currentStep: this.currentStep,
          onStepTapped: onStepTapped,
          steps: mySteps,
          controlsBuilder: (BuildContext context,
              {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
            return Row(
              children: <Widget>[
                Container(
                  child: null,
                ),
                Container(
                  child: null,
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: (showFab
          ? Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: FloatingActionButton.extended(
                      backgroundColor: Colors.white,
                      splashColor: Colors.lightBlueAccent,
                      heroTag: 'NextStep',
                      onPressed: () {
                        if (currentStep < mySteps.length - 1) {
                          setState(() {
                            currentStep = currentStep + 1;
                          });
                        } else {
                          Navigator.popUntil(context,
                              ModalRoute.withName(Navigator.defaultRouteName));
                        }
                      },
                      label: Text(
                        "Next",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue, width: 1),
                          borderRadius: BorderRadius.circular(40)),
                      icon: Icon(
                        Icons.navigate_next,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      splashColor: Colors.lightBlueAccent,
                      heroTag: 'PreviousStep',
                      onPressed: () {
                        if (currentStep > 0) {
                          setState(() {
                            currentStep = currentStep - 1;
                          });
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      shape: CircleBorder(
                          side: BorderSide(color: Colors.blue, width: 1)),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : null),
    );
  }
}