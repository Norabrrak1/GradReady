import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ready/features/user/cubit/user_cubit.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/styles.dart';


class UserNavigation extends StatefulWidget {
  const UserNavigation({super.key});

  @override
  State<UserNavigation> createState() => _UserNavigationState();
}

class _UserNavigationState extends State<UserNavigation> {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {

      },

      builder: (context, state) {
        var cubit = UserCubit.get(context);
        return Scaffold(
          body: cubit.page[cubit.pageIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.pageIndex,
            backgroundColor: AppColors.white,
            selectedLabelStyle: AppTextStyles.w400s,
            unselectedLabelStyle: AppTextStyles.w400s,
            unselectedItemColor: AppColors.orange,
            selectedItemColor: AppColors.blue2,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              setState(() {
              cubit.changeBottomNav(index);

              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage('assets/images/briefcase.png'),
                    size: 30,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage('assets/images/home (1).png'),
                    size: 30,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage('assets/images/user (1).png'),
                    size: 30,
                  ),
                  label: ''),
            ],
          ),
        );
      },
    );
  }
}
