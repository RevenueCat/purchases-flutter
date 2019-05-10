class Product {
  final String identifier,
      description,
      title,
      priceString,
      introPrice,
      introPriceString,
      introPricePeriod,
      introPriceCycles,
      currencyCode;
  final double price;

  Product.fromJson(Map<dynamic, dynamic> json)
      : identifier = json['identifier'],
        description = json['description'],
        title = json['title'],
        priceString = json['price_string'],
        introPrice = json['intro_price'],
        introPriceString = json['intro_price_string'],
        introPricePeriod = json['intro_price_period'],
        introPriceCycles = json['intro_price_cycles'],
        currencyCode = json['currency_code'],
        price = json['price'];

  @override
  String toString() {
    return 'Product{identifier: $identifier, description: $description, title: $title, priceString: $priceString, introPrice: $introPrice, introPriceString: $introPriceString, introPricePeriod: $introPricePeriod, introPriceCycles: $introPriceCycles, currencyCode: $currencyCode, price: $price}';
  }
}
