import 'package:flutter/material.dart';
import 'package:multivendor/provider/auth_pro.dart';
import 'package:multivendor/provider/cart_pro.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/widgets/custom_rounded_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewCheckoutScreen extends StatefulWidget {
  int total;
  int discount;
  double save;
  int shipment;
  double subTotal;

  NewCheckoutScreen(
      {Key? key,
      required this.total,
      required this.discount,
      required this.save,
      required this.shipment,
      required this.subTotal})
      : super(key: key);

  @override
  State<NewCheckoutScreen> createState() => _NewCheckoutScreenState();
}

class _NewCheckoutScreenState extends State<NewCheckoutScreen> {
  @override
  void initState() {
    
    setValuesInLocalVariableFunc();
  
    super.initState();
  }

  final formkey = GlobalKey<FormState>();
  final TextEditingController fullnameC = TextEditingController();
  final TextEditingController emailAddresC = TextEditingController();
  final TextEditingController phoneNumberC = TextEditingController();
  final TextEditingController orderNoteC = TextEditingController();
  //address, city, state, county
  setValuesInLocalVariableFunc() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? fullname = prefs.getString('full_name');
    final String? email = prefs.getString('email');
    final String? phone = prefs.getString('phone');

    fullnameC.text = fullname.toString();
    emailAddresC.text = email.toString();
    phoneNumberC.text = phone.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themewhitecolor,
      appBar: AppBar(
        backgroundColor: Palette.themecolor,
        elevation: 0,
        title: const Text(
          "Checkout",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 75,
        decoration: const BoxDecoration(
          color: themewhitecolor,
          border: Border(
            top: BorderSide(
              color: themegreycolor,
            ),
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomRoundedButton(
              buttonText: "Placed Order",
              onTap: () {
                if (formkey.currentState!.validate()) {

                  final checkoutProvider= Provider.of<cart_pro>(context,listen: false);
                checkoutProvider.checkoutfunc( fullnameC.text, emailAddresC.text, phoneNumberC.text, orderNoteC.text, context);
                
                }
              },
              buttoncolor: Palette.themecolor,
              buttontextcolor: themewhitecolor,
              height: kMinInteractiveDimension,
              width: MediaQuery.of(context).size.width * 0.85,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: themewhitecolor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: themegreycolor,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Guest Checkout",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          controller: fullnameC,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: themegreytextcolor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: themeredcolor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: themeredcolor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Palette.themecolor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            hintText: "Write your full name",
                            contentPadding: const EdgeInsets.all(12),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Full name is empty";
                            } else {
                              return null;
                            }
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          controller: emailAddresC,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: themegreytextcolor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: themeredcolor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: themeredcolor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Palette.themecolor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            hintText: "Enter your email address",
                            contentPadding: const EdgeInsets.all(12),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "email is empty";
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("email format is not correct.");
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          controller: phoneNumberC,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: themegreytextcolor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: themeredcolor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: themeredcolor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedBorder: OutlineInputBorder(
                               borderSide:
                                  const BorderSide(color: Palette.themecolor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            hintText: "Enter your phone number",
                            contentPadding: const EdgeInsets.all(12),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Phone Number is empty";
                            } else {
                              return null;
                            }
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: orderNoteC,
                        maxLines: 5,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: themegreytextcolor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Palette.themecolor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: "Order note",
                          contentPadding: const EdgeInsets.all(12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: themewhitecolor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: themegreycolor,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Shipment",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer<cart_pro>(
                        builder: ((context, shipmentValue, child) {
                      return shipmentValue.shipmentDetailsIsLoading
                          ? const CircularProgressIndicator()
                          : Text(
                              "${shipmentValue.shipmentAddress}, ${shipmentValue.shipmentCity}, ${shipmentValue.shipmentState}, ${shipmentValue.shipmentCountry}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                    })),
                    const Divider(
                      height: 50,
                    ),
                    const Text(
                      "Payments Details",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Rs.${widget.total}/-",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Discount",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "${widget.discount}%",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Save",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Rs.${widget.save}/-",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Shipment Charges",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Rs.${widget.shipment}/-",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Sub Total",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Rs.${widget.subTotal}/-",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
