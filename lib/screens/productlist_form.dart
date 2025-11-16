import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:adidu_shop/widgets/left_drawer.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:adidu_shop/screens/menu.dart';

class ProductFormPage extends StatefulWidget {
    const ProductFormPage({super.key});

    static const routeName = '/add-product';

    @override
    State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
    final _formKey = GlobalKey<FormState>();
    String _name = "";
    String _price = "";
    String _description = "";
    String _thumbnail = "";
    String _category = 'football shoes';
    bool _isFeatured = false;
    
    final List<String> _categories = [
        'football shoes',
        'running shoes',
        'accessories',
        'jersey',
    ];

    @override
    Widget build(BuildContext context) {
        final request = context.watch<CookieRequest>();
        return Scaffold(
            appBar: AppBar(
                title: const Center(child: Text('Add Product')),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
            ),
            drawer: const LeftDrawer(),
            body: SafeArea(
                child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                        padding: const EdgeInsets.only(top: 8, bottom: 24),
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            // === Name ===
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                    textCapitalization: TextCapitalization.words,
                                    decoration: InputDecoration(
                                        hintText: "Nama Produk",
                                        labelText: "Nama Produk",
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                        ),
                                    ),
                                    onChanged: (value) {
                                        setState(() {
                                            _name = value;
                                        });
                                    },
                                    validator: (value) {
                                        if (value == null || value.isEmpty) {
                                            return "Nama produk tidak boleh kosong!";
                                        }
                                        if (value.trim().length < 3) {
                                            return "Nama produk minimal 3 karakter.";
                                        }
                                        return null;
                                    },
                                ),
                            ),

                            // === Price ===
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                    keyboardType: const TextInputType.numberWithOptions(
                                        decimal: true,
                                        signed: false,
                                    ),
                                    decoration: InputDecoration(
                                        hintText: "Harga Produk",
                                        labelText: "Harga Produk",
                                        prefixText: "Rp ",
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                        ),
                                    ),
                                    onChanged: (value) {
                                        setState(() {
                                            _price = value;
                                        });
                                    },
                                    validator: (value) {
                                        if (value == null || value.isEmpty) {
                                            return "Harga tidak boleh kosong!";
                                        }
                                        final parsedPrice = double.tryParse(value.trim());
                                        if (parsedPrice == null) {
                                            return "Harga harus berupa angka yang valid.";
                                        }
                                        if (parsedPrice <= 0) {
                                            return "Harga harus lebih dari 0.";
                                        }
                                        if (parsedPrice > 100000000) {
                                            return "Harga terlalu besar.";
                                        }
                                        return null;
                                    },
                                ),
                            ),

                            // === Description ===
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                        hintText: "Deskripsi Produk",
                                        labelText: "Deskripsi Produk",
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                        ),
                                    ),
                                    onChanged: (String? value) {
                                        setState(() {
                                            _description = value!;
                                        });
                                    },
                                    validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                            return "Deskripsi tidak boleh kosong!";
                                        }
                                        if (value.trim().length < 10) {
                                            return "Deskripsi minimal 10 karakter.";
                                        }
                                        return null;
                                    },
                                ),
                            ),

                            // === Category ===
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButtonFormField<String>(
                                    initialValue: _category,
                                    decoration: InputDecoration(
                                        labelText: "Kategori",
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                        ),
                                    ),
                                    items: _categories
                                        .map(
                                            (cat) => DropdownMenuItem(
                                                value: cat,
                                                child: Text(cat[0].toUpperCase() + cat.substring(1)),
                                            ),
                                        )
                                        .toList(),
                                    onChanged: (String? value) {
                                        setState(() {
                                            _category = value!;
                                        });
                                    },
                                ),
                            ),

                            // === Thumbnail URL ===
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                    decoration: InputDecoration(
                                        hintText: "URL Thumbnail",
                                        labelText: "URL Thumbnail",
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                        ),
                                    ),
                                    onChanged: (String? value) {
                                        setState(() {
                                            _thumbnail = value!;
                                        });
                                    },
                                ),
                            ),

                            // === Is Featured ===
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SwitchListTile(
                                    title: const Text("Tandai sebagai Produk Unggulan"),
                                    value: _isFeatured,
                                    onChanged: (bool value) {
                                        setState(() {
                                            _isFeatured = value;
                                        });
                                    },
                                ),
                            ),

                            // === Tombol Simpan ===
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor: WidgetStateProperty.all(
                                                Theme.of(context).colorScheme.primary,
                                            ),
                                        ),
                                        onPressed: () async {
                                            if (_formKey.currentState!.validate()) {
                                                // Using local Django server. For Android emulator use http://10.0.2.2/
                                                final response = await request.postJson(
                                                  "http://localhost:8000/create-flutter/",
                                                  jsonEncode({
                                                    "name": _name,
                                                    "description": _description,
                                                    "thumbnail": _thumbnail,
                                                    "category": _category,
                                                    "is_featured": _isFeatured,
                                                    "price": double.tryParse(_price) ?? 0,
                                                  }),
                                                );
                                                if (!mounted) return;
                                                if (response['status'] == 'success') {
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(
                                                        content: Text("Product successfully saved!"),
                                                      ),
                                                    );
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => MyHomePage(),
                                                      ),
                                                    );
                                                } else {
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          response['message'] ?? "Something went wrong, please try again.",
                                                        ),
                                                      ),
                                                    );
                                                }
                                            }
                                        },
                                        child: const Text(
                                            "Simpan",
                                            style: TextStyle(color: Colors.white),
                                        ),
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        ),
    );
    }

    void _resetForm() {
        setState(() {
            _name = "";
            _price = "";
            _description = "";
            _thumbnail = "";
            _category = _categories.first;
            _isFeatured = false;
            _formKey.currentState!.reset();
        });
    }
}
