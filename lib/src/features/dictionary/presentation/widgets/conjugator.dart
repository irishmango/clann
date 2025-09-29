import 'package:clann/theme.dart';
import 'package:flutter/material.dart';

class Conjugator extends StatelessWidget {
  const Conjugator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 2)
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Text("Present Tense (An Aimsir Láithreach)", style: Theme.of(context).textTheme.titleMedium),
          ),
          SizedBox(height: 26),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("rithim"),
                  SizedBox(height: 12),
                  Text("riheann tú"),
                  SizedBox(height: 12),
                  Text("ritheann sé/sí"),
                  SizedBox(height: 12),
                  Text("rihimid"),
                  SizedBox(height: 12),
                  Text("ritheann sibh"),
                  SizedBox(height: 12),
                  Text("ritheann siad"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("I run"),
                  SizedBox(height: 12),
                  Text("you run"),
                  SizedBox(height: 12),
                  Text("he/she runs"),
                  SizedBox(height: 12),
                  Text("we run"),
                  SizedBox(height: 12),
                  Text("you (plural) run"),
                  SizedBox(height: 12),
                  Text("they run"),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
