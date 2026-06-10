// Complete Flutter APK Source for GhostCraft

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;

void main() => runApp(GhostCraftApp());

class GhostCraftApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GhostCraft',
      theme: ThemeData.dark().copyWith(primaryColor: Colors.greenAccent),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedBank = 'OPAY';
  double amount = 50000;

  Future<void> generatePDF() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Column(
            children: [
              pw.Text('GhostCraft - $selectedBank Receipt', style: pw.TextStyle(fontSize: 24)),
              pw.Text('Amount: ₦$amount'),
              pw.Text('Transaction ID: GHOST-${DateTime.now().millisecondsSinceEpoch}'),
              // Add more realistic fields mirroring SlipCraft
            ],
          ),
        ),
      ),
    );
    await Printing.sharePdf(bytes: await pdf.save(), filename: 'ghost_receipt.pdf');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('👻 GhostCraft Generator')),
      body: Center(
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedBank,
              items: ['OPAY', 'Kuda', 'Binance', 'PayPal'].map((bank) => DropdownMenuItem(value: bank, child: Text(bank))).toList(),
              onChanged: (v) => setState(() => selectedBank = v!),
            ),
            ElevatedButton(onPressed: generatePDF, child: Text('Generate Fake Receipt')),
            // Admin mode toggle for unlimited
          ],
        ),
      ),
    );
  }
}
