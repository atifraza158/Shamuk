import 'package:flutter/material.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/views/auth/professional_register_screen.dart';
import 'package:multivendor/views/auth/property_seller_register_screen.dart';
import 'package:multivendor/views/auth/sign_up_screen.dart';

class RegisterCategoryScreen extends StatefulWidget {
  const RegisterCategoryScreen({super.key});

  @override
  State<RegisterCategoryScreen> createState() => _RegisterCategoryScreenState();
}

class _RegisterCategoryScreenState extends State<RegisterCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeblackcolor,
      body: SafeArea(
        child: Center(
          child: ListView.separated(
            primary: false,
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            itemCount: registerCategoryModel.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (index == 0) {
                    RouteNavigator.route(
                      context,
                      const SignupScreen(),
                    );
                  } else if (index == 1) {
                    RouteNavigator.route(
                      context,
                      const ProfessionalRegisterScreen(),
                    );
                  } else if (index == 2) {
                    RouteNavigator.route(
                      context,
                      const PropertySellerRegisterScreen(),
                    );
                  }
                },
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(registerCategoryModel[index].image),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, separator) {
              return const SizedBox(
                height: 15,
              );
            },
          ),
        ),
      ),
    );
  }
}

class RegisterCategoryModel {
  final String image;
  RegisterCategoryModel({
    required this.image,
  });
}

List<RegisterCategoryModel> registerCategoryModel = [
  RegisterCategoryModel(
    image: 'assets/images/jpg/customer.jpg',
  ),
  RegisterCategoryModel(
    image: 'assets/images/jpg/professional.jpg',
  ),
  RegisterCategoryModel(
    image: 'assets/images/jpg/property.jpg',
  ),
  RegisterCategoryModel(
    image: 'assets/images/jpg/product.jpg',
  ),
];
