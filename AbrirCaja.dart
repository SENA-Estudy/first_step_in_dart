void main() {
  // Abrir caja
  String usuario = 'Laura';
  String rol = 'cajero'; // puede ser 'admin', 'cajero' o 'mesero'
  bool cajaAbierta = false;
  int baseInicial = 200000;
  const int baseMaxima = 10000000;
  List<String> movimientos = [];

  List<String> rolesAutorizados = ["admin", "cajero"];

  // Usuario autorizado.
  Map<String, dynamic> usuarioLaura = {"name": usuario, "rol": rol};

  //Usuario no autorizado.
  Map<String, dynamic> usuarioNoautorizado = {
    "name": "Brayan",
    "rol": "mesero",
  };

  void abrirCaja(usuario) {
    if (cajaAbierta == true) {
      print("Error: ya hay una caja abierta");
      print("Estado de la caja: ${cajaAbierta ? "ABIERTA" : "CERRADA"}");
    } else if (baseInicial > baseMaxima || baseInicial < 0) {
      print(
        "Error: La base inicial no puede ser menor a cero ni mayor a la base máxima",
      );
      print("Estado de la caja: ${cajaAbierta ? "ABIERTA" : "CERRADA"}");
    } else if (!rolesAutorizados.contains(usuario["rol"])) {
      print(
        "Error: El usuario ${usuario["name"]} no esta autorizado para abrir caja",
      );
      print("Estado de la caja: ${cajaAbierta ? "ABIERTA" : "CERRADA"}");
    } else {
      cajaAbierta = true;
      movimientos.add("APERTURA por Laura con base 200000");
      print("Caja abierta por ${usuario["name"]} con una base de $baseInicial");
      print("Estado de la caja: ${cajaAbierta ? "ABIERTA" : "CERRADA"}");
      print(movimientos.first);
    }
  }

  // Usuario autorizado con todo funcionando.
  abrirCaja(usuarioLaura);

  // Reiniciamos el estado de la caja para probar el rol distinto
  cajaAbierta = false;
  print("");
  print("Ejemplo usuario no autorizado:");
  abrirCaja(usuarioNoautorizado);

  // BaseInicial mayor al baseMaxima
  baseInicial = 10000001;
  print("");
  print("Ejemplo Base Inicial mayor a Base Máxima permitida");
  abrirCaja(usuarioLaura);

  // Caja ya esta abierta
  cajaAbierta = true;
  print("");
  abrirCaja(usuarioLaura);
}
