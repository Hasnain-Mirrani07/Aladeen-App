import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              color: Colors.green,
              child: const Text("container 1"),
            ),
          ),
          Wrap(children: [
            //  fit: FlexFit.loose,
            Container(
              // height: 100,
              // width: 100,
              color: Colors.yellow,
              child: const Text(
                  "contanercontainercontainontainercontainercontainercontainercontainercontainercontainercontainercontainercontainer 2"),
            ),
            const Text(
                "container,knjkkhkjhkhcontainercontainerinercontainerco;m;;lk;kntainercontainercontainercontainercontainercontainercontainercontainercontainercontainercontainer 2"),
          ]),
          Container(
            height: 500,
            width: 300,
            color: Colors.red,
            child: const Text("container 3"),
          ),
        ],
      ),
    );
  }
}
