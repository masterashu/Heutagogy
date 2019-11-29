import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:heutagogy/data_models.dart';
import 'lesson_detail.dart';

class LessonsPage extends StatelessWidget {
  final String data;

  LessonsPage(this.data);

  @override
  Widget build(BuildContext context) {
    return _LessonsPage(data);
  }
}

class _LessonsPage extends StatefulWidget {
  final String data;

  _LessonsPage(this.data);

  @override
  _LessonsPageState createState() => _LessonsPageState(data);
}

class _LessonsPageState extends State<_LessonsPage> {
  _LessonsPageState(String data) {
    var lessons = json.decode(utf8.decode(data.codeUnits));
    for (var x in lessons) {
      lessonsData.add(LessonData.fromJSON(x));
    }
    print("No of Lessons = ${lessonsData.length}");
  }

  List<LessonData> lessonsData = [];

  Widget lessonsBuilder(BuildContext context, int index) {
    if (index == 0) {
      return Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        // child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: TextField(
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search',
                          suffixIcon: Icon(Icons.search),
                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 10.0),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.filter_list,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "Choose any lesson to begin",
              style: TextStyle(
                fontSize: 25,
                // fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
        // ),
      );
    } else {
      return Lesson(
        title: this.lessonsData[index - 1].title,
        summary: this.lessonsData[index - 1].introText,
        func: () {
          if (index >= 0 && index <= this.lessonsData.length) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LessonDetail(
                          this.lessonsData[index - 1],
                          id: index,
                        )));
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: AppBar(),
      body: ListView.builder(
        itemCount: this.lessonsData.length + 1,
        itemBuilder: lessonsBuilder,
      ),
    );
  }
}

class Lesson extends StatefulWidget {
  final String title;
  final String summary;
  final Function func;

  Lesson({Key key, this.title, this.summary, this.func}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LessonState(title, summary, func);
}

class LessonState extends State<Lesson> {
  String title;
  String summary;
  double progress;
  Function func;

  @override
  void initState() {
    super.initState();
    progress = Random().nextDouble();
  } 

  LessonState(this.title, this.summary, this.func);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 3,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.blueAccent, style: BorderStyle.solid, width: 1.0),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: InkWell(
          splashColor: Color.fromARGB(40, 0, 0, 200),
          onTap: func,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Nunito',
                  ),
                ),
              ),
              Divider(
                color: Colors.black87,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Text(
                  summary,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Nunito',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
