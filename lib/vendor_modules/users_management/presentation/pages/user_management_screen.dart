import 'package:doctor_ack/core/widgets/app_bar/app_bar_custom.dart';
import 'package:doctor_ack/core/widgets/error_widget.dart';
import 'package:doctor_ack/core/widgets/lock_role.dart';
import 'package:doctor_ack/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:doctor_ack/core/widgets/shimmer_custom/shimmer_horizontal.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:doctor_ack/vendor_modules/users_management/presentation/controller/user_management_state.dart';
import 'package:doctor_ack/vendor_modules/users_management/presentation/widgets/customers_screen.dart';
import 'package:doctor_ack/vendor_modules/users_management/presentation/widgets/users_screen.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/tab_bar_custom/tab_bar_custom.dart';
import '../controller/user_management_cubit.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        text: LocaleKeys.userManagement,
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TabBarCustom(radius: AppSize.s26, myTabs: [
              Tab(
                text: LocaleKeys.users.tr(),
              ),
              Tab(
                text: LocaleKeys.customers.tr(),
              ),
            ], widgets: [
              AppConstants.role == 'admin' || AppConstants.type == 'clinic'
                  ? BlocProvider.value(
                      value: BlocProvider.of<UserManagementCubit>(context)
                        ..getUsersFun(),
                      child:
                          BlocBuilder<UserManagementCubit, UserManagementState>(
                        builder: (context, state) {
                          var usersCubit = UserManagementCubit.get(context);
                          return switch (state) {
                            GetUsersSuccessState() => SmartRefresher(
                                controller: usersCubit.refreshController,
                                onRefresh: () => usersCubit.getUsersFun(),
                                child: ListView.builder(
                                  // reverse: true,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return UsersScreen(
                                      name: state.usersEntity.resultEntity
                                          .response[index].name,
                                      id: state.usersEntity.resultEntity
                                          .response[index].id,
                                      imageUrl: state.usersEntity.resultEntity
                                          .response[index].imageUrl,
                                      email: state.usersEntity.resultEntity
                                          .response[index].email,
                                      mobilePhone: state
                                          .usersEntity
                                          .resultEntity
                                          .response[index]
                                          .mobilePhone,
                                      role: state.usersEntity.resultEntity
                                          .response[index].role,
                                      index: index,
                                    );
                                  },
                                  itemCount: state
                                      .usersEntity.resultEntity.response.length,
                                ),
                              ),
                            GetUsersErrorState() => ErrorsWidget(
                                onPress: () => usersCubit.getUsersFun(),
                              ),
                            GetUsersLoadingState() => const ShimmerVertical(),
                            _ => const ShimmerVertical(),
                          };
                        },
                      ),
                    )
                  : const LockRoleWidget(),
              const CustomersScreen(),
            ]),
          ],
        ),
      ),
    );
  }
}
