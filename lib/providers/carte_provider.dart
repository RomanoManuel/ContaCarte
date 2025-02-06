import 'package:flutter/material.dart';
import '../models/carta.dart';

class CarteProvider with ChangeNotifier {
  final List<Carta> _carteIniziali = [
    Carta(immagine: "assets/images/1.png"),
    Carta(immagine: "assets/images/2.png"),
    Carta(immagine: "assets/images/3.png"),
    Carta(immagine: "assets/images/4.png"),
    Carta(immagine: "assets/images/5.png"),
    Carta(immagine: "assets/images/6.png"),
    Carta(immagine: "assets/images/7.png"),
    Carta(immagine: "assets/images/8.png"),
    Carta(immagine: "assets/images/9.png"),
    Carta(immagine: "assets/images/10.png"),
  ];

  List<Carta> _carte = [];
  final List<Map<int, Carta>> _history = []; // Stack per undo

  CarteProvider() {
    reset(); // Inizializza lo stato
  }

  List<Carta> get carte => _carte;

  void incrementaCarta(int index) {
    _history.add({index: _carte[index].copy()});
    if (_carte[index].conteggio > 0) {
      _carte[index].conteggio--;
      if (_carte[index].conteggio == 0) {
        _carte[index].trasparente = true;
      }
      notifyListeners();
    }
  }

  void decrementaCarta(int index) {
    _history.add({index: _carte[index].copy()});
    if (_carte[index].conteggio < 4) {
      _carte[index].conteggio++;
      if (_carte[index].conteggio < 4) {
        _carte[index].trasparente = false;
      }
      notifyListeners();
    }
  }

  void toggleOro(int index) {
    _history.add({index: _carte[index].copy()});
    _carte[index].eOro = !_carte[index].eOro;
    notifyListeners();
  }

  void undo() {
    if (_history.isNotEmpty) {
      final lastChange = _history.removeLast();
      lastChange.forEach((index, previousState) {
        _carte[index] = previousState;
      });
      notifyListeners();
    }
  }

  void reset() {
    _carte =
        _carteIniziali.map((carta) => Carta(immagine: carta.immagine)).toList();
    _history.clear(); // Svuota lo storico delle modifiche
    notifyListeners();
  }
}
