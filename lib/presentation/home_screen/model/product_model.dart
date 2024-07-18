class Product {
  String name;
  String price;
  String description;
  int count;
  String image;

  Product(this.name, this.price, this.description, this.count, this.image);
}

List<Product> productList = [
  Product('Cleaner', "100", '', 0,
      'assets/image/3 in 1 Screen Cleaner Max™ - Black.jpeg'),
  Product('Airpod', "2000", '', 0,
      'assets/image/AirPods Pro (2nd generation) with MagSafe Charging Case (USB-C).jpeg'),
  Product('Mouse', "1500", '', 0,
      'assets/image/Bluetooth Rechargeable Mouse for HP 17_3_ Laptop Bluetooth Wireless Mouse Designed for Laptop _ PC _ Mac _ iPad pro _ Computer _ Tablet _ Android Midnight Black.jpeg'),
  Product('Headset', "1000", '', 0,
      'assets/image/Solid Wireless Earbud Compatible With Bluetooth.jpeg'),

  Product('Cleaner', "100", '', 0,
      'assets/image/3 in 1 Screen Cleaner Max™ - Black.jpeg'),
];
