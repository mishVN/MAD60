import 'package:pet_plus_new/model/shop_items.dart';

enum SortOption { priceHighToLow, priceLowToHigh, nameAZ, nameZA, rating }

List<ShopItem> sortItems(List<ShopItem> items, SortOption option) {
  switch (option) {
    case SortOption.priceHighToLow:
      items.sort(
        (a, b) => double.parse(b.price).compareTo(double.parse(a.price)),
      );
      break;
    case SortOption.priceLowToHigh:
      items.sort(
        (a, b) => double.parse(a.price).compareTo(double.parse(b.price)),
      );
      break;
    case SortOption.nameAZ:
      items.sort((a, b) => a.title.compareTo(b.title));
      break;
    case SortOption.nameZA:
      items.sort((a, b) => b.title.compareTo(a.title));
      break;
    case SortOption.rating:
      items.sort((a, b) => b.rating.compareTo(a.rating));
      break;
  }
  return items;
}

String getSortText(SortOption option) {
  switch (option) {
    case SortOption.priceHighToLow:
      return 'Price: High to Low';
    case SortOption.priceLowToHigh:
      return 'Price: Low to High';
    case SortOption.nameAZ:
      return 'Name: A to Z';
    case SortOption.nameZA:
      return 'Name: Z to A';
    case SortOption.rating:
      return 'Highest Rating';
  }
}
