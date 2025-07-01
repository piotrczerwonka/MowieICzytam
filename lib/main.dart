import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(CzytanieApp());

class CzytanieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mówię i Czytam',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CzytanieStrona(),
    );
  }
}

class CzytanieStrona extends StatefulWidget {
  @override
  _CzytanieStronaState createState() => _CzytanieStronaState();
}

class _CzytanieStronaState extends State<CzytanieStrona> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  final List<List<String>> parySlow = [
    ...List.generate(10, (_) => ['a', 'u']),
    ['kadź', 'kuć'], ['kraj', 'krój'], ['klacz', 'klucz'], ['wrak', 'wróg'],
    ['pach', 'puch'], ['patyk', 'putyk'], ['baca', 'bucy'], ['mak', 'muk'],
    ['las', 'lus'], ['kasza', 'kusza'], ['bar', 'bur'], ['rak', 'ruk'],
    ['zakaz', 'zukuz'], ['tarcza', 'turcza'], ['blacha', 'blucha'], ['panna', 'punna'],
    ['mama', 'muma'], ['tata', 'tuta'], ['dama', 'duma'], ['fala', 'fula'],
    ['parka', 'purka'], ['rama', 'ruma'], ['kasa', 'kusa'], ['banda', 'bunda'],
    ['lada', 'luda'], ['dach', 'duch'], ['baba', 'buba'], ['paka', 'puka'],
    ['sama', 'suma'], ['sara', 'sura'],
  ];

  int indeks = 0;
  Timer? timer;
  final double maxBPM = 160;
  double bpm = 60;
  bool isRunning = false;
  double postep = 0.0;
  final updateInterval = Duration(milliseconds: 100);

  @override
  void dispose() {
    timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  void start() {
    timer?.cancel();
    double sekundyNaSlowo = 60 / bpm;
    double sekundyNaPare = sekundyNaSlowo * 2;
    double elapsed = 0.0;
    bool secondBeepPlayed = false;

    _playBeep(); // pierwszy beep na start pary

    timer = Timer.periodic(updateInterval, (t) {
      setState(() {
        elapsed += updateInterval.inMilliseconds / 1000.0;
        postep = (elapsed / sekundyNaPare).clamp(0.0, 1.0);

        if (!secondBeepPlayed && elapsed >= sekundyNaPare / 2) {
          _playBeep();
          secondBeepPlayed = true;
        }

        if (elapsed >= sekundyNaPare) {
          indeks++;
          elapsed = 0.0;
          postep = 0.0;
          secondBeepPlayed = false;

          if (indeks >= parySlow.length) {
            timer?.cancel();
            isRunning = false;
          } else {
            _playBeep(); // pierwszy beep następnej pary
          }
        }
      });
    });

    setState(() {
      isRunning = true;
    });
  }

  void _playBeep() async {
    await _audioPlayer.play(AssetSource('metronome.mp3'));
  }

  void stop() {
    timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void toggleStartStop() {
    if (isRunning) {
      stop();
    } else {
      start();
    }
  }

  void reset() {
    timer?.cancel();
    setState(() {
      indeks = 0;
      postep = 0.0;
      isRunning = false;
    });
  }

  void updateBPM(double newBPM) {
    bpm = newBPM;
    if (isRunning) {
      start();
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    int currentPage = indeks ~/ 10;
    int start = currentPage * 10;
    int end = (start + 10).clamp(0, parySlow.length);
    List<List<String>> widocznePary = parySlow.sublist(start, end);

    return Scaffold(
      appBar: AppBar(title: Text('Mówię i Czytam')),
      body: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                double availableHeight = constraints.maxHeight - 80;
                double itemHeight = availableHeight / 10;
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widocznePary.length,
                  itemExtent: itemHeight,
                  itemBuilder: (context, i) {
                    int globalIndex = start + i;
                    bool aktywna = globalIndex == indeks;
                    double progress = aktywna ? postep : 0.0;

                    return GestureDetector(
                      onTap: () {
                        timer?.cancel();
                        setState(() {
                          indeks = globalIndex;
                          isRunning = false;
                          postep = 0.0;
                        });
                      },
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: LinearProgressIndicator(
                              value: progress,
                              backgroundColor: Colors.transparent,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent.withOpacity(0.3)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 2),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: aktywna ? Colors.blueAccent.withValues(alpha: 0.5) : Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                '${widocznePary[i][0]} – ${widocznePary[i][1]}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: aktywna ? Colors.white : Colors.black87,
                                  fontWeight: aktywna ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Slider(
                  value: bpm,
                  min: 20,
                  max: maxBPM,
                  divisions: (maxBPM - 20).toInt(),
                  label: bpm.round().toString(),
                  onChanged: (value) => updateBPM(value),
                ),
                Text('BPM: ${bpm.round()}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: toggleStartStop,
                      child: Text(isRunning ? 'Stop' : 'Start'),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: reset,
                      child: Text('Reset'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
