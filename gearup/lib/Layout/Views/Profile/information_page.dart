import 'package:e_commers/Layout/themes/colors_gearUp.dart';
import 'package:e_commers/Layout/widgets/shimmer_gearup.dart';
import 'package:e_commers/Layout/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commers/Bloc/user/user_bloc.dart';
import 'package:e_commers/Accessory/helpers.dart';

class InformationPage extends StatefulWidget {
  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  late TextEditingController _firstnameController;
  late TextEditingController _lastnameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _referenceController;
  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _referenceController.dispose();
    super.dispose();
  }

  void initData() {
    final userBloc = BlocProvider.of<UserBloc>(context).state.user!;
    _firstnameController = TextEditingController(text: userBloc.firstName);
    _lastnameController = TextEditingController(text: userBloc.lastName);
    _phoneController = TextEditingController(text: userBloc.phone);
    _addressController = TextEditingController(text: userBloc.address);
    _referenceController = TextEditingController(text: userBloc.reference);
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadingUserState) {
          modalLoading(context, 'Checking...');
        } else if (state is FailureUserState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        } else if (state is SetUserState) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: const TextGearUp(
              text: 'My Profile',
              color: Colors.white,
              fontWeight: FontWeight.w500),
          centerTitle: true,
          leading: IconButton(
            splashRadius: 20,
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  userBloc.add(OnUpdateInformationUserEvent(
                      _firstnameController.text.trim(),
                      _lastnameController.text.trim(),
                      _phoneController.text.trim(),
                      _addressController.text.trim(),
                      _referenceController.text.trim()));
                },
                child: const TextGearUp(
                  text: 'Save',
                  color: ColorsGearUp.greenColor,
                  fontSize: 18,
                ))
          ],
        ),
        body: Form(
          key: _keyForm,
          child: ListView(
            physics: BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            children: [
              const TextGearUp(
                text: 'Account data',
                fontSize: 18,
                color: Colors.white,
              ),
              const SizedBox(height: 10.0),
              BlocBuilder<UserBloc, UserState>(
                  buildWhen: (previous, current) => previous != current,
                  builder: (context, state) => state.user != null
                      ? Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          height: 80,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Color(0xff2b2c2c),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const TextGearUp(
                                      text: 'User',
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                  TextGearUp(
                                      text: state.user!.users,
                                      fontSize: 18,
                                      color: Colors.white),
                                ],
                              ),
                              SizedBox(height: 15.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const TextGearUp(
                                      text: 'Email',
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                  TextGearUp(
                                    text: state.user!.email,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : const ShimmerGearUp()),
              const SizedBox(height: 30.0),
              const TextGearUp(
                text: 'Personal Information',
                fontSize: 18,
                color: Colors.white,
              ),
              const SizedBox(height: 10.0),
              TextFormGearUp(
                controller: _firstnameController,
                hintText: 'Enter your First Name',
                prefixIcon: const Icon(Icons.person_outline_rounded,
                    color: Colors.black),
              ),
              const SizedBox(height: 20.0),
              TextFormGearUp(
                controller: _lastnameController,
                hintText: 'Enter Last Name',
                prefixIcon: const Icon(Icons.person_outline_rounded,
                    color: Colors.black),
              ),
              const SizedBox(height: 20.0),
              TextFormGearUp(
                controller: _phoneController,
                hintText: 'Enter your Phone Number',
                prefixIcon: const Icon(Icons.phone_android_rounded,
                    color: Colors.black),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20.0),
              TextFormGearUp(
                controller: _addressController,
                hintText: 'Street Address',
                prefixIcon:
                    const Icon(Icons.home_outlined, color: Colors.black),
                keyboardType: TextInputType.streetAddress,
              ),
              const SizedBox(height: 20.0),
              TextFormGearUp(
                controller: _referenceController,
                hintText: 'Reference',
                prefixIcon:
                    const Icon(Icons.home_outlined, color: Colors.black),
                keyboardType: TextInputType.streetAddress,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
