// Etapa 5 · Cierre de caja (ejercicio 5)

// Muestra el informe de cierre y el arqueo comparando el efectivo esperado
// con el contado. totales y medios son listas paralelas (venta i ↔ medio i).
void cerrarCaja(
  int baseInicial,
  List<int> totales,
  List<String> medios,
  Map<String, int> egresos,
  int efectivoContado,
) {
  // Totales por medio de pago con un for con índice
  Map<String, int> porMedio = {'efectivo': 0, 'debito': 0, 'credito': 0};
  for (int i = 0; i < totales.length; i++) {
    if (!porMedio.containsKey(medios[i])) {
      print(
        "Medio de pago '${medios[i]}' no válido en la venta ${i + 1}, se omite",
      );
      continue;
    }
    porMedio[medios[i]] = porMedio[medios[i]]! + totales[i];
  }

  int totalVendido = 0;
  int ventaMayor = 0;
  for (var venta in totales) {
    totalVendido += venta;
    if (venta > ventaMayor) {
      ventaMayor = venta;
    }
  }
  int cantidadVentas = totales.length;
  double promedio = cantidadVentas > 0 ? totalVendido / cantidadVentas : 0;

  int totalEgresos = 0;
  for (var valor in egresos.values) {
    totalEgresos += valor;
  }

  // Débito y crédito no entran como efectivo a la caja
  int efectivoEsperado = baseInicial + porMedio['efectivo']! - totalEgresos;
  int diferencia = efectivoContado - efectivoEsperado;

  print(
    "Ventas en efectivo: ${porMedio['efectivo']} · débito: ${porMedio['debito']} · crédito: ${porMedio['credito']}",
  );
  print(
    "Total vendido: $totalVendido ($cantidadVentas ventas) · Venta mayor: $ventaMayor · Promedio: ${promedio.toStringAsFixed(0)}",
  );
  print("Egresos: $totalEgresos");
  print(
    "Efectivo esperado: $efectivoEsperado · Efectivo contado: $efectivoContado",
  );
  if (diferencia == 0) {
    print("Caja cuadrada");
  } else if (diferencia > 0) {
    print("Sobrante de $diferencia");
  } else {
    print("Faltante de ${-diferencia}");
  }
}
