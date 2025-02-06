import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/carte_provider.dart';

class ContaCarteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final carteProvider = Provider.of<CarteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              onPressed: () => carteProvider.reset(),
              icon: Icon(Icons.refresh,
                  size: 28, color: Colors.black), // Icona nera
              label: Text("Reset",
                  style: TextStyle(
                      fontSize: 18, color: Colors.black)), // Testo nero
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber, // Pulsante color oro
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(width: 16),
            ElevatedButton.icon(
              onPressed: () => carteProvider.undo(),
              icon: Icon(Icons.undo, size: 28, color: Colors.black),
              label: Text("Undo",
                  style: TextStyle(fontSize: 18, color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber, // Pulsante color oro
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            for (int i = 0; i < 2; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int j = 0; j < 5; j++)
                    _buildCartaWidget(context, carteProvider, i * 5 + j),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartaWidget(
      BuildContext context, CarteProvider carteProvider, int index) {
    final carta = carteProvider.carte[index];

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              HapticFeedback.lightImpact();
              carteProvider.incrementaCarta(index);
            },
            onSecondaryTap: () {
              HapticFeedback.mediumImpact();
              carteProvider.decrementaCarta(index);
            },
            splashColor: Colors.amber.withOpacity(0.4),
            highlightColor: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            child: Opacity(
              opacity: carta.trasparente ? 0.2 : 1.0,
              child: Container(
                width: 90,
                height: 140,
                decoration: BoxDecoration(
                  color: carta.eOro
                      ? Colors.amber.withOpacity(0.5)
                      : Colors.transparent, // Oro sotto la carta
                  border: Border.all(
                    color: carta.eOro ? Colors.amber : Colors.transparent,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Card(
                  elevation: 4,
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image.asset(
                    carta.immagine,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 4),
          Text(
            "x${carta.conteggio}",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Transform.scale(
            scale: 1.2,
            child: Checkbox(
              value: carta.eOro,
              onChanged: (value) => carteProvider.toggleOro(index),
              activeColor: Colors.amber,
              checkColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
