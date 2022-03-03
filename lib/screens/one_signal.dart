import 'package:flutter/material.dart';
import 'dart:async';

//import OneSignal
import 'package:onesignal_flutter/onesignal_flutter.dart';



class MyOneSigmnal extends StatefulWidget {
  @override
  _MyOneSigmnalState createState() => new _MyOneSigmnalState();
}

class _MyOneSigmnalState extends State<MyOneSigmnal> {

  void configOneSignal() {
     OneSignal.shared.setAppId("6f6ca7a9-f2b0-4328-bf8e-4b006c11674f");
    //show notification content
    OneSignal.shared.setLogLevel(OSLogLevel.debug,OSLogLevel.none);
  }

  @override
  void initState() {
    super.initState();
    configOneSignal();
    //initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: const Text('OneSignal Flutter Demo'),
            backgroundColor: Color.fromARGB(255, 212, 86, 83),
          ),
          body: Container(
            padding: EdgeInsets.all(10.0),
            child: SingleChildScrollView(

            ),
          )),
    );
  }
}

// typedef void OnButtonPressed();
//
// class OneSignalButton extends StatefulWidget {
//   final String title;
//   final OnButtonPressed onPressed;
//   final bool enabled;
//
//   OneSignalButton(this.title, this.onPressed, this.enabled);
//
//   State<StatefulWidget> createState() => new OneSignalButtonState();
//  }

// class OneSignalButtonState extends State<OneSignalButton> {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return new Table(
//       children: [
//         new TableRow(children: [
//            FlatButton(
//             disabledColor: Color.fromARGB(180, 212, 86, 83),
//             disabledTextColor: Colors.white,
//             color: Color.fromARGB(255, 212, 86, 83),
//             textColor: Colors.white,
//             padding: EdgeInsets.all(8.0), onPressed: () {  },
//            // child: new Text(widget.title),
//            //onPressed: widget.enabled ? widget.onPressed : null,
//           )
//         ]),
//         new TableRow(children: [
//           Container(
//             height: 8.0,
//           )
//         ]),
//       ],
//     );
//   }
// }