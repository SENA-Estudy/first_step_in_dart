// Ejercicio 4 · Devolución de un producto
// En la mesa 7 un cliente devuelve un producto. Se valida la devolución,
// se descuenta de la venta y se registra en la lista de devoluciones.
// Las devoluciones mayores a 30.000 requieren autorización del administrador.

// Suma precio × cantidad de cada producto de la venta
int calcularTotal(Map<String, int> menu, Map<String, int> venta) {
  int total = 0;
  for (var item in venta.entries) {
    total += menu[item.key]! * item.value;
  }
  return total;
}

void main() {
  const Map<String, int> menu = {
    'Ajiaco': 28000,
    'Bandeja paisa': 32000,
    'Sancocho': 26000,
    'Limonada': 6000,
    'Jugo natural': 7000,
    'Gaseosa': 5000,
    'Postre del día': 9000,
  };
  // Venta original de la mesa 7. Cada caso trabaja sobre una copia para que
  // los cambios de un caso no afecten a los siguientes.
  const Map<String, int> ventaOriginal = {
    'Sancocho': 2,
    'Gaseosa': 3,
    'Postre del día': 2,
  };
  String productoDevuelto = 'Gaseosa';
  int cantidadDevuelta = 1;
  String motivo = 'Producto en mal estado';
  bool autorizadoPorAdmin = false;
  const int limiteSinAutorizacion = 30000;

  void registrarDevolucion(
    String titulo,
    String productoDevuelto,
    int cantidadDevuelta,
    String motivo,
    bool autorizadoPorAdmin,
  ) {
    print("\n===== $titulo =====");
    Map<String, int> venta = Map.from(ventaOriginal);
    List<String> devoluciones = [];

    // 1. Total original de la venta
    print("Total original: ${calcularTotal(menu, venta)}");

    // 2. Validaciones: el producto debe estar en la venta y la cantidad debe
    // ser mayor que 0 y no superar lo vendido
    if (!venta.containsKey(productoDevuelto)) {
      print("Error: $productoDevuelto no hace parte de la venta");
      return;
    }
    int cantidadVendida = venta[productoDevuelto]!;
    if (cantidadDevuelta <= 0 || cantidadDevuelta > cantidadVendida) {
      print(
        "Error: la cantidad a devolver ($cantidadDevuelta) debe ser mayor que 0 y no superar la vendida ($cantidadVendida)",
      );
      return;
    }

    // 3. Valor de la devolución y control de autorización
    int valorDevolucion = menu[productoDevuelto]! * cantidadDevuelta;
    if (valorDevolucion > limiteSinAutorizacion && !autorizadoPorAdmin) {
      print(
        "Aviso: la devolución de $valorDevolucion supera $limiteSinAutorizacion y requiere autorización del administrador. No se hacen cambios",
      );
      return;
    }

    // 4. Restar la cantidad; si queda en 0 se elimina el producto de la venta
    venta[productoDevuelto] = cantidadVendida - cantidadDevuelta;
    if (venta[productoDevuelto] == 0) {
      venta.remove(productoDevuelto);
    }

    // 5. Registrar la devolución
    devoluciones.add(
      "$cantidadDevuelta x $productoDevuelto ($motivo): $valorDevolucion",
    );

    // 6. Venta actualizada y nuevo total
    print("Devolución registrada: $valorDevolucion");
    print("Venta actualizada: $venta");
    print("Nuevo total: ${calcularTotal(menu, venta)}");
    print("Devoluciones: $devoluciones");
  }

  // Caso con los datos iniciales
  registrarDevolucion(
    "Datos iniciales: 1 gaseosa",
    productoDevuelto,
    cantidadDevuelta,
    motivo,
    autorizadoPorAdmin,
  );

  // Se devuelven todas las gaseosas: el producto desaparece de la venta
  registrarDevolucion("Devolver 3 gaseosas", 'Gaseosa', 3, motivo, false);

  // Se devuelven más gaseosas de las vendidas
  registrarDevolucion("Devolver 5 gaseosas", 'Gaseosa', 5, motivo, false);

  // Producto que no hace parte de la venta
  registrarDevolucion("Devolver un Ajiaco", 'Ajiaco', 1, motivo, false);

  // 2 sancochos = 52.000: supera el límite
  registrarDevolucion(
    "Devolver 2 sancochos sin autorización",
    'Sancocho',
    2,
    'Plato frío',
    false,
  );
  registrarDevolucion(
    "Devolver 2 sancochos con autorización",
    'Sancocho',
    2,
    'Plato frío',
    true,
  );
}
