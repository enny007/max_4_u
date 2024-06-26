import 'package:flutter/material.dart';
import 'package:max_4_u/app/screens/notification/components/transaction_details_component.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                  horizontalSpace(99),
                  const Text(
                    'Notifications',
                    style: AppTextStyles.font18,
                  )
                ],
              ),
              verticalSpace(32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today',
                    style: AppTextStyles.font14.copyWith(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff333333),
                    ),
                  ),
                  Text(
                    'Mark as read',
                    style: AppTextStyles.font14.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ],
              ),
              verticalSpace(12),
              const TransactionDetailComponent(isSuccess: false),
              verticalSpace(12),
              const TransactionDetailComponent(isSuccess: true),
              verticalSpace(12),
              const TransactionDetailComponent(isSuccess: true),
              verticalSpace(33),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Yesterday',
                  style: AppTextStyles.font14.copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff333333),
                  ),
                ),
              ),
              verticalSpace(8),
              const TransactionDetailComponent(isSuccess: false),
              verticalSpace(12),
              const TransactionDetailComponent(isSuccess: true),
              verticalSpace(12),
              const TransactionDetailComponent(isSuccess: true),
              verticalSpace(12),
              const TransactionDetailComponent(isSuccess: false),
              verticalSpace(12),
              const TransactionDetailComponent(isSuccess: true),
              verticalSpace(12),
              const TransactionDetailComponent(isSuccess: true),
            ],
          ),
        ),
      )),
    );
  }
}
