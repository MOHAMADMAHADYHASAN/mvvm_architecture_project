import 'package:flutter/material.dart';

import 'package:mvvm_app/utils/routes/routes_name.dart';
import 'package:mvvm_app/viewModel/home_View_model.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../data/response/status.dart';
import '../viewModel/user_View_Model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    // সেখানে লেখা homeViewModel.fetchProductListApi() লাইনটি ViewModel-কে হুকুম দেয়:
    // "ভাই, প্রোডাক্টের লিস্টটা নিয়ে এসো তো!"
    // ViewModel কে কল করা হলো (listen: false কারণ এখানে UI আপডেট হচ্ছে না)
    // step1
    super.initState();
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    homeViewModel.fetchProductListApi();
  }

  @override
  Widget build(BuildContext context) {
    final userPreferance = Provider.of<UserViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        automaticallyImplyLeading: false,

        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                userPreferance.remove().then((value) {
                  Navigator.pushNamed(context, Routesname.login);
                });
              },
              icon: const Icon(Icons.logout, color: Colors.red),
            ),
          ),
        ],
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, value, child) {
          switch (value.productList.status) {
            // ================== LOADING STATE (SHIMMER) ==================
            case Status.LOADING:
              return ListView.builder(
                itemCount: 8,
                padding: const EdgeInsets.all(15),
                itemBuilder: (context, index) {
                  // shimmer effect for loading data......
                  return Shimmer.fromColors(
                    // main color
                    baseColor: Colors.grey.shade300,
                    // dhew dewar jonno
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          const SizedBox(width: 15),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 15,
                                  width: double.infinity,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: 10,
                                  width: 100,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: 40,
                                  width: double.infinity,
                                  color: Colors.white,
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
                                      Icons.image_not_supported,color: Colors.red,
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

            case null:
              // TODO: Handle this case.
              throw UnimplementedError();
          }
        },
      ),
    );
  }
}
