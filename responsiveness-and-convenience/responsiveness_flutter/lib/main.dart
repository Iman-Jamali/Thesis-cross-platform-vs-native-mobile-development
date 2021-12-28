import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Responsiveness Flutter',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
          ),
          body: Center(
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                print('start navigating to PageA: ' + DateTime.now().millisecondsSinceEpoch.toString());
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const PageA();
                }));
              },
              child: const Text('PageA'),
            ),
          ),
        ));
  }
}

class PageA extends StatefulWidget {
  const PageA({Key? key}) : super(key: key);

  @override
  State<PageA> createState() => _PageAState();
}

class _PageAState extends State<PageA> {
  @override
  void initState() {
    super.initState();
    print('after navigating to PageA: ' + DateTime.now().millisecondsSinceEpoch.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PageA'),
      ),
      body: const Center(child: Text('PageA')),
    );
  }
}
