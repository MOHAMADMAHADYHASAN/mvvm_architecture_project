import 'package:flutter/material.dart';

import 'package:mvvm_app/viewModel/home_View_model.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';
import '../utils/shimerCode/shimmer.dart';
import '../viewModel/user_View_Model.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    homeViewModel.fetchProductListApi();
  }

  @override
  Widget build(BuildContext context) {

    return  Consumer<HomeViewModel>(
        builder: (context, value, child) {
          switch (value.productList.status) {
          // ================== LOADING STATE (SHIMMER) ==================
            case Status.LOADING:
              return shimmerCode();

          // ================== ERROR STATE ==================
            case Status.ERROR:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 50,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      value.productList.message.toString(),
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              );

          // ================== COMPLETED STATE (MAIN DESIGN) ==================
            case Status.COMPLETED:
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                itemCount: value.productList.data?.products?.length,
                itemBuilder: (context, index) {
                  final product = value.productList.data?.products?[index];
                  // container use
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pinkAccent.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ২. প্রোডাক্ট ইমেজ ডিজাইন
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              product?.thumbnail ?? "",
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.grey.shade200,
                                    child: const Icon(
                                      Icons.image_not_supported,
                                      color: Colors.red,
                                    ),
                                  ),
                            ),
                          ),
                          const SizedBox(width: 15),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //===================product title===================
                                Text(
                                  product?.title.toString() ?? 'No Title',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5),

                                Row(
                                  children: [
                                    //ratting container------
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.amber.shade100,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            size: 12,
                                            color: Colors.orange,
                                          ),
                                          const SizedBox(width: 2),
                                          Text(
                                            product?.rating.toString() ?? "0.0",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    //stock.....
                                    Text(
                                      "Stock: ${product?.stock}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: (product?.stock ?? 0) > 0
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 8),

                                //======================description===========0========================
                                Text(
                                  product?.description.toString() ?? "",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),

                                const SizedBox(height: 8),
                                //==============================================price=============================
                                Text(
                                  "\$${product?.price}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );

            default:
              return const Center(child: Text("Something went wrong"));
          }
        },
      );

  }
}

