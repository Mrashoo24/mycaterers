import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mycaterers/controllers/authcontroller.dart';
import 'package:mycaterers/repositary/authrepo.dart';
import 'package:mycaterers/utils/common/colors.dart';
import 'package:mycaterers/utils/common/responsive.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:provider/provider.dart';

import '../data/model/usermodel.dart';
import '../utils/common/commonfunctions.dart';
import '../utils/common/countrypicker/country_state_city_picker.dart';
import '../utils/common/utils.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  var selectedCountry = '';
  var selectedState = '';
  var selectedCity = '';

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusnode = FocusNode();

  late AuthController authProvider;

  @override
  Widget build(BuildContext context) {
    // authProvider = Provider.of<AuthProvider>(context, listen: false);

    authProvider = Get.put(AuthController());

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: ResponsiveDimensions.getHeigth(context).height,
          width: ResponsiveDimensions.getHeigth(context).width,
          // decoration: BoxDecoration(
          //   image: DecorationImage(image: Svg('assets/background/loginbackground.svg',size: ResponsiveDimensions.getHeigth(context)))
          // ),
          color: Colors.black,
          child: Stack(
            children: [
              Container(
                height: ResponsiveDimensions.getHeigth(context).height,
                width: ResponsiveDimensions.getHeigth(context).width,
                child: SvgPicture.asset(
                  'assets/background/loginbackground.svg',
                  fit: BoxFit.fill,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Text(
                            'Signup',
                            style: TextStyle(
                                color: korangeColor,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: Utils.circularTextField(
                              controller: loginController,
                              focusnode: emailFocusNode,
                              onChange: (value) {},
                              onSubmit: (value) {},
                              hint: 'Enter Email id',
                              label: 'Email id',
                              obsecure: false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Email cannot be blank';
                                }
                                if (!value.contains('@')) {
                                  return 'Input Correct Email id';
                                }
                              }),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 15),
                          child: Utils.circularTextField(
                              controller: passwordController,
                              focusnode: passwordFocusnode,
                              onChange: (value) {},
                              onSubmit: (value) {},
                              hint: 'Enter 6 digit Password',
                              label: 'Password',
                              obsecure: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Password cannot be blank';
                                }
                                if (value.length < 6) {
                                  return 'Password must be atleast 6 characters long';
                                }
                              }),
                        ),

                        Padding(
                          padding:
                              EdgeInsets.only(right: 32, left: 32, bottom: 15),
                          child: Utils.circularTextField(
                              controller: nameController,
                              onChange: (value) {},
                              onSubmit: (value) {},
                              hint: 'Full Name',
                              label: 'Full name',
                              obsecure: false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Name cannot be blank';
                                }
                              }),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 32, right: 32, bottom: 15),
                          child: Utils.circularTextField(
                              keyboard: TextInputType.phone,
                              controller: phoneController,
                              onChange: (value) {},
                              onSubmit: (value) {},
                              hint: 'Phone Number',
                              label: 'Phone Number',
                              obsecure: false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Phone cannot be blank';
                                }
                                if (value.length != 10) {
                                  return 'Phone must be 10 characters';
                                }
                                if (double.parse(value, (e) => 0).isNaN == 0) {
                                  return 'Phone must be number';
                                }
                              }),
                        ),

                        ///Country state

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: SelectState(
                            onCountryChanged: (value) {
                              setState(() {
                                selectedCountry = value;
                              });
                            },
                            onStateChanged: (value) {
                              setState(() {
                                selectedState = value;
                              });
                            },
                            onCityChanged: (value) {
                              setState(() {
                                selectedCity = value;
                              });
                            },
                            dropdownColor: Colors.white,
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          width: ResponsiveDimensions.getHeigth(context).width,
                          child: Utils.circularOrangeButton(
                              onPressed: () async {
                                if (selectedState.isEmpty ||
                                    selectedCity.isEmpty ||
                                    selectedCountry.isEmpty) {
                                  Utils.showErrorToast(
                                      'All fields are required');
                                }

                                if (CommonFunctions.validateForm(formKey)) {
                                  AuthController().userSignup(UserModel(
                                      loginController.text,
                                      passwordController.text,
                                      phoneController.text,
                                      selectedCountry,
                                      selectedState,
                                      selectedState,
                                      '', [],nameController.text));
                                }
                              },
                              label: 'Signup'),
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        RichText(
                          text: TextSpan(
                            text: 'Already have an account? ',
                            style: TextStyle(color: korangeColor),
                            children: const <TextSpan>[
                              TextSpan(
                                  text: ' Login',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
