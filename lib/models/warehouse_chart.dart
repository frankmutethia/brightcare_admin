class Warehouse {
  final String warehouseName;
  final String colorVal;
  final String saleYear;
  final int warehouseVal;

  Warehouse(
    this.warehouseName,
    this.colorVal,
    this.saleYear,
    this.warehouseVal,
  );
  Warehouse.fromMap(Map<String, dynamic> map)
      : assert(map['warehouseName'] != null),
        assert(map['colorVal'] != null),
        warehouseName = map['warehouseName'],
        colorVal = map['colorVal'],
        saleYear = map['saleYear'],
        warehouseVal = map['warehouseVal'];

  @override
  String toString() => "Record<$warehouseName:$saleYear:$colorVal>";
}
