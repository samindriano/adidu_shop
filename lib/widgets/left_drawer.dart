import 'package:flutter/material.dart';
import 'package:adidu_shop/screens/productlist_form.dart';
import 'package:adidu_shop/screens/product_entry_list.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Column(
              children: [
                Text(
                  'AdiduShop',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "Seluruh daftar produk ditampilkan di sini!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Halaman Utama'),
            onTap: () {
              final navigator = Navigator.of(context);
              navigator.pop();
              if (navigator.canPop()) {
                navigator.popUntil((route) => route.isFirst);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.post_add),
            title: const Text('Tambah Produk'),
            onTap: () {
              final navigator = Navigator.of(context);
              final currentRouteName = ModalRoute.of(context)?.settings.name;
              navigator.pop();
              if (currentRouteName == ProductFormPage.routeName) {
                return;
              }
              navigator.push(
                MaterialPageRoute(
                  builder: (context) => const ProductFormPage(),
                  settings: const RouteSettings(name: ProductFormPage.routeName),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.list_alt_rounded),
            title: const Text('Daftar Produk'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductEntryListPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
