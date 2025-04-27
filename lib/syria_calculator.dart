import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SyriaCalculator extends StatefulWidget {
  const SyriaCalculator({super.key});

  @override
  State<SyriaCalculator> createState() => _SyriaCalculatorState();
}

class _SyriaCalculatorState extends State<SyriaCalculator> {
  Object result = 0;
  double ratio = 11500;
  bool isSypToUSD = true;
  TextEditingController textEditingController = TextEditingController();

  String _formatNumber(Object number) {
    try {
      if (number is double) {
        return NumberFormat('#,##0.00').format(number);
      }
      return NumberFormat('#,###').format(number);
    } catch (e) {
      return "أدخل الرقم بشكل صحيح";
    }
  }

  void _convert() {
    var input = textEditingController.text;

    setState(() {
      if (input.length > 12) {
        result = "أدخل رقم صحيح";
      } else {
        var amount = double.tryParse(input) ?? 0.0;
        if (amount < 0) {
          result = "أدخل رقم موجب";
        } else {
          double conversion = isSypToUSD ? (amount * ratio) : (amount / ratio);
          result = double.parse(conversion.toStringAsFixed(2));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                setState(() {
                  result = 0;
                  isSypToUSD = !isSypToUSD;
                  textEditingController.clear();
                });
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 22, 150, 10),
                foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                minimumSize: const Size(30, 30),
              ),
              child: const Icon(Icons.swap_horiz),
            ),
          ),
        ],
        title: Text(isSypToUSD ? "من الدولار للسوري " : "من السوري للدولار"),
        centerTitle: false,
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 7, 230, 62),
          fontSize: 35,
          fontWeight: FontWeight.w900,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${_formatNumber(result)} ${isSypToUSD ? 'SP' : 'USD'}",
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w900,
                color: Color.fromARGB(255, 7, 230, 62),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 20, right: 4),
              child: TextField(
                controller: textEditingController,
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                decoration: InputDecoration(
                  hintText: isSypToUSD
                      ? "ادخل المبلغ بالدولار"
                      : "ادخل المبلغ بالسوري",
                  hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  prefixIcon: const Icon(Icons.monetization_on),
                  prefixIconColor: const Color.fromARGB(255, 7, 230, 62),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 0, 0, 0),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 7, 230, 62),
                    ),
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(60),
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(60),
                    ),
                  ),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 20, right: 8),
              child: TextButton(
                onPressed: _convert,
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 11, 187, 55),
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                  minimumSize: const Size(double.infinity, 30),
                ),
                child: const Text('إضغط للتحويل'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
