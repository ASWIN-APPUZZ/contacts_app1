import 'package:contacts_app/src/controller/contact_cubit/cubit/contact_cubit.dart';
import 'package:contacts_app/src/core/common_widget/app_button.dart';
import 'package:contacts_app/src/core/constants/strings.dart';
import 'package:contacts_app/src/core/storage/theme/app_text_theme.dart';
import 'package:contacts_app/src/models/contact_model.dart';
import 'package:contacts_app/src/views/pages/add_new_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NewContactsPage extends StatefulWidget {
  const NewContactsPage({super.key});

  @override
  State<NewContactsPage> createState() => _NewContactsPageState();
}

class _NewContactsPageState extends State<NewContactsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactCubit()..readContact(),
      child: Scaffold(
        body: Center(
          child: SafeArea(
              child: BlocConsumer<ContactCubit, ContactState>(
            listener: (context, state) {
              // TODO: implement listener
        
              if (state is ContactDeleteStateSuccess) {
                Fluttertoast.showToast(
                    msg: Strings.toastdeletesuccess,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    fontSize: 16.0);
                context.read<ContactCubit>().readContact();
              } else if (state is ContactDeleteStateError) {
                Fluttertoast.showToast(
                    msg: Strings.toastdeletefail,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    fontSize: 16.0);
              }
            },
            builder: (context, state) {
              if (state is ContactReadStateLoading) {
                return CircularProgressIndicator();
              }
        
              if (state is ContactReadStateError) {
                return Column(
                  children: [
                    Text(
                      Strings.contactError,
                      style: AppTextTheme.h1TextStyle,
                    ),
                    Text(state.error),
                    AppButton(
                        buttonTitle: Strings.retry,
                        onPressed: () {
                          context.read<ContactCubit>().readContact();
                        })
                  ],
                );
              }
        
              if (state is ContactReadStateSuccess) {
                List<ContactModel> contacts = state.data;
                return ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(contacts[index].fname),
                      subtitle: Text(contacts[index].email),
                      trailing: IconButton(
                          onPressed: () {
                            context
                                .read<ContactCubit>()
                                .deleteContact(contacts[index]);
                          },
                          icon: Icon(Icons.delete)),
                    );
                  },
                );
              }
        
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {},
              );
            },
          )),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddNewContact()));
        },child: Icon(Icons.person_add_sharp),),
      ),
    );
  }
}
