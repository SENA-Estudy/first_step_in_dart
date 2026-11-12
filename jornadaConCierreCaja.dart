// Acumula el total vendido por cada medio de pago usando un for con índice
Map<String, int> acumularPorMedio(List<int> totales, List<String> medios) {
  Map<String, int> porMedio = {'efectivo': 0, 'debito': 0, 'credito': 0};

  for (int i = 0; i < totales.length; i++) {
    String medio = medios[i];
    if (!porMedio.containsKey(medio)) {
      print("Medio de pago '$medio' no válido en la venta ${i + 1}, se omite");
      continue;
    }
    porMedio[medio] = porMedio[medio]! + totales[i];
  }
  return porMedio;
}

// Suma todas las ventas del día
int calcularTotalVendido(List<int> totales) {
  int total = 0;
  for (var venta in totales) {
    total += venta;
  }
  return total;
}

// Busca la venta de mayor valor
int calcularVentaMayor(List<int> totales) {
  int mayor = 0;
  for (var venta in totales) {
    if (venta > mayor) {
      mayor = venta;
    }
  }
  return mayor;
}

// Calcula el promedio por venta, evitando dividir entre cero
double calcularPromedio(int totalVendido, int cantidadVentas) {
  return cantidadVentas > 0 ? totalVendido / cantidadVentas : 0;
}

// Suma los egresos recorriendo los valores del Map
int sumarEgresos(Map<String, int> egresos) {
  int total = 0;
  for (var valor in egresos.values) {
    total += valor;
  }
  return total;
}

// El efectivo esperado es la base más las ventas en efectivo menos los egresos
int calcularEfectivoEsperado(int base, int ventasEfectivo, int totalEgresos) {
  return base + ventasEfectivo - totalEgresos;
}

// Compara el efectivo esperado con el contado y muestra el estado de la caja
void compararCaja(int efectivoEsperado, int efectivoContado) {
  int diferencia = efectivoContado - efectivoEsperado;

  if (diferencia == 0) {
    print("Caja cuadrada");
  } else if (diferencia > 0) {
    print("Sobrante de $diferencia");
  } else {
    print("Faltante de ${-diferencia}");
  }
}

// Reúne todos los cálculos y muestra el informe de cierre
void cerrarCaja(
  int baseInicial,
  List<int> totales,
  List<String> medios,
  Map<String, int> egresos,
  int efectivoContado,
) {
  Map<String, int> porMedio = acumularPorMedio(totales, medios);
  int totalVendido = calcularTotalVendido(totales);
  int cantidadVentas = totales.length;
  int ventaMayor = calcularVentaMayor(totales);
  double promedio = calcularPromedio(totalVendido, cantidadVentas);
  int totalEgresos = sumarEgresos(egresos);
  int efectivoEsperado = calcularEfectivoEsperado(
    baseInicial,
    porMedio['efectivo']!,
    totalEgresos,
  );

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
  compararCaja(efectivoEsperado, efectivoContado);
}

void main() {
  int baseInicial = 200000;
  // Las dos listas van en el mismo orden: la venta i se pagó con el medio i
  List<int> totales = [45000, 120000, 38000, 76000, 54000, 91000];
  List<String> medios = [
    'efectivo',
    'debito',
    'efectivo',
    'credito',
    'efectivo',
    'debito',
  ];
  Map<String, int> egresos = {'Compra de hielo': 15000, 'Recarga de gas': 20000};
  int efectivoContado = 300000;

  // Caso con los datos iniciales: hay faltante
  print("===== Cierre con datos iniciales =====");
  cerrarCaja(baseInicial, totales, medios, egresos, efectivoContado);

  // Caso con la caja cuadrada
  print("\n===== Cierre con caja cuadrada =====");
  cerrarCaja(baseInicial, totales, medios, egresos, 302000);

  // Caso con sobrante
  print("\n===== Cierre con sobrante =====");
  cerrarCaja(baseInicial, totales, medios, egresos, 305000);

  // Se agrega una venta nueva en ambas listas antes del cierre
  totales.add(60000);
  medios.add('efectivo');
  print("\n===== Cierre con venta nueva agregada =====");
  cerrarCaja(baseInicial, totales, medios, egresos, efectivoContado);
}