void main() {
  // Abrir caja
  String usuario = 'Laura';
  String rol = 'cajero'; // puede ser 'admin', 'cajero' o 'mesero'
  bool cajaAbierta = false;
  int baseInicial = 200000;
  const int baseMaxima = 10000000;
  List<String> movimientos = [];

  Map<String, dynamic> usuarioLaura = {"name": usuario, "rol": rol};

  List<String> rolesAutorizados = ["admin", "cajero", "mesero"];

  void abrirCaja() {
    if (cajaAbierta == true) {
      print("Error: ya hay una caja abierta");
    } else if (baseInicial > baseMaxima || baseInicial < 0) {
      print(
        "Error: La base inicial no puede ser menor a cero ni mayor a la base máxima",
      );
    } else if (rolesAutorizados.contains(usuarioLaura["rol"])) {
      cajaAbierta = true;
      movimientos.add("APERTURA por Laura con base 200000");
      print(
        "Caja abierta por ${usuarioLaura["name"]} con una base de $baseInicial",
      );
      print("Estado de la caja: ${cajaAbierta ? "ABIERTA" : "CERRADA"}");
      print(movimientos.first);
    }
  }

  abrirCaja();
}
