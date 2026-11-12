int propinaAgregada(bool incluirPropina, int propina, int subTotal) {
  propina = incluirPropina ? subTotal ~/ 10 : 0;
  return propina;
}

String tipoDePago(
  String medioPago,
  String? referencia,
  int total,
  int valorRecibido,
) {
  switch (medioPago) {
    case "efectivo":
      if (valorRecibido < total) {
        // NO hay suficiente dinero
        print("Dinero insuficiente, faltan: ${total - valorRecibido}");
      } else {
        // Efectivo suficiente, cambio.
        print("Pago en efectivo. Cambio: ${valorRecibido - total}");
      }
      break;
    case "debito":
      if (referencia == null) {
        // Pago debito requiere referencia.
        print("Error: el pago con débito requiere una referencia");
      } else {
        print("Pago con débito confirmado. Referencia: $referencia");
      }
      break;
    default:
      print("Medio de pago no válido");
  }
  return medioPago;
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
  Map<String, int> pedido = {
    'Bandeja paisa': 2,
    'Limonada': 3,
    'Postre del día': 1,
    'Cazuela': 1, // no está en el menú
  };
  bool incluirPropina = true; // propina voluntaria del 10 %
  String medioPago = 'efectivo'; // 'efectivo' o 'debito'
  int valorRecibido = 110000; // solo para efectivo
  String? referencia; // solo para débito

  void registrarVenta(incluirPropina, medioPago, referencia, valorRecibido) {
    int subTotal = 0;
    int propina = 0;

    for (var orden in pedido.keys) {
      if (!menu.containsKey(orden)) {
        print("$orden no existe en el menú, se omite");
        continue;
      }
      int precioMenu = menu[orden]!;
      int cantidadPedido = pedido[orden]!;
      int totalPorPedido = precioMenu *= cantidadPedido;
      print("$orden x$cantidadPedido = $totalPorPedido");

      subTotal += totalPorPedido;
    }
    propina = propinaAgregada(incluirPropina, propina, subTotal);
    int total = subTotal + propina;
    print("Subtotal: $subTotal · Propina: $propina · TOTAL: $total");

    tipoDePago(medioPago, referencia, total, valorRecibido);
  }

  // Caso perfecto con propina incluida.
  registrarVenta(incluirPropina, medioPago, referencia, valorRecibido);

  // Caso sin propina.
  print("");
  print("Caso sin propina:");
  registrarVenta(!incluirPropina, medioPago, referencia, valorRecibido);

  //Caso valorRecibido 9000
  print("");
  print("Caso valor recibido 9000:");
  registrarVenta(incluirPropina, medioPago, referencia, 9000);

  //Caso medioPago debito sin referencia
  print("");
  print("Caso medioPago debito sin referencia:");
  registrarVenta(incluirPropina, "debito", referencia, valorRecibido);

  //Caso medioPago debito con referencia
  print("");
  print("Caso medioPago debito con referencia:");
  registrarVenta(incluirPropina, "debito", "A-12345", valorRecibido);

    //Caso medioPago bitcoin
  print("");
  print("Caso medioPago bitcoin:");
  registrarVenta(incluirPropina, "bitcoin", "A-12345", valorRecibido);
}

/**
 * Lo que debe hacer:
1. Recorrer el pedido. Si un producto no existe en el menú, mostrar un aviso y saltarlo con continue.
2. Mostrar cada línea: producto, cantidad y valor (precio × cantidad), y acumular el subtotal.
3. Calcular la propina (10 % del subtotal, sin decimales) solo si incluirPropina es true. Usen el operador
ternario.
4. Mostrar subtotal, propina y total.
5. Con un switch sobre medioPago: en efectivo, mostrar el cambio o cuánto falta si el dinero no alcanza; en
debito, mostrar un error si referencia es null o confirmar el pago; en otro caso, “Medio de pago no válido”.
 */
