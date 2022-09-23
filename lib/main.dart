import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

namaFunction() {
  print("Hello World!!!!!!!!!!!!!!!!!!!!!!");
}

var task = 'Ini hari Jum\'at';

void cobaWorkmanager() {
  Workmanager().executeTask((taskName, inputData) {
    switch (taskName) {
      case 'ini workmanager':
        namaFunction();
        break;
      default:
    }
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager().initialize(cobaWorkmanager, isInDebugMode: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CobaWorkManager(),
    );
  }
}

class CobaWorkManager extends StatefulWidget {
  const CobaWorkManager({Key? key}) : super(key: key);

  @override
  State<CobaWorkManager> createState() => _CobaWorkManagerState();
}

class _CobaWorkManagerState extends State<CobaWorkManager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Belajar Workmanager"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              color: Colors.blue,
              onPressed: () {
                print("Wait for workmanager");
                var waktu = DateTime.now();
                Workmanager().registerOneOffTask("Hallo", task,
                    initialDelay: Duration(seconds: 15),
                    inputData: {
                      'Waktu': '$waktu',
                      'tanggal': 23,
                      'hari': 'jum\'at'
                    },
                    constraints:
                        Constraints(networkType: NetworkType.connected));
              },
              child: Text(
                "Start",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              color: Colors.blue,
              onPressed: () {
                print("Wait for 60 workmanager");
                var waktu = DateTime.now();
                Workmanager().registerOneOffTask("Selamat", task,
                    initialDelay: Duration(seconds: 60),
                    inputData: {
                      'benar/salah': true,
                      'tanggal': 23,
                      'hari': 'jum\'at'
                    },
                    constraints:
                        Constraints(networkType: NetworkType.connected));
              },
              child: Text(
                "60 Detik",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              color: Colors.blue,
              onPressed: () {
                Workmanager().cancelAll();
                print("Telah dicancel");
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            MaterialButton(
              color: Colors.blue,
              onPressed: () {
                Workmanager().cancelByUniqueName('Selamat');
                print("Telah dicancel");
              },
              child: Text(
                "Cancel using by unique name",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
