class MenuAddon {
  final String name;
  final int priceValue;

  const MenuAddon({required this.name, required this.priceValue});

  String get price {
    return 'Rp${priceValue.toString().replaceAllMapped(RegExp(r'(?=(\d{3})+$)'), (_) => '.')}';
  }
}
