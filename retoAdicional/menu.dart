// Menú del restaurante compartido por todas las etapas de la jornada.
const Map<String, int> menu = {
  'Ajiaco': 28000,
  'Bandeja paisa': 32000,
  'Sancocho': 26000,
  'Limonada': 6000,
  'Jugo natural': 7000,
  'Gaseosa': 5000,
  'Postre del día': 9000,
};

// Recorre un pedido, muestra cada línea y devuelve el subtotal.
// Los productos que no están en el menú se avisan y se omiten.
int calcularSubtotal(Map<String, int> pedido) {
  int subtotal = 0;
  for (var producto in pedido.keys) {
    if (!menu.containsKey(producto)) {
      print("$producto: no existe en el menú, se omite");
      continue;
    }
    int cantidad = pedido[producto]!;
    int valorLinea = menu[producto]! * cantidad;
    print("$producto x$cantidad = $valorLinea");
    subtotal += valorLinea;
  }
  return subtotal;
}
