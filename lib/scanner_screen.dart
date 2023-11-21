import 'package:flutter/material.dart';
import 'package:ml_card_scanner/ml_card_scanner.dart';

class Scanner extends StatefulWidget {
  final Function(CardInfo) onScanCard;

  const Scanner({super.key, required this.onScanCard});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final ScannerWidgetController _controller = ScannerWidgetController();

  @override
  void initState() {
    _controller.setCardListener((CardInfo? cardInfo) {
      if (cardInfo != null) {
        Navigator.of(context).pop();
        widget.onScanCard(cardInfo);
      }
    });
    _controller.setErrorListener((exception) {
      print('Error: ${exception.message}');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(.5),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ScannerWidget(
                controller: _controller,
                overlayOrientation: CardOrientation.landscape,
                cameraResolution: CameraResolution.max,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
