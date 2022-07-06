import 'package:flutter/material.dart';

class SurveyItem extends StatelessWidget {
  const SurveyItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark,
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 1),
              spreadRadius: 0,
              blurRadius: 2,
              color: Colors.black,
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          children: const [
            Text(
              '20/08/2020',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Qual seu framework web favorito?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
