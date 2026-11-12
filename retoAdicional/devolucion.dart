// Etapa 4 · Devolución de un producto (ejercicio 4)
import 'menu.dart';

const int limiteSinAutorizacion = 30000;

// Suma precio × cantidad de cada producto de la venta (sin imprimir líneas)
int totalVenta(Map<String, int> venta) {
  int total = 0;
  for (var item in venta.entries) {
    total += menu[item.key]! * item.value;
  }
  return total;
}

// Valida y aplica la devolución sobre el Map de la venta (lo modifica).
// Devuelve el valor devuelto, o 0 si la devolución no se hizo.
int registrarDevolucion(
  Map<String, int> venta,
  String producto,
  int cantidad,
  String motivo,
  bool autorizadoPorAdmin,
  List<String> devoluciones,
) {
  print("Total original: ${totalVenta(venta)}");

  if (!venta.containsKey(producto)) {
    print("Error: $producto no hace parte de la venta");
    return 0;
  }
  int cantidadVendida = venta[producto]!;
  if (cantidad <= 0 || cantidad > cantidadVendida) {
    print(
      "Error: la cantidad a devolver ($cantidad) debe ser mayor que 0 y no superar la vendida ($cantidadVendida)",
    );
    return 0;
  }

  int valor = menu[producto]! * cantidad;
  if (valor > limiteSinAutorizacion && !autorizadoPorAdmin) {
    print(
      "Aviso: la devolución de $valor requiere autorización del administrador. No se hacen cambios",
    );
    return 0;
  }

  venta[producto] = cantidadVendida - cantidad;
  if (venta[producto] == 0) {
    venta.remove(producto);
  }
  devoluciones.add("$cantidad x $producto ($motivo): $valor");

  print("Devolución registrada: $valor");
  print("Venta actualizada: $venta");
  print("Nuevo total: ${totalVenta(venta)}");
  print("Devoluciones: $devoluciones");
  return valor;
}
