import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/component/component.dart';
import 'package:shopapp/layout/layouts.dart';
import 'package:shopapp/modules/login/cubit/cubit.dart';
import 'package:shopapp/modules/login/cubit/states.dart';
import 'package:shopapp/modules/register/register.dart';
import 'package:shopapp/networks/local/chachehelper.dart';
import 'package:shopapp/shared/style/const.dart';

class Login extends StatelessWidget {
  TextEditingController controlEmail = TextEditingController();
  TextEditingController controlPass = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Center(
              child: SingleChildScrollView(
                  child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: primary),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  defaultTextFormField(
                      icon: Icons.email,
                      text: "Email",
                      function: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your Email";
                        }
                        return null;
                      },
                      control: controlEmail),
                  const SizedBox(
                    height: 15,
                  ),
                  defaultTextFormField(
                      obscure: AppCubit.get(context).changeEye,
                      icon: Icons.password,
                      sicon: AppCubit.get(context).changeEye
                          ? Icons.visibility
                          : Icons.visibility_off,
                      suffixpressed: () {
                        AppCubit.get(context).toogleEye();
                      },
                      text: "Password",
                      function: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your Password";
                        }
                        return null;
                      },
                      control: controlPass),
                  const SizedBox(
                    height: 15,
                  ),
                  ConditionalBuilder(
                    builder: (context) => defaultbutton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            AppCubit.get(context).login(
                                email: controlEmail.text,
                                pass: controlPass.text);
                          }
                        },
                        text: "Login"),
                    condition: state is! AppStateLoadingLogin,
                    fallback: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Colors.black),
                      ),
                      defaultTextButton(
                          function: () {
                            defaultnavigator(context, Register());
                          },
                          text: "register",
                          context: context)
                    ],
                  )
                ],
              ),
            ),
          ))),
        ),
        listener: (context, state) {
          if (state is AppStateValueLogin) {
            if (state.shopState?.status == true) {
              CacheHelper.setData(
                      key: "token", value: state.shopState!.data.token)!
                  .then((value) {
                token = state.shopState!.data.token;
                defaultnavigatorRemove(context, ShopLayout());
                print(token);
              });
            } else {
              toast(
                  text: state.shopState!.message,
                  changeState: ToastStates.error);
            }
          }
        },
      ),
    );
  }
}
