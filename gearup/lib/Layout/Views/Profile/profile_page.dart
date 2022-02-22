// import 'dart:io';
import 'package:e_commers/Bloc/Auth/auth_bloc.dart';
import 'package:e_commers/Bloc/General/general_bloc.dart';
import 'package:e_commers/Layout/Views/Login/login_page.dart';
import 'package:e_commers/Layout/Views/Profile/add_product/add_product_page.dart';
import 'package:e_commers/Layout/Views/Profile/card/credit_card_page.dart';
import 'package:e_commers/Layout/Views/Profile/information_page.dart';
import 'package:e_commers/Layout/Views/Profile/shopping/shopping_page.dart';
import 'package:e_commers/Layout/Views/favorite/favorite_page.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:e_commers/Bloc/user/user_bloc.dart';
import 'package:e_commers/Accessory/helpers.dart';
import 'package:e_commers/Service/urls.dart';
import 'package:e_commers/Layout/Views/Profile/widgets/card_item_profile.dart';
import 'package:e_commers/Layout/Views/Profile/widgets/divider_line.dart';
import 'package:e_commers/Layout/themes/colors_gearUp.dart';
import 'package:e_commers/Layout/widgets/shimmer_gearup.dart';
import 'package:e_commers/Layout/widgets/widgets.dart';
import 'package:shake/shake.dart';

import 'sensor/compass.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadingUserState) {
          modalLoading(context, 'Loading...');
        } else if (state is FailureUserState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        } else if (state is SetUserState) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            ListProfile(),
            Positioned(
              bottom: 20,
              child: Container(
                  width: size.width,
                  child: Align(child: BottomNavigationGearUp(index: 5))),
            ),
          ],
        ),
      ),
    );
  }
}

class ListProfile extends StatefulWidget {
  @override
  _ListProfileState createState() => _ListProfileState();
}

class _ListProfileState extends State<ListProfile> {
  late ScrollController _scrollController;
  double scrollPrevious = 0;

  late ShakeDetector detector;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(addListenerScroll);

    super.initState();
  }

  void addListenerScroll() {
    if (_scrollController.offset > scrollPrevious) {
      BlocProvider.of<GeneralBloc>(context)
          .add(OnShowOrHideMenuEvent(showMenu: false));
    } else {
      BlocProvider.of<GeneralBloc>(context)
          .add(OnShowOrHideMenuEvent(showMenu: true));
    }
    scrollPrevious = _scrollController.offset;
  }

  @override
  void dispose() {
    _scrollController.removeListener(addListenerScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authBloc = BlocProvider.of<AuthBloc>(context);

    detector = ShakeDetector.autoStart(onPhoneShake: () {
      authBloc.add(LogOutEvent());
    });
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LogOutState) {
          Navigator.pushReplacement(context,
              routeSlide(page: SignInPage(), curved: Curves.easeInOut));
        }
      },
      child: ListView(
        controller: _scrollController,
        padding: EdgeInsets.only(top: 35.0, bottom: 20.0),
        children: [
          BlocBuilder<UserBloc, UserState>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) => state.user != null
                  ? Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: state.user != null && state.user?.image == ''
                                ? GestureDetector(
                                    onTap: () => modalSelectPicture(
                                          context: context,
                                          onPressedImage: () async {
                                            Navigator.pop(context);
                                            AccessPermission()
                                                .permissionAccessGalleryOrCameraForProfile(
                                                    await Permission.storage
                                                        .request(),
                                                    context,
                                                    ImageSource.gallery);
                                          },
                                          onPressedPhoto: () async {
                                            Navigator.pop(context);
                                            AccessPermission()
                                                .permissionAccessGalleryOrCameraForProfile(
                                                    await Permission.camera
                                                        .request(),
                                                    context,
                                                    ImageSource.camera);
                                          },
                                        ),
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundColor: ColorsGearUp.greenColor,
                                      child: TextGearUp(
                                          text: state.user!.users
                                              .substring(0, 2)
                                              .toUpperCase(),
                                          fontSize: 40,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ))
                                : GestureDetector(
                                    onTap: () => modalSelectPicture(
                                      context: context,
                                      onPressedImage: () async {
                                        Navigator.pop(context);
                                        AccessPermission()
                                            .permissionAccessGalleryOrCameraForProfile(
                                                await Permission.storage
                                                    .request(),
                                                context,
                                                ImageSource.gallery);
                                      },
                                      onPressedPhoto: () async {
                                        Navigator.pop(context);
                                        AccessPermission()
                                            .permissionAccessGalleryOrCameraForProfile(
                                                await Permission.camera
                                                    .request(),
                                                context,
                                                ImageSource.camera);
                                      },
                                    ),
                                    child: Container(
                                      height: 90,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(URLS.baseUrl +
                                                  state.user!.image))),
                                    ),
                                  )),
                        const SizedBox(width: 15.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BounceInRight(
                              child: Align(
                                  alignment: Alignment.center,
                                  child: TextGearUp(
                                      text: state.user!.users,
                                      fontSize: 21,
                                      fontWeight: FontWeight.w500)),
                            ),
                            FadeInRight(
                              child: Align(
                                  alignment: Alignment.center,
                                  child: TextGearUp(
                                      text: state.user!.email,
                                      fontSize: 18,
                                      color: Colors.grey)),
                            ),
                          ],
                        ),
                      ],
                    )
                  : const ShimmerGearUp()),
          const SizedBox(height: 25.0),
          Container(
            height: 182,
            width: size.width,
            color: Colors.black,
            child: Column(
              children: [
                CardItemProfile(
                  text: 'Personal Information',
                  borderRadius: BorderRadius.circular(50.0),
                  icon: Icons.person_outline_rounded,
                  backgroundColor: Colors.black,
                  onPressed: () => Navigator.push(
                      context, routeSlide(page: InformationPage())),
                ),
                DividerLine(size: size),
                CardItemProfile(
                  text: 'Credit Card',
                  borderRadius: BorderRadius.circular(50.0),
                  icon: Icons.credit_card_rounded,
                  backgroundColor: Color(0xff2b2c2c),
                  onPressed: () => Navigator.push(
                      context, routeSlide(page: CreditCardPage())),
                ),
                DividerLine(size: size),
                CardItemProfile(
                  text: 'Add Product',
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30.0)),
                  icon: Icons.add,
                  backgroundColor: Color(0xff2b2c2c),
                  onPressed: () => Navigator.push(
                      context, routeSlide(page: AddProductPage())),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15.0),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: const TextGearUp(
              text: 'General',
              fontSize: 17,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            height: 182,
            width: size.width,
            child: Column(
              children: [
                CardItemProfile(
                  text: 'Find Direction',
                  borderRadius: BorderRadius.zero,
                  backgroundColor: Color(0xff2b2c2c),
                  icon: Icons.compare_arrows_sharp,
                  onPressed: () =>
                      Navigator.push(context, routeSlide(page: HomePage())),
                ),
                DividerLine(size: size),
                CardItemProfile(
                  text: 'Favorites',
                  backgroundColor: Color(0xff2b2c2c),
                  icon: Icons.favorite_border_rounded,
                  borderRadius: BorderRadius.zero,
                  onPressed: () => Navigator.pushAndRemoveUntil(
                      context, routeSlide(page: FavoritePage()), (_) => false),
                ),
                DividerLine(size: size),
                CardItemProfile(
                  text: 'My Shopping',
                  backgroundColor: Color(0xff2b2c2c),
                  icon: Icons.shopping_bag_outlined,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30.0)),
                  onPressed: () =>
                      Navigator.push(context, routeSlide(page: ShoppingPage())),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15.0),
          Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: const TextGearUp(
              text: 'Personal',
              fontSize: 17,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            height: 243,
            width: size.width,
            child: Column(
              children: [
                CardItemProfile(
                  text: 'App Info',
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30.0)),
                  backgroundColor: Color(0xff2b2c2c),
                  icon: Icons.policy_rounded,
                  onPressed: () {
                    openAppSettings().then((opened) {});
                  },
                ),
                DividerLine(size: size),
                CardItemProfile(
                  text: 'Security',
                  borderRadius: BorderRadius.zero,
                  backgroundColor: Color(0xff2b2c2c),
                  icon: Icons.lock_outline_rounded,
                  onPressed: () {},
                ),
                DividerLine(size: size),
                CardItemProfile(
                  text: 'Term & Conditions',
                  borderRadius: BorderRadius.zero,
                  backgroundColor: Color(0xff2b2c2c),
                  icon: Icons.description_outlined,
                  onPressed: () {},
                ),
                DividerLine(size: size),
                CardItemProfile(
                  text: 'Log Out',
                  backgroundColor: Color(0xff2b2c2c),
                  icon: Icons.power_settings_new_sharp,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30.0)),
                  onPressed: () {
                    authBloc.add(LogOutEvent());
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 25.0),
          CardItemProfile(
            text: 'Develop By: Shankar Tamang',
            borderRadius: BorderRadius.circular(50.0),
            icon: Icons.person,
            backgroundColor: Color(0xff2b2c2c),
            onPressed: () {
              authBloc.add(LogOutEvent());
            },
          ),
        ],
      ),
    );
  }
}
