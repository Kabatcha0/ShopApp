import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/component/component.dart';
import 'package:shopapp/layout/cubit/cubit..dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/modules/login/login.dart';
import 'package:shopapp/networks/local/chachehelper.dart';
import 'package:shopapp/shared/style/const.dart';

class Settings extends StatelessWidget {
  Settings({super.key});
  TextEditingController? name = TextEditingController();
  TextEditingController? email = TextEditingController();
  TextEditingController? phone = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {
        name?.text = ShopCubit.get(context).getSettings?.data.name ?? "";
        email?.text = ShopCubit.get(context).getSettings?.data.email ?? "";
        phone?.text = ShopCubit.get(context).getSettings?.data.phone ?? "";
        return ConditionalBuilder(
            condition: ShopCubit.get(context).getSettings != null,
            builder: (context) => Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Form(
                        key: formkey,
                        child: Column(
                          children: [
                            if (state is UpdateLoading)
                              const LinearProgressIndicator(),
                            const SizedBox(
                              height: 15,
                            ),
                            CircleAvatar(
                              child: Image(
                                  key: UniqueKey(),
                                  image: NetworkImage(ShopCubit.get(context)
                                      .getSettings!
                                      .data
                                      .image)),
                              radius: 40,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            defaultTextFormField(
                              icon: Icons.person,
                              text: "name",
                              isSuffix: false,
                              control: name!,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            defaultTextFormField(
                              icon: Icons.person,
                              isSuffix: false,
                              text: "phone",
                              control: phone!,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            defaultTextFormField(
                              icon: Icons.person,
                              text: "email",
                              isSuffix: false,
                              control: email!,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            defaultbutton(
                                function: () {
                                  if (formkey.currentState!.validate()) {
                                    ShopCubit.get(context).updataData(
                                      name: name!.text,
                                      phone: phone!.text,
                                      email: email!.text,
                                    );
                                  }
                                },
                                text: "Update"),
                            const SizedBox(
                              height: 20,
                            ),
                            defaultbutton(
                                function: () {
                                  CacheHelper.removeData(key: "token")
                                      .then((value) {
                                    defaultnavigatorRemove(context, Login());
                                  });
                                },
                                text: "Sign out")
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ));
      },
      listener: (context, state) {},
    );
  }
}
