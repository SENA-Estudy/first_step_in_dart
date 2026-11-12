// Reto · Jornada completa del POS
// Une los cinco ejercicios en un solo programa: abre la caja, registra las
// ventas (mesa 4, venta con descuento y mesa 7 con devolución), guarda cada
// total en las listas paralelas totales/medios y, al final, cierra la caja.
//
// Ejecutar con: dart run retoAdicional/jornada_completa.dart
import 'abrir_caja.dart';
import 'cierre_caja.dart';
import 'devolucion.dart';
import 'registrar_venta.dart';
import 'venta_con_descuento.dart';

void main() {
  // Estado de la jornada
  bool cajaAbierta = false;
  int baseInicial = 200000;
  List<String> movimientos = [];
  List<int> totales = [];
  List<String> medios = [];

  // Guarda una venta en las listas paralelas y en los movimientos
  void guardarVenta(String descripcion, int total, String medio) {
    totales.add(total);
    medios.add(medio);
    movimientos.add("VENTA $descripcion: $total ($medio)");
  }

  // ---------- 1. Abrir la caja ----------
  print("===== 1. Apertura de caja =====");
  cajaAbierta = abrirCaja(
    'Laura',
    'cajero',
    baseInicial,
    cajaAbierta,
    movimientos,
  );
  if (!cajaAbierta) {
    print("La caja no se pudo abrir, no se pueden registrar ventas");
    return;
  }

  // ---------- 2. Venta de la mesa 4 ----------
  print("\n===== 2. Venta mesa 4 =====");
  Map<String, int> pedidoMesa4 = {
    'Bandeja paisa': 2,
    'Limonada': 3,
    'Postre del día': 1,
    'Cazuela': 1, // no está en el menú
  };
  int? totalMesa4 = registrarVenta(pedidoMesa4, true, 'efectivo', 110000, null);
  if (totalMesa4 != null) {
    guardarVenta("mesa 4", totalMesa4, 'efectivo');
  }

  // ---------- 3. Venta con descuento (cumpleaños) ----------
  print("\n===== 3. Venta con descuento =====");
  Map<String, int> pedidoCumple = {
    'Ajiaco': 3,
    'Jugo natural': 4,
    'Postre del día': 2,
    'Bandeja paisa': 1,
  };
  int totalCumple = calcularVentaConDescuento(pedidoCumple, 'CUMPLE', true);
  guardarVenta("cumpleaños", totalCumple, 'credito');

  // ---------- 4. Venta de la mesa 7 con devolución ----------
  print("\n===== 4. Devolución mesa 7 =====");
  Map<String, int> ventaMesa7 = {
    'Sancocho': 2,
    'Gaseosa': 3,
    'Postre del día': 2,
  };
  List<String> devoluciones = [];
  registrarDevolucion(
    ventaMesa7,
    'Gaseosa',
    1,
    'Producto en mal estado',
    false,
    devoluciones,
  );
  // Se guarda el total ya ajustado después de la devolución
  guardarVenta("mesa 7", totalVenta(ventaMesa7), 'debito');

  // ---------- 5. Cierre de caja ----------
  print("\n===== 5. Cierre de caja =====");
  Map<String, int> egresos = {
    'Compra de hielo': 15000,
    'Recarga de gas': 20000,
  };
  int efectivoContado = 265100;
  print("Movimientos del día: $movimientos");
  cerrarCaja(baseInicial, totales, medios, egresos, efectivoContado);
  // Fin de la jornada: se cierra la caja
  cajaAbierta = false;
  movimientos.add("CIERRE de caja");
  print("Caja cerrada. Último movimiento: ${movimientos.last}");
}
