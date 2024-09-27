import 'package:doctor_ack/core/utils/constants_manager.dart';
import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/widgets/component.dart';
import '../../../../core/widgets/cached_image/cached_network_image.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:doctor_ack/vendor_modules/users_management/presentation/controller/user_management_cubit.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/select_widget_custom/select_widget_custom.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../controller/change_user_role_cubit/change_user_role_cubit.dart';

class UsersScreen extends StatelessWidget {
  final int index;

  final int id;
  final String name;
  final String mobilePhone;
  final String email;
  final String imageUrl;
  final String role;

  const UsersScreen(
      {required this.index,
      required this.id,
      required this.name,
      required this.mobilePhone,
      required this.email,
      required this.imageUrl,
      required this.role,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SlideInLeft(
      delay: const Duration(milliseconds: 200),
      from: AppConstants.language ? -350 : 350,
      child: Container(
        // height: AppSize.s100,
        padding: EdgeInsets.only(
            top: AppPadding.p14,
            bottom: AppPadding.p10,
            left: AppPadding.p12,
            right: AppPadding.p10),
        margin: EdgeInsets.all(AppPadding.p8),
        width: 343,
        // height: 125,
        decoration: ShapeDecoration(
          color: index % 2 == 0 ? ColorManager.secondary : ColorManager.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s10),
          ),
        ),
        child: InkWell(
          onTap: () {
            // navigator(context, Routes.clinicRoute);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedNetworkImageCustom(
                    url: imageUrl,
                    width: AppSize.s70,
                    height: AppSize.s70,
                    boarder: AppSize.s40.r,
                    // boxFit: BoxFit.contain,
                  ),
                  SizedBox(
                    height: AppSize.s70,
                    width: AppSize.s100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: AppSize.s60,
                          height: AppSize.s14,
                          alignment: Alignment.center,
                          decoration: ShapeDecoration(
                            color: ColorManager.rose,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppSize.s20),
                            ),
                          ),
                          child: TextCustom(
                            text: toBeginningOfSentenceCase(role, 'en')!,
                            textStyle: getRegularGilroyStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s10,
                            ),
                          ),
                        ),
                        TextCustom(
                          text: name,
                          fontSize: FontSize.s16,
                          color: ColorManager.white,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          fontWeight: FontWeightManager.bold,
                        ),
                        TextCustom(
                          text: '',
                          textStyle: getRegularGilroyStyle(
                              color: ColorManager.white,
                              fontSize: FontSize.s12),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      BlocListener<ChangeUserRoleCubit, ChangeUserRoleState>(
                        listener: (context, deleteState) {
                          if (deleteState is DeleteUserSuccessState) {
                            showToast(context,
                                message: LocaleKeys.toastUserDeleted.tr(),
                                type: MessageType.success);
                            UserManagementCubit.get(context).getUsersFun();

                            Navigator.pop(context);
                          } else if (deleteState is DeleteUserErrorState) {
                            showToast(context,
                                message: deleteState.message,
                                type: MessageType.error);
                          }
                        },
                        child: InkWell(
                          onTap: () {
                            dialogCustom(
                                pressEventOk: () {
                                  ChangeUserRoleCubit.get(context).userId = id;
                                  ChangeUserRoleCubit.get(context)
                                      .deleteUserFun();
                                  // navigatorAndRemove(context, Routes.loginRoute);
                                },
                                context: context,
                                okButtonName: LocaleKeys.delete.tr(),
                                cancelButtonName: LocaleKeys.cancel.tr(),
                                body: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextCustom(
                                      text: LocaleKeys.deleteAccount,
                                      fontWeight: FontWeightManager.semiBold,
                                      fontSize: FontSize.s18,
                                    ),
                                    const RSizedBox.vertical(AppSize.s16),
                                    TextCustom(
                                      text: LocaleKeys.deleteAccountWarning,
                                      textAlign: TextAlign.center,
                                      textStyle: getMediumGilroyStyle(
                                        color: ColorManager.grey,
                                        fontSize: FontSize.s14,
                                      ),
                                    ),
                                    const RSizedBox.vertical(AppSize.s16),
                                  ],
                                ));
                          },
                          child: Container(
                            width: AppSize.s22,
                            height: AppSize.s22,
                            padding: EdgeInsets.all(AppPadding.p4),
                            decoration: ShapeDecoration(
                              color: index % 2 == 0
                                  ? ColorManager.white2
                                  : ColorManager.brown1,
                              shape: const OvalBorder(),
                            ),
                            child: SvgPictureCustom(
                              assetsName: IconAssets.delete1,
                              color: index % 2 == 0
                                  ? ColorManager.black
                                  : ColorManager.secondary,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButtonCustom(
                        width: AppSize.s100 * 1.1,
                        radius: AppSize.s20,
                        height: AppSize.s26,
                        textColor: index % 2 == 0
                            ? ColorManager.white
                            : ColorManager.black,
                        borderColor: index % 2 == 0
                            ? ColorManager.black
                            : ColorManager.secondary,
                        colors: index % 2 == 0
                            ? ColorManager.black
                            : ColorManager.secondary,
                        fontSize: FontSize.s14,
                        text: LocaleKeys.changeRole,
                        onPressed: () {
                          bottomSheetCustom(
                              height: AppSize.s100 * 4,
                              context: context,
                              body: Material(
                                  child: BlocProvider.value(
                                value: BlocProvider.of<ChangeUserRoleCubit>(
                                    context),
                                child: BlocConsumer<ChangeUserRoleCubit,
                                    ChangeUserRoleState>(
                                  listener: (context, changeState) {
                                    if (changeState is ChangeUserSuccessState) {
                                      showToast(context,
                                          message:
                                              LocaleKeys.toastChangeRole.tr(),
                                          type: MessageType.success);
                                      UserManagementCubit.get(context)
                                          .getUsersFun();
                                      Navigator.pop(context);
                                    } else if (changeState
                                        is ChangeUserErrorState) {
                                      showToast(context,
                                          message: changeState.message,
                                          type: MessageType.error);
                                    }
                                  },
                                  builder: (context, changeState) {
                                    var cubit =
                                        ChangeUserRoleCubit.get(context);
                                    return SizedBox(
                                      width: context.width,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: AppPadding.p10),
                                        child: Column(
                                          children: [
                                            const RSizedBox.vertical(
                                                AppSize.s16),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const SizedBox(),
                                                SizedBox(
                                                  height: AppSize.s30,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: TextCustom(
                                                      text:
                                                          LocaleKeys.changeRole,
                                                      fontSize: FontSize.s18,
                                                      fontWeight:
                                                          FontWeightManager
                                                              .bold,
                                                    ),
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  icon: Container(
                                                    // margin: EdgeInsets.only(top: AppPadding.p16,right: AppPadding.p16),
                                                    padding: EdgeInsets.all(
                                                        AppPadding.p8),
                                                    width: AppSize.s30.h,
                                                    height: AppSize.s30.h,
                                                    decoration:
                                                        const ShapeDecoration(
                                                      color:
                                                          ColorManager.white1,
                                                      shape: OvalBorder(),
                                                    ),
                                                    child:
                                                        const SvgPictureCustom(
                                                      assetsName:
                                                          IconAssets.close,
                                                      color: null,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return SelectWidgetCustom<
                                                    String>(
                                                  radius: AppSize.s20.r,
                                                  selectedColor:
                                                      ColorManager.secondary1,
                                                  disabledColor:
                                                      ColorManager.white1,
                                                  index: index,
                                                  value: cubit.roleModel[index]
                                                      ['id'],
                                                  groupValue: cubit.roleValue,
                                                  onChanged: (value) =>
                                                      cubit.selectRole(value!),
                                                  name: cubit.roleModel[index]
                                                      ['name'],
                                                );
                                              },
                                              itemCount: cubit.roleModel.length,
                                            ),
                                            const RSizedBox.vertical(
                                                AppSize.s30),
                                            changeState
                                                    is ChangeUserLoadingState
                                                ? const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                : ElevatedButtonCustom(
                                                    onPressed: () {
                                                      cubit.userId = id;
                                                      cubit.changeUserRoleFun();
                                                    },
                                                    text: LocaleKeys.update,
                                                  )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )));
                        },
                      )
                    ],
                  )
                ],
              ),
              const RSizedBox.vertical(AppSize.s12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
// crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      SvgPictureCustom(
                        assetsName: IconAssets.email,
                        color: index % 2 == 0
                            ? ColorManager.black
                            : ColorManager.white,
                      ),
                      const RSizedBox.horizontal(AppSize.s6),
                      SizedBox(
                        width: (AppSize.s100 * 1.1).w,
                        child: TextCustom(
                          text: email,
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                          textStyle: getRegularGilroyStyle(
                            color: index % 2 == 0
                                ? ColorManager.black
                                : Colors.white,
                            fontSize: FontSize.s12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPictureCustom(
                        assetsName: IconAssets.phone,
                        color: index % 2 == 0
                            ? ColorManager.black
                            : ColorManager.white,
                      ),
                      const RSizedBox.horizontal(AppSize.s6),
                      TextCustom(
                        text: mobilePhone,
                        textStyle: getRegularGilroyStyle(
                          color: index % 2 == 0
                              ? ColorManager.black
                              : Colors.white,
                          fontSize: FontSize.s12,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
