class Carta {
  final String immagine;
  int conteggio;
  bool trasparente;
  bool eOro;

  Carta(
      {required this.immagine,
      this.conteggio = 4,
      this.trasparente = false,
      this.eOro = false});

  Carta copy() {
    return Carta(
      immagine: immagine,
      conteggio: conteggio,
      trasparente: trasparente,
      eOro: eOro,
    );
  }
}
