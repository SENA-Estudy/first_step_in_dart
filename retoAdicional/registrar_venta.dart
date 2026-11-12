// Etapa 2 · Registrar la venta de una mesa (ejercicio 2)
import 'menu.dart';

// Calcula la cuenta con propina opcional y procesa el pago.
// Devuelve el total cobrado, o null si el pago no se pudo completar.
int? registrarVenta(
  Map<String, int> pedido,
  bool incluirPropina,
  String medioPago,
  int valorRecibido,
  String? referencia,
) {
  int subtotal = calcularSubtotal(pedido);
  int propina = incluirPropina ? subtotal * 10 ~/ 100 : 0;
  int total = subtotal + propina;
  print("Subtotal: $subtotal · Propina: $propina · TOTAL: $total");

  switch (medioPago) {
    case 'efectivo':
      if (valorRecibido < total) {
        print("Dinero insuficiente, faltan: ${total - valorRecibido}");
        return null;
      }
      print("Cambio: ${valorRecibido - total}");
    case 'debito':
      if (referencia == null) {
        print("Error: el pago con débito requiere una referencia");
        return null;
      }
      print("Pago con débito confirmado. Referencia: $referencia");
    default:
      print("Medio de pago no válido");
      return null;
  }
  return total;
}
