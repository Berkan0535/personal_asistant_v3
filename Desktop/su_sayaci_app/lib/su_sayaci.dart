import 'package:flutter/material.dart';

class SuSayaci extends StatefulWidget {
  const SuSayaci({super.key});

  @override
  State<SuSayaci> createState() => _SuSayaciState();
}

class _SuSayaciState extends State<SuSayaci> {
  int icilenSu = 0; // ml cinsinden içilen su
  final int gunlukHedef = 2000; // günlük su hedefi (ml)

  void suEkle(int miktar) {
    setState(() {
      icilenSu += miktar;
      if (icilenSu > gunlukHedef) icilenSu = gunlukHedef;
    });
  }

  void suAzalt(int miktar) {
    setState(() {
      icilenSu -= miktar;
      if (icilenSu < 0) icilenSu = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double yuzde = icilenSu / gunlukHedef;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Su Sayaç"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Yüzdelik progress bar
            Column(
              children: [
                Text(
                  "% ${(yuzde * 100).toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                LinearProgressIndicator(
                  value: yuzde,
                  backgroundColor: Colors.grey.shade300,
                  color: Colors.blueAccent,
                  minHeight: 15,
                ),
              ],
            ),

            // İçilen su miktarı gösterimi
            Column(
              children: [
                Text(
                  "$icilenSu / $gunlukHedef ml",
                  style: const TextStyle(fontSize: 26),
                ),
              ],
            ),

            // Arttır - Azalt butonları
            Column(
              children: [
                const Text(
                  "Miktar Ekle / Çıkar",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => suAzalt(200),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                      ),
                      child: const Text("-200 ml"),
                    ),
                    ElevatedButton(
                      onPressed: () => suEkle(200),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                      ),
                      child: const Text("+200 ml"),
                    ),
                  ],
                ),
              ],
            ),

            // Reset tuşu
            ElevatedButton(
              onPressed: () {
                setState(() {
                  icilenSu = 0;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade700,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
              child: const Text("Sıfırla"),
            ),
          ],
        ),
      ),
    );
  }
}
