import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gehnamall/common/custom_button.dart';
import 'package:gehnamall/constants/constants.dart';
import 'package:gehnamall/controllers/cart_controller.dart';
import 'package:gehnamall/controllers/product_details_controller.dart';
import 'package:gehnamall/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/lightcategorycardModels.dart';

class LightDetailScreen extends StatelessWidget {
  final Product product;
  final cartController = Get.put(CartController());
  final ProductDetailsController controller =
      Get.put(ProductDetailsController());

  LightDetailScreen({Key? key, required this.product}) : super(key: key);

  Future<String> getUserId() async {
    return await AuthService.getUserId() ?? 'Unknown';
  }

  Future<void> _launchUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, __) => FutureBuilder<String>(
        future: getUserId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error retrieving user ID: ${snapshot.error}'),
            );
          }

          final userId = snapshot.data ?? 'Unknown';

          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(3.r),
                          child: SizedBox(
                            height: 240.h,
                            child: PageView.builder(
                              controller: controller.pageController,
                              onPageChanged: (index) =>
                                  controller.currentImageIndex.value = index,
                              itemCount: product.imageUrls.length,
                              itemBuilder: (context, index) {
                                return CachedNetworkImage(
                                  imageUrl: product.imageUrls[index],
                                  height: 220.h,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, error, url) =>
                                      const Icon(Icons.broken_image),
                                );
                              },
                            ),
                          ),
                        ),
                        Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(product.imageUrls.length,
                                (index) {
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 4.w, vertical: 8.h),
                                width:
                                    controller.currentImageIndex.value == index
                                        ? 12.w
                                        : 8.w,
                                height:
                                    controller.currentImageIndex.value == index
                                        ? 12.h
                                        : 8.h,
                                decoration: BoxDecoration(
                                  color: controller.currentImageIndex.value ==
                                          index
                                      ? Colors.white
                                      : Colors.grey[300],
                                  shape: BoxShape.circle,
                                ),
                              );
                            }))),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Product Name
                    Center(
                      child: Text(
                        product.productName,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Product Details
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Karat: ${product.karat}',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500)),
                          SizedBox(height: 8.h),
                          Text('Weight: ${product.weight}gm',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500)),
                          SizedBox(height: 8.h),
                          Text('Making Charge: ${product.wastage}%',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500)),
                          SizedBox(height: 8.h),
                          Text('Description: ${product.description}',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500)),
                          SizedBox(height: 14.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () =>
                                    _launchUrl('https://wa.me/+917982031621'),
                                icon: Image.asset(
                                  'assets/icons/whatsapp.png',
                                  height: 14.h,
                                ),
                                label: Text(
                                  'Ask on WhatsApp!',
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 12.sp),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.green, width: 2.w),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              ElevatedButton.icon(
                                onPressed: () =>
                                    _launchUrl('tel:+917982031621'),
                                icon: Icon(Icons.phone,
                                    color: Colors.green, size: 14.h),
                                label: Text(
                                  'Call Us!',
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 12.sp),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  side: BorderSide(
                                      color: Colors.green, width: 2.w),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.verified, color: kPrimary),
                              SizedBox(width: 8.w),
                              Text(
                                'Bansal & Sons Jewellers Pvt Ltd',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h),

                    CustomButton(
                      label: 'Add to Wishlist',
                      onPressed: () async {
                        await cartController.addToCart(
                            userId, product.productId.toString());
                      },
                      width: 1.sw,
                      height: 50.h,
                      color: kDark,
                      fontSize: 18.sp,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
