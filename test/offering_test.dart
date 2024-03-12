import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/offering_wrapper.dart';

void main() {
  Map<String, Object?> generateOfferingJSON(Map<String, Object> metadata) => {
        'identifier': 'almost_pro',
        'serverDescription': '',
        'metadata': metadata,
        'periodType': 'NORMAL',
        'availablePackages': [
          {
            'identifier': 'thepackage',
            'packageType': 'ANNUAL',
            'product': {
              'identifier': 'identifier',
              'description': 'desc',
              'title': 'Title',
              'price': 4900000,
              'priceString': '\$4.99',
              'currencyCode': 'USD',
              'introPrice': null,
              'discounts': null,
              'productCategory': null,
              'defaultOption': null,
              'subscriptionOptions': null,
              'presentedOfferingIdentifier': null,
              'subscriptionPeriod': null,
            },
            'presentedOfferingContext': {
              'offeringIdentifier': 'theoffering',
            },
          }
        ],
        'lifetime': null,
        'annual': null,
        'sixMonth': null,
        'threeMonth': null,
        'twoMonth': null,
        'monthly': null,
        'weekly': null,
      };

  test('metadata matches empty dictionary', () {
    final offeringJSON = generateOfferingJSON({});
    final offering = Offering.fromJson(offeringJSON);
    expect(offering.metadata, {});
  });

  test('metadata matches dictionary with values', () {
    const metadata = {
      'int': 5,
      'double': 5.5,
      'boolean': true,
      'string': 'five',
      'array': ['five'],
      'dictionary': {'string': 'five'},
    };

    final offeringJSON = generateOfferingJSON(metadata);
    final offering = Offering.fromJson(offeringJSON);
    expect(offering.metadata, metadata);
  });

  test('getMetadataString finds key with value', () {
    const metadata = {
      'int': 5,
      'double': 5.5,
      'boolean': true,
      'string': 'five',
      'array': ['five'],
      'dictionary': {'string': 'five'},
    };

    final offeringJSON = generateOfferingJSON(metadata);
    final offering = Offering.fromJson(offeringJSON);
    expect(offering.getMetadataString('string', 'NOT THIS'), 'five');
  });

  test('getMetadataString uses default for non-existent key', () {
    const metadata = {
      'int': 5,
      'double': 5.5,
      'boolean': true,
      'string': 'five',
      'array': ['five'],
      'dictionary': {'string': 'five'},
    };

    final offeringJSON = generateOfferingJSON(metadata);
    final offering = Offering.fromJson(offeringJSON);
    expect(offering.getMetadataString('pizza', 'cheese'), 'cheese');
  });

  test('getMetadataString uses default for key with value of non-string', () {
    const metadata = {
      'int': 5,
      'double': 5.5,
      'boolean': true,
      'string': 'five',
      'array': ['five'],
      'dictionary': {'string': 'five'},
    };

    final offeringJSON = generateOfferingJSON(metadata);
    final offering = Offering.fromJson(offeringJSON);
    expect(offering.getMetadataString('int', 'ope'), 'ope');
  });
}
