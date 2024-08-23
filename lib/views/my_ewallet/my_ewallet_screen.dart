import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:multivendor/navigator.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:multivendor/views/my_ewallet/ereceipt_screen.dart';
import 'package:multivendor/views/my_ewallet/top_up_ewallet_screen.dart';
import 'package:multivendor/widgets/custom_rounded_button.dart';
import 'package:multivendor/widgets/custom_text_button.dart';

class MyEwalletScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyEwalletScreenState();
  }
}

class MyEwalletScreenState extends State<MyEwalletScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Palette.themecolor,
        elevation: 0,
        title: const Text(
          "My E-Wallet",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: Container(
        height: 75,
        decoration: const BoxDecoration(),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomRoundedButton(
              buttonText: "Top Up",
              onTap: () {
                RouteNavigator.route(context, const TopUpEwalletScreen());
              },
              buttoncolor: Palette.themecolor,
              buttontextcolor: themewhitecolor,
              height: kMinInteractiveDimension,
              width: MediaQuery.of(context).size.width * 0.85,
            )),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: !useBackgroundImage
              ? const DecorationImage(
                  image: ExactAssetImage('assets/bg.png'),
                  fit: BoxFit.fill,
                )
              : null,
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              CreditCardWidget(
                // glassmorphismConfig:
                //     useGlassMorphism ? Glassmorphism.defaultConfig() : null,
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                bankName: 'Any Bank',
                showBackView: isCvvFocused,
                obscureCardNumber: true,
                obscureCardCvv: true,
                isHolderNameVisible: true,
                cardBgColor: Palette.themecolor,
                backgroundImage: useBackgroundImage
                    ? "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Mastercard_2019_logo.svg/1200px-Mastercard_2019_logo.svg.png"
                    : null,
                isSwipeGestureEnabled: true,
                onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
                customCardTypeIcons: <CustomCardTypeIcon>[
                  CustomCardTypeIcon(
                      cardType: CardType.mastercard,
                      cardImage: Image.network(
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Mastercard_2019_logo.svg/1200px-Mastercard_2019_logo.svg.png")),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Transaction History",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    CustomTextButton(
                      buttonText: "See All",
                      onTap: () {
                        // RouteNavigator.route(
                        //     context, TransactioHistoryScreen());
                      },
                      textstyle: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                  padding: const EdgeInsets.all(15),
                  primary: false,
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        RouteNavigator.route(context, const EreceiptScreen());
                      },
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                              "https://static-01.daraz.pk/p/21aa749ce98fecc4f5d6c14bbdf80e7d.jpg",
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Transaction History",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Dec 15, 2022 | 10:00 Am",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Rs.9999/-",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Orders",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
