import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/offering_wrapper.dart';
import 'package:purchases_flutter/models/offerings_wrapper.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';
import 'package:purchases_flutter/models/presented_offering_context_wrapper.dart';
import 'package:purchases_flutter/models/store_product_wrapper.dart';

void main() {
  group('Offerings.fromJson', () {
    test('parses minimum required fields', () {
      final json = {
        'all': {
          'main': {
            'identifier': 'main',
            'serverDescription': 'Main offering',
            'metadata': {},
            'availablePackages': [],
          },
        },
        'current': null,
      };
      final info = Offerings.fromJson(json);
      const expected = Offerings({
        'main': Offering(
          'main',
          'Main offering',
          {},
          [],
        ),
      },
        current: null,
      );
      expect(info, equals(expected));
    });

    test('parses all fields', () {
      final json = {
        'all': {
          'main': {
            'identifier': 'main',
            'serverDescription': 'Main offering',
            'metadata': {'feature': 'premium'},
            'availablePackages': [
              {
                'identifier': 'monthly',
                'packageType': 'MONTHLY',
                'product': {
                  'identifier': 'prod1',
                  'description': 'desc',
                  'title': 'title',
                  'price': 9.99,
                  'priceString': '\t9.99',
                  'currencyCode': 'USD',
                },
                'presentedOfferingContext': {
                  'offeringIdentifier': 'main',
                  'placementIdentifier': null,
                  'targetingContext': null,
                },
              },
              {
                'identifier': 'lifetime',
                'packageType': 'LIFETIME',
                'product': {
                  'identifier': 'prod2',
                  'description': 'desc2',
                  'title': 'title2',
                  'price': 99.99,
                  'priceString': '\t99.99',
                  'currencyCode': 'USD',
                },
                'presentedOfferingContext': {
                  'offeringIdentifier': 'main',
                  'placementIdentifier': null,
                  'targetingContext': null,
                },
              },
              {
                'identifier': 'annual',
                'packageType': 'ANNUAL',
                'product': {
                  'identifier': 'prod3',
                  'description': 'desc3',
                  'title': 'title3',
                  'price': 49.99,
                  'priceString': '\t49.99',
                  'currencyCode': 'USD',
                },
                'presentedOfferingContext': {
                  'offeringIdentifier': 'main',
                  'placementIdentifier': null,
                  'targetingContext': null,
                },
              },
              {
                'identifier': 'sixMonth',
                'packageType': 'SIX_MONTH',
                'product': {
                  'identifier': 'prod4',
                  'description': 'desc4',
                  'title': 'title4',
                  'price': 29.99,
                  'priceString': '\t29.99',
                  'currencyCode': 'USD',
                },
                'presentedOfferingContext': {
                  'offeringIdentifier': 'main',
                  'placementIdentifier': null,
                  'targetingContext': null,
                },
              },
              {
                'identifier': 'threeMonth',
                'packageType': 'THREE_MONTH',
                'product': {
                  'identifier': 'prod5',
                  'description': 'desc5',
                  'title': 'title5',
                  'price': 19.99,
                  'priceString': '\t19.99',
                  'currencyCode': 'USD',
                },
                'presentedOfferingContext': {
                  'offeringIdentifier': 'main',
                  'placementIdentifier': null,
                  'targetingContext': null,
                },
              },
              {
                'identifier': 'twoMonth',
                'packageType': 'TWO_MONTH',
                'product': {
                  'identifier': 'prod6',
                  'description': 'desc6',
                  'title': 'title6',
                  'price': 14.99,
                  'priceString': '\t14.99',
                  'currencyCode': 'USD',
                },
                'presentedOfferingContext': {
                  'offeringIdentifier': 'main',
                  'placementIdentifier': null,
                  'targetingContext': null,
                },
              },
              {
                'identifier': 'monthly',
                'packageType': 'MONTHLY',
                'product': {
                  'identifier': 'prod7',
                  'description': 'desc7',
                  'title': 'title7',
                  'price': 9.99,
                  'priceString': '\t9.99',
                  'currencyCode': 'USD',
                },
                'presentedOfferingContext': {
                  'offeringIdentifier': 'main',
                  'placementIdentifier': null,
                  'targetingContext': null,
                },
              },
              {
                'identifier': 'weekly',
                'packageType': 'WEEKLY',
                'product': {
                  'identifier': 'prod8',
                  'description': 'desc8',
                  'title': 'title8',
                  'price': 4.99,
                  'priceString': '\t4.99',
                  'currencyCode': 'USD',
                },
                'presentedOfferingContext': {
                  'offeringIdentifier': 'main',
                  'placementIdentifier': null,
                  'targetingContext': null,
                },
              },
            ],
            'lifetime': {
              'identifier': 'lifetime',
              'packageType': 'LIFETIME',
              'product': {
                'identifier': 'prod2',
                'description': 'desc2',
                'title': 'title2',
                'price': 99.99,
                'priceString': '\t99.99',
                'currencyCode': 'USD',
              },
              'presentedOfferingContext': {
                'offeringIdentifier': 'main',
                'placementIdentifier': null,
                'targetingContext': null,
              },
            },
            'annual': {
              'identifier': 'annual',
              'packageType': 'ANNUAL',
              'product': {
                'identifier': 'prod3',
                'description': 'desc3',
                'title': 'title3',
                'price': 49.99,
                'priceString': '\t49.99',
                'currencyCode': 'USD',
              },
              'presentedOfferingContext': {
                'offeringIdentifier': 'main',
                'placementIdentifier': null,
                'targetingContext': null,
              },
            },
            'sixMonth': {
              'identifier': 'sixMonth',
              'packageType': 'SIX_MONTH',
              'product': {
                'identifier': 'prod4',
                'description': 'desc4',
                'title': 'title4',
                'price': 29.99,
                'priceString': '\t29.99',
                'currencyCode': 'USD',
              },
              'presentedOfferingContext': {
                'offeringIdentifier': 'main',
                'placementIdentifier': null,
                'targetingContext': null,
              },
            },
            'threeMonth': {
              'identifier': 'threeMonth',
              'packageType': 'THREE_MONTH',
              'product': {
                'identifier': 'prod5',
                'description': 'desc5',
                'title': 'title5',
                'price': 19.99,
                'priceString': '\t19.99',
                'currencyCode': 'USD',
              },
              'presentedOfferingContext': {
                'offeringIdentifier': 'main',
                'placementIdentifier': null,
                'targetingContext': null,
              },
            },
            'twoMonth': {
              'identifier': 'twoMonth',
              'packageType': 'TWO_MONTH',
              'product': {
                'identifier': 'prod6',
                'description': 'desc6',
                'title': 'title6',
                'price': 14.99,
                'priceString': '\t14.99',
                'currencyCode': 'USD',
              },
              'presentedOfferingContext': {
                'offeringIdentifier': 'main',
                'placementIdentifier': null,
                'targetingContext': null,
              },
            },
            'monthly': {
              'identifier': 'monthly',
              'packageType': 'MONTHLY',
              'product': {
                'identifier': 'prod7',
                'description': 'desc7',
                'title': 'title7',
                'price': 9.99,
                'priceString': '\t9.99',
                'currencyCode': 'USD',
              },
              'presentedOfferingContext': {
                'offeringIdentifier': 'main',
                'placementIdentifier': null,
                'targetingContext': null,
              },
            },
            'weekly': {
              'identifier': 'weekly',
              'packageType': 'WEEKLY',
              'product': {
                'identifier': 'prod8',
                'description': 'desc8',
                'title': 'title8',
                'price': 4.99,
                'priceString': '\t4.99',
                'currencyCode': 'USD',
              },
              'presentedOfferingContext': {
                'offeringIdentifier': 'main',
                'placementIdentifier': null,
                'targetingContext': null,
              },
            },
          },
        },
        'current': {
          'identifier': 'main',
          'serverDescription': 'Main offering',
          'metadata': {'feature': 'premium'},
          'availablePackages': [
            {
              'identifier': 'monthly',
              'packageType': 'MONTHLY',
              'product': {
                'identifier': 'prod1',
                'description': 'desc',
                'title': 'title',
                'price': 9.99,
                'priceString': '\t9.99',
                'currencyCode': 'USD',
              },
              'presentedOfferingContext': {
                'offeringIdentifier': 'main',
                'placementIdentifier': null,
                'targetingContext': null,
              },
            },
            {
              'identifier': 'lifetime',
              'packageType': 'LIFETIME',
              'product': {
                'identifier': 'prod2',
                'description': 'desc2',
                'title': 'title2',
                'price': 99.99,
                'priceString': '\t99.99',
                'currencyCode': 'USD',
              },
              'presentedOfferingContext': {
                'offeringIdentifier': 'main',
                'placementIdentifier': null,
                'targetingContext': null,
              },
            },
            {
              'identifier': 'annual',
              'packageType': 'ANNUAL',
              'product': {
                'identifier': 'prod3',
                'description': 'desc3',
                'title': 'title3',
                'price': 49.99,
                'priceString': '\t49.99',
                'currencyCode': 'USD',
              },
              'presentedOfferingContext': {
                'offeringIdentifier': 'main',
                'placementIdentifier': null,
                'targetingContext': null,
              },
            },
            {
              'identifier': 'sixMonth',
              'packageType': 'SIX_MONTH',
              'product': {
                'identifier': 'prod4',
                'description': 'desc4',
                'title': 'title4',
                'price': 29.99,
                'priceString': '\t29.99',
                'currencyCode': 'USD',
              },
              'presentedOfferingContext': {
                'offeringIdentifier': 'main',
                'placementIdentifier': null,
                'targetingContext': null,
              },
            },
            {
              'identifier': 'threeMonth',
              'packageType': 'THREE_MONTH',
              'product': {
                'identifier': 'prod5',
                'description': 'desc5',
                'title': 'title5',
                'price': 19.99,
                'priceString': '\t19.99',
                'currencyCode': 'USD',
              },
              'presentedOfferingContext': {
                'offeringIdentifier': 'main',
                'placementIdentifier': null,
                'targetingContext': null,
              },
            },
            {
              'identifier': 'twoMonth',
              'packageType': 'TWO_MONTH',
              'product': {
                'identifier': 'prod6',
                'description': 'desc6',
                'title': 'title6',
                'price': 14.99,
                'priceString': '\t14.99',
                'currencyCode': 'USD',
              },
              'presentedOfferingContext': {
                'offeringIdentifier': 'main',
                'placementIdentifier': null,
                'targetingContext': null,
              },
            },
            {
              'identifier': 'monthly',
              'packageType': 'MONTHLY',
              'product': {
                'identifier': 'prod7',
                'description': 'desc7',
                'title': 'title7',
                'price': 9.99,
                'priceString': '\t9.99',
                'currencyCode': 'USD',
              },
              'presentedOfferingContext': {
                'offeringIdentifier': 'main',
                'placementIdentifier': null,
                'targetingContext': null,
              },
            },
            {
              'identifier': 'weekly',
              'packageType': 'WEEKLY',
              'product': {
                'identifier': 'prod8',
                'description': 'desc8',
                'title': 'title8',
                'price': 4.99,
                'priceString': '\t4.99',
                'currencyCode': 'USD',
              },
              'presentedOfferingContext': {
                'offeringIdentifier': 'main',
                'placementIdentifier': null,
                'targetingContext': null,
              },
            },
          ],
          'lifetime': {
            'identifier': 'lifetime',
            'packageType': 'LIFETIME',
            'product': {
              'identifier': 'prod2',
              'description': 'desc2',
              'title': 'title2',
              'price': 99.99,
              'priceString': '\t99.99',
              'currencyCode': 'USD',
            },
            'presentedOfferingContext': {
              'offeringIdentifier': 'main',
              'placementIdentifier': null,
              'targetingContext': null,
            },
          },
          'annual': {
            'identifier': 'annual',
            'packageType': 'ANNUAL',
            'product': {
              'identifier': 'prod3',
              'description': 'desc3',
              'title': 'title3',
              'price': 49.99,
              'priceString': '\t49.99',
              'currencyCode': 'USD',
            },
            'presentedOfferingContext': {
              'offeringIdentifier': 'main',
              'placementIdentifier': null,
              'targetingContext': null,
            },
          },
          'sixMonth': {
            'identifier': 'sixMonth',
            'packageType': 'SIX_MONTH',
            'product': {
              'identifier': 'prod4',
              'description': 'desc4',
              'title': 'title4',
              'price': 29.99,
              'priceString': '\t29.99',
              'currencyCode': 'USD',
            },
            'presentedOfferingContext': {
              'offeringIdentifier': 'main',
              'placementIdentifier': null,
              'targetingContext': null,
            },
          },
          'threeMonth': {
            'identifier': 'threeMonth',
            'packageType': 'THREE_MONTH',
            'product': {
              'identifier': 'prod5',
              'description': 'desc5',
              'title': 'title5',
              'price': 19.99,
              'priceString': '\t19.99',
              'currencyCode': 'USD',
            },
            'presentedOfferingContext': {
              'offeringIdentifier': 'main',
              'placementIdentifier': null,
              'targetingContext': null,
            },
          },
          'twoMonth': {
            'identifier': 'twoMonth',
            'packageType': 'TWO_MONTH',
            'product': {
              'identifier': 'prod6',
              'description': 'desc6',
              'title': 'title6',
              'price': 14.99,
              'priceString': '\t14.99',
              'currencyCode': 'USD',
            },
            'presentedOfferingContext': {
              'offeringIdentifier': 'main',
              'placementIdentifier': null,
              'targetingContext': null,
            },
          },
          'monthly': {
            'identifier': 'monthly',
            'packageType': 'MONTHLY',
            'product': {
              'identifier': 'prod7',
              'description': 'desc7',
              'title': 'title7',
              'price': 9.99,
              'priceString': '\t9.99',
              'currencyCode': 'USD',
            },
            'presentedOfferingContext': {
              'offeringIdentifier': 'main',
              'placementIdentifier': null,
              'targetingContext': null,
            },
          },
          'weekly': {
            'identifier': 'weekly',
            'packageType': 'WEEKLY',
            'product': {
              'identifier': 'prod8',
              'description': 'desc8',
              'title': 'title8',
              'price': 4.99,
              'priceString': '\t4.99',
              'currencyCode': 'USD',
            },
            'presentedOfferingContext': {
              'offeringIdentifier': 'main',
              'placementIdentifier': null,
              'targetingContext': null,
            },
          },
        },
      };
      final info = Offerings.fromJson(json);
      const expected = Offerings({
        'main': Offering(
          'main',
          'Main offering',
          {'feature': 'premium'},
          [
            Package(
              'monthly',
              PackageType.monthly,
              StoreProduct(
                'prod1',
                'desc',
                'title',
                9.99,
                '\t9.99',
                'USD',
              ),
              PresentedOfferingContext('main', null, null),
            ),
            Package(
              'lifetime',
              PackageType.lifetime,
              StoreProduct('prod2', 'desc2', 'title2', 99.99, '\t99.99', 'USD'),
              PresentedOfferingContext('main', null, null),
            ),
            Package(
              'annual',
              PackageType.annual,
              StoreProduct('prod3', 'desc3', 'title3', 49.99, '\t49.99', 'USD'),
              PresentedOfferingContext('main', null, null),
            ),
            Package(
              'sixMonth',
              PackageType.sixMonth,
              StoreProduct('prod4', 'desc4', 'title4', 29.99, '\t29.99', 'USD'),
              PresentedOfferingContext('main', null, null),
            ),
            Package(
              'threeMonth',
              PackageType.threeMonth,
              StoreProduct('prod5', 'desc5', 'title5', 19.99, '\t19.99', 'USD'),
              PresentedOfferingContext('main', null, null),
            ),
            Package(
              'twoMonth',
              PackageType.twoMonth,
              StoreProduct('prod6', 'desc6', 'title6', 14.99, '\t14.99', 'USD'),
              PresentedOfferingContext('main', null, null),
            ),
            Package(
              'monthly',
              PackageType.monthly,
              StoreProduct('prod7', 'desc7', 'title7', 9.99, '\t9.99', 'USD'),
              PresentedOfferingContext('main', null, null),
            ),
            Package(
              'weekly',
              PackageType.weekly,
              StoreProduct('prod8', 'desc8', 'title8', 4.99, '\t4.99', 'USD'),
              PresentedOfferingContext('main', null, null),
            ),
          ],
          lifetime: Package(
            'lifetime',
            PackageType.lifetime,
            StoreProduct('prod2', 'desc2', 'title2', 99.99, '\t99.99', 'USD'),
            PresentedOfferingContext('main', null, null),
          ),
          annual: Package(
            'annual',
            PackageType.annual,
            StoreProduct('prod3', 'desc3', 'title3', 49.99, '\t49.99', 'USD'),
            PresentedOfferingContext('main', null, null),
          ),
          sixMonth: Package(
            'sixMonth',
            PackageType.sixMonth,
            StoreProduct('prod4', 'desc4', 'title4', 29.99, '\t29.99', 'USD'),
            PresentedOfferingContext('main', null, null),
          ),
          threeMonth: Package(
            'threeMonth',
            PackageType.threeMonth,
            StoreProduct('prod5', 'desc5', 'title5', 19.99, '\t19.99', 'USD'),
            PresentedOfferingContext('main', null, null),
          ),
          twoMonth: Package(
            'twoMonth',
            PackageType.twoMonth,
            StoreProduct('prod6', 'desc6', 'title6', 14.99, '\t14.99', 'USD'),
            PresentedOfferingContext('main', null, null),
          ),
          monthly: Package(
            'monthly',
            PackageType.monthly,
            StoreProduct('prod7', 'desc7', 'title7', 9.99, '\t9.99', 'USD'),
            PresentedOfferingContext('main', null, null),
          ),
          weekly: Package(
            'weekly',
            PackageType.weekly,
            StoreProduct('prod8', 'desc8', 'title8', 4.99, '\t4.99', 'USD'),
            PresentedOfferingContext('main', null, null),
          ),
        ),
      },
      current: Offering(
        'main',
        'Main offering',
        {'feature': 'premium'},
        [
          Package(
            'monthly',
            PackageType.monthly,
            StoreProduct(
              'prod1',
              'desc',
              'title',
              9.99,
              '\t9.99',
              'USD',
            ),
            PresentedOfferingContext('main', null, null),
          ),
          Package(
            'lifetime',
            PackageType.lifetime,
            StoreProduct('prod2', 'desc2', 'title2', 99.99, '\t99.99', 'USD'),
            PresentedOfferingContext('main', null, null),
          ),
          Package(
            'annual',
            PackageType.annual,
            StoreProduct('prod3', 'desc3', 'title3', 49.99, '\t49.99', 'USD'),
            PresentedOfferingContext('main', null, null),
          ),
          Package(
            'sixMonth',
            PackageType.sixMonth,
            StoreProduct('prod4', 'desc4', 'title4', 29.99, '\t29.99', 'USD'),
            PresentedOfferingContext('main', null, null),
          ),
          Package(
            'threeMonth',
            PackageType.threeMonth,
            StoreProduct('prod5', 'desc5', 'title5', 19.99, '\t19.99', 'USD'),
            PresentedOfferingContext('main', null, null),
          ),
          Package(
            'twoMonth',
            PackageType.twoMonth,
            StoreProduct('prod6', 'desc6', 'title6', 14.99, '\t14.99', 'USD'),
            PresentedOfferingContext('main', null, null),
          ),
          Package(
            'monthly',
            PackageType.monthly,
            StoreProduct('prod7', 'desc7', 'title7', 9.99, '\t9.99', 'USD'),
            PresentedOfferingContext('main', null, null),
          ),
          Package(
            'weekly',
            PackageType.weekly,
            StoreProduct('prod8', 'desc8', 'title8', 4.99, '\t4.99', 'USD'),
            PresentedOfferingContext('main', null, null),
          ),
        ],
        lifetime: Package(
          'lifetime',
          PackageType.lifetime,
          StoreProduct('prod2', 'desc2', 'title2', 99.99, '\t99.99', 'USD'),
          PresentedOfferingContext('main', null, null),
        ),
        annual: Package(
          'annual',
          PackageType.annual,
          StoreProduct('prod3', 'desc3', 'title3', 49.99, '\t49.99', 'USD'),
          PresentedOfferingContext('main', null, null),
        ),
        sixMonth: Package(
          'sixMonth',
          PackageType.sixMonth,
          StoreProduct('prod4', 'desc4', 'title4', 29.99, '\t29.99', 'USD'),
          PresentedOfferingContext('main', null, null),
        ),
        threeMonth: Package(
          'threeMonth',
          PackageType.threeMonth,
          StoreProduct('prod5', 'desc5', 'title5', 19.99, '\t19.99', 'USD'),
          PresentedOfferingContext('main', null, null),
        ),
        twoMonth: Package(
          'twoMonth',
          PackageType.twoMonth,
          StoreProduct('prod6', 'desc6', 'title6', 14.99, '\t14.99', 'USD'),
          PresentedOfferingContext('main', null, null),
        ),
        monthly: Package(
          'monthly',
          PackageType.monthly,
          StoreProduct('prod7', 'desc7', 'title7', 9.99, '\t9.99', 'USD'),
          PresentedOfferingContext('main', null, null),
        ),
        weekly: Package(
          'weekly',
          PackageType.weekly,
          StoreProduct('prod8', 'desc8', 'title8', 4.99, '\t4.99', 'USD'),
          PresentedOfferingContext('main', null, null),
        ),
      ),
      );
      expect(info, equals(expected));
    });
  });
} 
