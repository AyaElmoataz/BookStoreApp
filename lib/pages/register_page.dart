import 'package:book_store_app/constants/app_colors.dart';
import 'package:book_store_app/constants/app_strings.dart';
import 'package:book_store_app/controllers/register_controller.dart';
import 'package:book_store_app/providers/register_loading_provider.dart';
import 'package:book_store_app/widgets/custom_button.dart';
import 'package:book_store_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(registerLoadingProvider);

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
                    AppStrings.registerHeader,
                    style: TextStyle(fontSize: 24, color: kPrimaryColor),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hintText: AppStrings.emailHint,
                isPassword: false,
                controller: emailController,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hintText: AppStrings.passwordHint,
                isPassword: true,
                controller: passwordController,
              ),
              const SizedBox(height: 10),
              CustomButton(
                onTap: () => ref
                    .read(registerControllerProvider)
                    .register(
                      context,
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    ),
                text: AppStrings.registerButton,
              ),
              const Spacer(flex: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    AppStrings.alreadyHaveAccount,
                    style: TextStyle(color: kPrimaryColor),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      AppStrings.loginLink,
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
