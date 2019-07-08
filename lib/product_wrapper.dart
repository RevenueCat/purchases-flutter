class Product {
  /// Product Id.
  final String identifier;

  /// Description of the product.
  final String description;

  /// Title of the product.
  final String title;

  /// Price of the product in the local currency.
  final double price;

  /// Formatted price of the item, including its currency sign.
  final String priceString;

  /// **Android only**. Introductory price of a subscription in the local currency.
  final String introPrice;

  /// **Android only**. Formatted introductory price of a subscription, including
  /// its currency sign, such as €3.99.
  final String introPriceString;

  /// **Android only**. Billing period of the introductory price, specified in
  /// ISO 8601 format.
  final String introPricePeriod;

  /// **Android only**. Number of subscription billing periods for which the
  /// user will be given the introductory price, such as 3.
  final String introPriceCycles;

  /// Currency code for price and original price.
  final String currencyCode;

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
