import 'package:contacts_app/src/controller/contact_cubit/cubit/contact_cubit.dart';
import 'package:contacts_app/src/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../core/common_widget/app_button.dart';
import '../../core/constants/strings.dart';
import '../../core/helpers/validation_helper.dart';

class AddNewContact extends StatefulWidget {
  const AddNewContact({super.key});

  @override
  State<AddNewContact> createState() => _AddNewContactState();
}

final GlobalKey<FormState> _formKey = GlobalKey();

class _AddNewContactState extends State<AddNewContact> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _fnameController = TextEditingController();
  TextEditingController _lnameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => (ContactCubit()),
      child: Scaffold(
        body: SafeArea(
            child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //F-Name
                      TextFormField(
                          keyboardType: TextInputType.name,
                          controller: _fnameController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text(Strings.fname)),
                          validator: ValidationHelpers.validateName),

                          const SizedBox(
                        height: 20,
                      ),

                      //L-Name
                      TextFormField(
                          keyboardType: TextInputType.name,
                          controller: _lnameController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text(Strings.fname)),
                          validator: ValidationHelpers.validateName),

                      const SizedBox(
                        height: 20,
                      ),

                      // address
                      TextFormField(
                          keyboardType: TextInputType.streetAddress,
                          controller: _addressController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text(Strings.address)),),
                          // validator: ValidationHelpers.validateEmail),

                      const SizedBox(
                        height: 20,
                      ),

                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text(Strings.email)),
                          validator: ValidationHelpers.validateEmail),

                      const SizedBox(
                        height: 20,
                      ),

                      //Phone
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: _phoneController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text(Strings.phone),
                            prefix: Text('+91')),
                        validator: ValidationHelpers.validatePhone,
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      //Submit Button
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: BlocConsumer<ContactCubit, ContactState>(
                          listener: (context, state) {
                            // TODO: implement listener
                            if (state is ContactCreateStateSuccess) {
                              // TODO: Navigate to Login Page
                              Fluttertoast.showToast(
                                  msg: Strings.createsuccess,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  fontSize: 16.0);

                              Navigator.pop(context);
                              return;
                            }
                            if (state is ContactCreateStateError) {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: const Text(Strings.createfail),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(Strings.ok))
                                        ],
                                      ));
                            }
                          },
                          builder: (context, state) {
                            if (state is ContactCreateStateLoading) {
                              return const CircularProgressIndicator();
                            }
                            return AppButton(
                              buttonTitle: Strings.save,
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  String fname = _fnameController.text.trim();
                                  String lname = _lnameController.text.trim();
                                  String address =
                                      _addressController.text.trim();
                                  String phone = _phoneController.text.trim();
                                  String email = _emailController.text.trim();
                                  context.read<ContactCubit>().createContact(
                                      ContactModel(
                                          fname: fname,
                                          lname: lname,
                                          address: address,
                                          phone: phone,
                                          email: email));
                                }
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ))),
      ),
    );
  }
}
