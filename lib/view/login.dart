import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycaterers/utils/common/colors.dart';
import 'package:mycaterers/utils/common/commonfunctions.dart';
import 'package:mycaterers/utils/common/responsive.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:mycaterers/utils/routes/routenames.dart';

import '../controllers/authcontroller.dart';
import '../data/model/usermodel.dart';
import '../utils/common/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusnode = FocusNode();
  var formKey = GlobalKey<FormState>();

  bool obsecure = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topCenter,
                            child: SvgPicture.asset('assets/icons/logo.svg')),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 60),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                              child: ClipRRect(
                                  child: Image.asset(
                                      'assets/icons/googlesiging.png'))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('OR'),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: Utils.circularTextField(
                            controller: loginController,
                            focusnode: emailFocusNode,
                            onChange: (value) {},
                            onSubmit: (value) {
                              FocusScope.of(context).nextFocus();
                            },
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
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 15),
                          child: Utils.circularTextField(
                              controller: passwordController,
                              focusnode: passwordFocusnode,
                              onChange: (value) {

                              },
                              onSubmit: (value) {},
                              hint: 'Enter 6 digit Password',
                              label: 'Password',
                              obsecure: obsecure,
                              suffix: obsecure ? InkWell(
                                  onTap: (){
                                    setState(() {
                                      obsecure = false;
                                    });
                                  },
                                  child: Icon(Icons.remove_red_eye)) : InkWell(
                                  onTap: (){
                                    setState(() {
                                      obsecure = true;
                                    });
                                  },
                                  child: Icon(Icons.remove_red_eye_outlined)),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Password cannot be blank';
                                }
                                if (value.length < 6) {
                                  return 'Password must be atleast 6 characters long';
                                }
                              }),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 20.0, right: 40),
                              child: Text(
                                'Forgot Password ?',
                                style: TextStyle(color: korangeColor),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          width: ResponsiveDimensions.getHeigth(context).width,
                          child: Utils.circularOrangeButton(
                              onPressed: () {
                                if (CommonFunctions.validateForm(formKey)) {
                                  AuthProvider().userLogin(loginController.text,
                                      passwordController.text);
                                } else {
                                  Utils.showErrorToast(
                                      'All fields are required');
                                }
                              },
                              label: 'Login'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            Utils.navigate(RouteNames.signup, context);
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'Don\'t have an account? ',
                              style: TextStyle(color: korangeColor),
                              children: const <TextSpan>[
                                TextSpan(
                                    text: ' Signup',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                              ],
                            ),
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
