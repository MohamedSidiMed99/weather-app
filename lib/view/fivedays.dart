
import 'package:flutter/material.dart';
import 'package:weatherapptest/model/sixdays.dart';

class FiveDaysList extends StatelessWidget {
   FiveDaysList({required this.sixdays,this.index});
  List<FiveDaysResponse> sixdays;
  int? index;



  @override
  Widget build(BuildContext context) {
    return  Card(
              child: Container(
                  width: 150,
                  child: Center(
                      child: Text("")
                  )));
  }
}
