import 'package:flutter/material.dart';
import 'package:pet_plus_new/data/shop_items.dart';
import 'package:pet_plus_new/model/shop_items.dart';
import 'package:pet_plus_new/options/sort_option.dart';
import 'package:pet_plus_new/screens/shop/cart_screen.dart';
import 'package:pet_plus_new/screens/shop/shop_item_detail.dart';
import 'package:pet_plus_new/widgets/shop_item_card.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  String searchQuery = '';
  SortOption currentSort = SortOption.nameAZ;

  List<ShopItem> get filteredItems {
    var items =
        shopItemsList
            .where(
              (item) =>
                  item.title.toLowerCase().contains(
                    searchQuery.toLowerCase(),
                  ) ||
                  item.description.toLowerCase().contains(
                    searchQuery.toLowerCase(),
                  ),
            )
            .toList();
    return sortItems(items, currentSort);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Pet Shop",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const CartScreen();
                    },
                  ),
                );
              },
              child: const Icon(
                Icons.shopping_cart_checkout,
                color: Color.fromARGB(255, 20, 32, 166),
                size: 30,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search pet products...',
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 20, 32, 166),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(15),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Nutritions and Dog Foods",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  PopupMenuButton<SortOption>(
                    icon: const Icon(
                      Icons.sort_outlined,
                      color: Color.fromARGB(255, 20, 32, 166),
                    ),
                    onSelected: (SortOption value) {
                      setState(() {
                        currentSort = value;
                      });
                    },
                    itemBuilder:
                        (BuildContext context) => [
                          for (var option in SortOption.values)
                            PopupMenuItem(
                              value: option,
                              child: Row(
                                children: [
                                  Icon(
                                    option == SortOption.rating
                                        ? Icons.star
                                        : option.toString().contains('price')
                                        ? Icons.attach_money
                                        : Icons.sort_by_alpha,
                                    size: 18,
                                    color:
                                        currentSort == option
                                            ? Color.fromARGB(255, 20, 32, 166)
                                            : Colors.grey,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    getSortText(option),
                                    style: TextStyle(
                                      color:
                                          currentSort == option
                                              ? Color.fromARGB(255, 20, 32, 166)
                                              : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  spacing: 31,
                  runSpacing: 20,
                  alignment: WrapAlignment.spaceBetween,
                  children:
                      filteredItems.map((item) {
                        return ShopItemCard(
                          item: item,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => ShopItemDetails(item: item),
                              ),
                            );
                          },
                        );
                      }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
