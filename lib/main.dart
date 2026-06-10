import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() => runApp(GhostCraftApp());

class GhostCraftApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '👻 GhostCraft',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.greenAccent,
        scaffoldBackgroundColor: const Color(0xFF0a0a0a),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedBank = 'OPAY';
  final List<String> banks = ['OPAY', 'Kuda', 'Binance', 'PayPal', 'CashApp', 'Bybit', 'Coinbase'];
  double amount = 50000.0;
  String txId = 'GHOST-TX-${DateTime.now().millisecondsSinceEpoch}';
  bool isAdmin = true;

  Future<void> generateReceipt() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Column(
            children: [
              pw.Text('👻 GhostCraft Fake Receipt', style: pw.TextStyle(fontSize: 28, color: PdfColors.green)),
              pw.Text('$selectedBank Transaction', style: pw.TextStyle(fontSize: 22)),
              pw.Text('Amount: ₦$amount', style: pw.TextStyle(fontSize: 20)),
              pw.Text('TX ID: $txId', style: pw.TextStyle(fontSize: 18)),
              pw.Text('Status: SUCCESS | Admin Unlimited Access', style: pw.TextStyle(fontSize: 16, color: PdfColors.purple)),
              pw.Text('Exact Replica of SlipCraft.net', style: pw.TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );

    final directory = await getExternalStorageDirectory();
    final file = File('${directory!.path}/ghost_${selectedBank}_receipt.pdf');
    await file.writeAsBytes(await pdf.save());

    await Share.shareXFiles([XFile(file.path)], text: 'GhostCraft Fake Slip - $selectedBank');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Receipt Generated & Shared! (Unlimited Admin Mode)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GhostCraft - Fake Bank Slips')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Bank (Like SlipCraft)', style: TextStyle(fontSize: 18, color: Colors.purpleAccent)),
            DropdownButton<String>(
              value: selectedBank,
              isExpanded: true,
              items: banks.map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
              onChanged: (v) => setState(() => selectedBank = v!),
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount (₦)'),
              onChanged: (v) => amount = double.tryParse(v) ?? amount,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: generateReceipt,
              child: const Text('Generate Receipt & PDF'),
            ),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('📧 Fake Email Sent (Nodemailer/Termux Sim)')));
              },
              child: const Text('Send Fake Transaction Email'),
            ),
            const Text('\nAdmin Mode: Unlimited Generations | Neon Ghost Theme', style: TextStyle(color: Colors.greenAccent)),
          ],
        ),
      ),
    );
  }
}