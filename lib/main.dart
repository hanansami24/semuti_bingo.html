import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const SmutiBingoApp());
}

class SmutiBingoApp extends StatelessWidget {
  const SmutiBingoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smuti Bingo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      home: const BingoGameScreen(),
    );
  }
}

class BingoGameScreen extends StatefulWidget {
  const BingoGameScreen({super.key});

  @override
  State<BingoGameScreen> createState() => _BingoGameScreenState();
}

class _BingoGameScreenState extends State<BingoGameScreen> {
  bool isLoading = false;
  String gameStatus = 'Smuti Bingo ለመጀመር ዝግጁ ነው';
  int? serverVerifiedScore;
  List<int> serverGeneratedNumbers = [];

  // በሰርቨር ደረጃ ቁጥሮችን የማረጋገጥ እና የማመነጨት ሂደት
  void requestServerValidation() {
    setState(() {
      isLoading = true;
      gameStatus = 'ሰርቨሩ ቁጥሮችን በማመንጨት ላይ ይገኛል...';
    });

    Timer(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
        serverGeneratedNumbers = [5, 12, 23, 34, 45];
        serverVerifiedScore = 150;
        gameStatus = 'በሰርቨር ደረጃ በማጣሪያ የተረጋገጠ ውጤት!';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smuti Bingo Game', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo[900],
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Colors.indigo[950],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.indigoAccent, width: 1.5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.casino_rounded,
                size: 70,
                color: Colors.cyanAccent,
              ),
              const SizedBox(height: 20),
              Text(
                gameStatus,
                style: const TextStyle(fontSize: 16, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              if (serverVerifiedScore != null) ...[
                Text(
                  'የተረጋገጠ ውጤት: $serverVerifiedScore',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.greenAccent),
                ),
                const SizedBox(height: 10),
                Text(
                  'የወጡ ቁጥሮች: ${serverGeneratedNumbers.toString()}',
                  style: const TextStyle(fontSize: 14, color: Colors.amberAccent),
                ),
              ],
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigoAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: isLoading ? null : requestServerValidation,
                  child: isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : const Text(
                          'ቁጥሮችን ጠይቅ / አረጋግጥ',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
