import 'package:book_store_app/constants/app_strings.dart';
import 'package:book_store_app/constants/app_colors.dart';
import 'package:book_store_app/pages/register_page.dart';
import 'package:book_store_app/providers/login_loading_provider.dart';
import 'package:book_store_app/controllers/login_controller.dart';
import 'package:book_store_app/widgets/custom_button.dart';
import 'package:book_store_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loginLoadingProvider);

    String email = '';
    String password = '';

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: const CircularProgressIndicator(color: kPrimaryColor),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const Spacer(flex: 4),
              Image.asset('assets/images/icon.png', width: 100),
              const Spacer(flex: 1),
              const Text(
                AppStrings.appName,
                style: TextStyle(fontSize: 32, color: kPrimaryColor),
              ),
              const Spacer(flex: 2),
              const Row(
                children: [
                  Text(
                    AppStrings.loginHeader,
                    style: TextStyle(fontSize: 24, color: kPrimaryColor),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hintText: AppStrings.emailHint,
                isPassword: false,
                onChanged: (data) => email = data,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hintText: AppStrings.passwordHint,
                isPassword: true,
                onChanged: (data) => password = data,
              ),
              const SizedBox(height: 10),
              CustomButton(
                onTap: () => ref
                    .read(loginControllerProvider)
                    .login(context, email, password),
                text: AppStrings.loginButton,
              ),
              const Spacer(flex: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    AppStrings.dontHaveAccount,
                    style: TextStyle(color: kPrimaryColor),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (c) => RegisterPage()),
                    ),
                    child: const Text(
                      AppStrings.registerLink,
                      style: TextStyle(color: kSecondaryColor),
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
