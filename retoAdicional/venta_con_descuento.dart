// Etapa 3 · Venta con descuento (ejercicio 3)
import 'menu.dart';

const int descuentoMaximo = 20; // porcentaje máximo

// Acumula los descuentos de la política, aplica el tope y devuelve el total.
int calcularVentaConDescuento(
  Map<String, int> pedido,
  String? cupon,
  bool clienteFrecuente,
) {
  int subtotal = calcularSubtotal(pedido);
  int porcentaje = 0;
  List<String> motivos = [];

  if (subtotal >= 150000) {
    porcentaje += 10;
    motivos.add("compra mayor a 150.000 (10 %)");
  }

  // El cupón solo se revisa si existe; se acepta en mayúsculas o minúsculas
  if (cupon != null) {
    switch (cupon.toUpperCase()) {
      case 'CUMPLE':
        porcentaje += 15;
        motivos.add("cupón CUMPLE (15 %)");
      case 'ESTUDIANTE':
        porcentaje += 5;
        motivos.add("cupón ESTUDIANTE (5 %)");
      default:
        print("Aviso: el cupón '$cupon' no es válido, no se aplica descuento");
    }
  }

  if (clienteFrecuente) {
    porcentaje += 5;
    motivos.add("cliente frecuente (5 %)");
  }

  print("Subtotal: $subtotal");
  if (porcentaje > descuentoMaximo) {
    print(
      "El descuento de $porcentaje % supera el máximo; se aplica $descuentoMaximo %",
    );
    porcentaje = descuentoMaximo;
  }

  int descuento = subtotal * porcentaje ~/ 100;
  int total = subtotal - descuento;
  print("Descuento: $descuento · TOTAL A PAGAR: $total");
  print("Motivos: ${motivos.isEmpty ? 'ninguno' : motivos.join(', ')}");
  return total;
}
