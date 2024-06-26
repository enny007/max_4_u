import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/enums/network_dropdown.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/provider/buy_airtime_provider.dart';
import 'package:max_4_u/app/screens/beneficiary/beneficiary_screen.dart';
import 'package:max_4_u/app/screens/buy_airtime/airtime_verification_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:max_4_u/app/widgets/text_input_field.dart';
import 'package:provider/provider.dart';

class BuyAirtimeScreen extends StatefulWidget {
  const BuyAirtimeScreen({super.key});

  @override
  State<BuyAirtimeScreen> createState() => _BuyAirtimeScreenState();
}

class _BuyAirtimeScreenState extends State<BuyAirtimeScreen> {
  String? _selectedNetwork = networkProvider[0];

  final _amountController = TextEditingController();

  final amount = [
    '100',
    '200',
    '500',
    '1000',
    '2000',
    '5000',
  ];
  String network = '';

  int? selectedIndex;

  String airtimeAmount = '';
  @override
  void dispose() {
    super.dispose();
  }

  var codeValues = [];
  var networks = [];
  getProductCodeValues() async {
    final code = await SecureStorage().getUserProducts();
    final network = code
        .where((code) => code['name'] == 'mtn')
        .map((code) => code['code'])
        .toList();

    final productCodes = code
        .where((code) => code['category'] == 'airtime')
        .map((code) => code['code'])
        .toList();

    setState(() {
      networks = network;
      codeValues = productCodes;
    });
  }

//   getNetworkList() {
//     for (String net in networks) {

//       networkProvider myNetwork = stringToNetwork(net);
//       log('$myNetwork');
//       log('$networks');
//       log('$codeValues');
//     }
//   }

//   String networkToString(networkProvider network) {
//   return network.toString().split('.').last;
// }

// networkProvider stringToNetwork(String String) {
//   return networkProvider.values.firstWhere((e) => e.toString().split('.').last == networkToString);
// }

  @override
  Widget build(BuildContext context) {
    return Consumer<BuyAirtimeProvider>(
      builder: (context, buyAirtime, _) {
        return BusyOverlay(
          show: buyAirtime.state == ViewState.Busy,
          title: buyAirtime.message,
          child: Scaffold(
            body: SafeArea(
                child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 41),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.arrow_back,
                          ),
                        ),
                        horizontalSpace(104),
                        const Text(
                          'Buy Airtime',
                          style: AppTextStyles.font18,
                        )
                      ],
                    ),
                    verticalSpace(64),
                    Text(
                      'Select Network',
                      style: AppTextStyles.font14.copyWith(
                        color: const Color(0xff475569),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    verticalSpace(8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: 52.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.whiteColor,
                        border: Border.all(
                          color: const Color(0xffCBD5E1),
                        ),
                      ),
                      child: DropdownButton<String>(
                        // hint: Text('MTN'),
                        elevation: 0,
                        borderRadius: BorderRadius.circular(12),
                        underline: const SizedBox(),
                        value: _selectedNetwork,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedNetwork = newValue!;
                          });
                        },
                        items: networkProvider.map((String networkProviders) {
                          return DropdownMenuItem(
                            value: networkProviders,
                            onTap: () {
                              // setState(() {
                              //   network =
                              //       _networkToString(network) as NetworkProvider;
                              // });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 255),
                              child: Container(
                                margin: const EdgeInsets.only(top: 8),
                                child: Text(
                                  networkProviders.toUpperCase(),
                                  style: AppTextStyles.font14.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    verticalSpace(30),
                    Stack(
                      children: [
                        TextInputField(
                          controller: buyAirtime.phoneNumber,
                          labelText: 'Phone Number',
                          hintText: 'receiver\'s number',
                          textInputType: TextInputType.number,
                        ),
                        Positioned(
                          right: 0,
                          child: GestureDetector(
                            onTap: () =>
                                nextScreen(context, const BeneficiaryScreen()),
                            child: Text(
                              'select from beneficiary',
                              style: AppTextStyles.font12.copyWith(
                                color: AppColors.secondaryColor,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    // ElevatedButton(onPressed: (){

                    //   getNetworkList();
                    // }, child: Text('')),
                    verticalSpace(30),
                    Text(
                      'Amount',
                      style: AppTextStyles.font14.copyWith(
                        color: const Color(0xff475569),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    verticalSpace(10),
                    SizedBox(
                      height: 100.h,
                      child: GridView.builder(
                          itemCount: amount.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 14,
                            crossAxisSpacing: 35,
                            childAspectRatio: 2.3,
                          ),
                          itemBuilder: (_, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;

                                  airtimeAmount =
                                      amount[selectedIndex!.toInt()];
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 42.h,
                                width: 96.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.whiteColor,
                                  border: Border.all(
                                    color: selectedIndex == index
                                        ? AppColors.primaryColor
                                        : const Color(0xffCBD5E1),
                                  ),
                                ),
                                child: Text(
                                  'N${amount[index]}',
                                  style: AppTextStyles.font14.copyWith(
                                    color: const Color(0xff333333),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    verticalSpace(14),
                    TextInputField(
                      controller: _amountController,
                      hintText: '50-350,000',
                      textInputType: TextInputType.number,
                      onChanged: (p0) {
                        airtimeAmount = _amountController.text;
                      },
                    ),
                    verticalSpace(68),
                    ButtonWidget(
                      text: 'Continue',
                      onTap: () async {
                        if (buyAirtime.phoneNumber.text.isEmpty) {
                          showMessage(context, 'Phone number is required',
                              isError: true);
                          return;
                        }

                        if (airtimeAmount.isEmpty) {
                          showMessage(context, 'Amount is required',
                              isError: true);
                          return;
                        }

                        nextScreen(
                            context,
                            AirtimeVerificationScreen(
                              network: '${_selectedNetwork}',
                              phoneNumber: buyAirtime.phoneNumber.text,
                              amount: airtimeAmount,
                            ));
                      },
                    )
                  ],
                ),
              ),
            )),
          ),
        );
      },
    );
  }
}

// String _networkToString(networkProvider network) {
//   switch (network) {
//     case networkProvider.MTN:
//       return 'MTN';
//     case networkProvider.GLO:
//       return 'GLO';
//     case networkProvider.Airtel:
//       return 'Airtel';
//     case networkProvider.Etisalat:
//       return 'Etisalat';

//     default:
//       return '';
//   }
// }
