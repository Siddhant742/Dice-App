import 'package:dice/themes/themeValue.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:dice/themes/themeController.dart';

void main() {
  return runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _themeManager.themeMode == darkTheme? darkTheme:lightTheme,
        darkTheme: darkTheme,
        themeMode: _themeManager.themeMode,
        home: MyHome()),
  );
}

ThemeManager _themeManager = ThemeManager();

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }
  @override
  void didUpdateWidget(covariant MyHome oldWidget) {
    themeListener();
    super.didUpdateWidget(oldWidget);
  }
  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        title: Text('Dicee'),
        actions: [
          Switch(
              value: _themeManager.themeMode == ThemeMode.dark,
              onChanged: (newValue) {
                _themeManager.toggleTheme(newValue);
              })
        ],
        backgroundColor: Colors.orange,
      ),
      body: DicePage(),
    );
  }
}

class DicePage extends StatefulWidget {
  const DicePage({Key? key}) : super(key: key);

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int leftDiceFace = 1;
  int rightDiceFace = 3;
  void changeFace() {
    setState(() {
      leftDiceFace = Random().nextInt(6) + 1;
      rightDiceFace = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  child: Image.asset('images/dice$leftDiceFace.png'),
                  onPressed: () {
                    changeFace();
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  child: Image.asset('images/dice$rightDiceFace.png'),
                  onPressed: () {
                    changeFace();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
