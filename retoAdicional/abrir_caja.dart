// Etapa 1 · Abrir la caja (ejercicio 1)

const int baseMaxima = 10000000;
const List<String> rolesAutorizados = ['admin', 'cajero'];

// Valida las reglas de apertura y devuelve el nuevo estado de la caja
// (true = abierta). Si se abre, agrega el movimiento a la lista.
bool abrirCaja(
  String usuario,
  String rol,
  int baseInicial,
  bool cajaAbierta,
  List<String> movimientos,
) {
  if (cajaAbierta) {
    print("Error: ya hay una caja abierta");
  } else if (!rolesAutorizados.contains(rol)) {
    print(
      "Error: el usuario $usuario ($rol) no está autorizado para abrir caja",
    );
  } else if (baseInicial < 0 || baseInicial > baseMaxima) {
    print(
      "Error: la base inicial no puede ser negativa ni mayor a $baseMaxima",
    );
  } else {
    cajaAbierta = true;
    movimientos.add("APERTURA por $usuario con base $baseInicial");
    print("Caja abierta por $usuario con una base de $baseInicial");
  }

  print("Estado de la caja: ${cajaAbierta ? 'ABIERTA' : 'CERRADA'}");
  print("Movimientos: $movimientos");
  return cajaAbierta;
}
