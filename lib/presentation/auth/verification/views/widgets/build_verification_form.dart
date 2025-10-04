import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/domain/entities/requests/forget_password_and_resend_code_request/forget_password_and_resend_code_request_entity.dart';
import 'package:flowery_tracking_app/domain/entities/requests/verify_request/verify_requset_entity.dart';
import 'package:flowery_tracking_app/presentation/auth/verification/views/widgets/pin_code_textfiled.dart';
import 'package:flowery_tracking_app/presentation/auth/verification/views/widgets/resend_code_row.dart';
import 'package:flowery_tracking_app/presentation/auth/verification/views/widgets/title_and_subtitle_of_verification.dart';
import 'package:flowery_tracking_app/presentation/auth/verification/views_model/verification_screen_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/verification/views_model/verification_screen_intent.dart';
import 'package:flowery_tracking_app/presentation/auth/verification/views_model/verification_screen_state.dart';
import 'package:flowery_tracking_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildVerificationForm extends StatelessWidget {
  const BuildVerificationForm({
    super.key,
    required this.email,
    required this.isError,
  });

  final String email;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<VerificationScreenCubit>(context);
    return Padding(
      padding: REdgeInsets.all(16),
      child: Form(
        key: cubit.formKey,
        autovalidateMode: cubit.state.autoValidateMode,
        child: BlocBuilder<VerificationScreenCubit, VerificationScreenState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TitleAndSubtitleOfVerification(),
                SizedBox(height: 30.h),
                PinCodeTextFiledWidget(
                  isError: isError,
                  verificationController: cubit.verificationController,
                  onCompleted: (value) {
                    BlocProvider.of<VerificationScreenCubit>(context).doIntent(
                      OnVerificationIntent(
                        request: VerifyRequestEntity(
                          resetCode: cubit.verificationController.text,
                        ),
                      ),
                    );
                  },
                  onSubmitted: (value) {
                    if (value.isEmpty || value.length < 6) {
                      Loaders.showErrorMessage(
                        message: AppText.enter6DigitCode.tr(),
                        context: context,
                      );
                      return;
                    }
                    BlocProvider.of<VerificationScreenCubit>(context).doIntent(
                      OnVerificationIntent(
                        request: VerifyRequestEntity(resetCode: value),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20.h),
                Visibility(
                  visible: state.secondsRemaining > 0,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: Text(
                    '${AppText.resendAvailableStatement.tr()}${state.secondsRemaining}s',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.red),
                  ),
                ),
                SizedBox(height: 20.h),
                ResendCodeRow(
                  isDisabled: state.secondsRemaining > 0,
                  onResend: () {
                    BlocProvider.of<VerificationScreenCubit>(context).doIntent(
                      OnResendCodeClickIntent(
                        request: ForgetPasswordAndResendCodeRequestEntity(
                          email: email,
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
