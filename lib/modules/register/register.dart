import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/component/component.dart';
import 'package:shopapp/layout/layouts.dart';
import 'package:shopapp/modules/register/cubit/cubit.dart';
import 'package:shopapp/modules/register/cubit/states.dart';
import 'package:shopapp/networks/local/chachehelper.dart';
import 'package:shopapp/shared/style/const.dart';

class Register extends StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterDoneState) {
          if (state.registerFromApi!.status) {
            CacheHelper.setData(
                    key: "token", value: state.registerFromApi!.data.token)!
                .then((value) {
              token = state.registerFromApi!.data.token;
              defaultnavigatorRemove(context, ShopLayout());
            });
          }
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(),
        body: Center(
            child: SingleChildScrollView(
                child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formkey,
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
                  control: email,
                  type: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 15,
                ),
                defaultTextFormField(
                    icon: Icons.password,
                    obscure: RegisterCubit.get(context).change,
                    sicon: RegisterCubit.get(context).eye,
                    suffixpressed: () {
                      RegisterCubit.get(context).changeEye();
                    },
                    type: TextInputType.emailAddress,
                    text: "Password",
                    function: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your Password";
                      }
                      return null;
                    },
                    control: password),
                const SizedBox(
                  height: 15,
                ),
                defaultTextFormField(
                  icon: Icons.phone,
                  text: "phone",
                  function: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your Phone";
                    }
                    return null;
                  },
                  control: phone,
                  type: TextInputType.phone,
                ),
                const SizedBox(
                  height: 15,
                ),
                defaultTextFormField(
                  icon: Icons.person,
                  text: "name",
                  function: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your Name";
                    }
                    return null;
                  },
                  control: name,
                  type: TextInputType.text,
                ),
                const SizedBox(
                  height: 15,
                ),
                ConditionalBuilder(
                  builder: (context) => defaultbutton(
                      function: () {
                        if (formkey.currentState!.validate()) {
                          RegisterCubit.get(context).postRegister(
                              name: name.text,
                              phone: phone.text,
                              email: email.text,
                              password: password.text);
                        }
                      },
                      text: "Register"),
                  condition: state is! RegisterLoadingState,
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
                          defaultnavigator(context, ShopLayout());
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
    );
  }
}
