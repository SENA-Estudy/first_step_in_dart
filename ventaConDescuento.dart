void main() {
  Map<String, int> menu = {
    'Ajiaco': 28000,
    'Bandeja paisa': 32000,
    'Sancocho': 26000,
    'Limonada': 6000,
    'Jugo natural': 7000,
    'Gaseosa': 5000,
    'Postre del día': 9000,
  };
  Map<String, int> pedido = {
    'Ajiaco': 3,
    'Jugo natural': 4,
    'Postre del día': 2,
    'Bandeja paisa': 1,
  };
  // Orden con subtotal menor a 150.000
  Map<String, int> pedidoPequeno = {
    'Sancocho': 2,
    'Limonada': 2,
  };
  const int descuentoMaximo = 20; // porcentaje máximo

  void calcularVenta(
    String titulo,
    Map<String, int> pedido,
    String? cupon,
    bool clienteFrecuente,
  ) {
    print("\n===== $titulo =====");

    // calculo de subtotal
    int subTotal = 0;
    for (var orden in pedido.keys) {
      if (!menu.containsKey(orden)) {
        print("$orden no existe en el menú, se omite");
        continue;
      }
      int precioMenu = menu[orden]!;
      int cantidadPedido = pedido[orden]!;
      int totalPorPedido = precioMenu * cantidadPedido;
      print("$orden x$cantidadPedido = $totalPorPedido");
      subTotal += totalPorPedido;
    }

    // Acumulación de descuento y razon.
    int porcentajeDescuento = 0;
    List<String> motivos = [];

    if (subTotal >= 150000) {
      porcentajeDescuento += 10;
      motivos.add("Subtotal mayor o igual a 150.000 (10 %)");
    }

    // Verificar los cupones, verificar si no hay cupon incluido
    if (cupon != null) {
      switch (cupon.toUpperCase()) {
        case 'CUMPLE':
          porcentajeDescuento += 15;
          motivos.add("Cupón CUMPLE (15 %)");
          break;
        case 'ESTUDIANTE':
          porcentajeDescuento += 5;
          motivos.add("Cupón ESTUDIANTE (5 %)");
          break;
        default:
          print("Aviso: el cupón '$cupon' no es válido, no se aplica descuento");
      }
    }

    if (clienteFrecuente) {
      porcentajeDescuento += 5;
      motivos.add("Cliente frecuente (5 %)");
    }

    // Aplicar máximo descuento
    if (porcentajeDescuento > descuentoMaximo) {
      print(
        "Aviso: el descuento acumulado ($porcentajeDescuento %) supera el tope, se ajusta a $descuentoMaximo %",
      );
      porcentajeDescuento = descuentoMaximo;
    }

    // Descuento sin decimales.
    int valorDescuento = subTotal * porcentajeDescuento ~/ 100;
    int total = subTotal - valorDescuento;

    print("Subtotal: $subTotal");
    print("Descuento: $porcentajeDescuento % (-$valorDescuento)");
    print("TOTAL: $total");
    print("Motivos:");
    if (motivos.isEmpty) {
      print("- Ninguno");
    }
    for (var motivo in motivos) {
      print("- $motivo");
    }
  }

  // Casos
  calcularVenta("Caso base: CUMPLE + frecuente", pedido, 'CUMPLE', true);
  calcularVenta("Sin cupón", pedido, null, true);
  calcularVenta("Cupón en minúsculas: estudiante", pedido, 'estudiante', true);
  calcularVenta("Cupón inválido: GRATIS", pedido, 'GRATIS', true);
  calcularVenta("Cliente no frecuente", pedido, 'CUMPLE', false);
  calcularVenta("Subtotal menor a 150.000", pedidoPequeno, 'CUMPLE', true);
}