import '../../../../src_export.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController(text: '+971');
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _termsAccepted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSignUp(BuildContext context) {
    context.read<AuthBloc>().add(
          RegisterCustomerEvent(
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            phoneNumber: _phoneController.text.trim(),
            password: _passwordController.text,
            confirmPassword: _confirmPasswordController.text,
            termsAccepted: _termsAccepted,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              // Show success message then navigate to verification
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              context.pushNamed(RoutesPath.verificationPath);
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return SingleChildScrollView(
              child: Padding(
                padding: AppPadding.getPadding12(context).copyWith(top: 0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12,
                    children: [
                      CustomText(
                        AppStaticStrings.signUp,
                        variant: TextVariant.headlineLarge,
                      ),
                      CustomText(
                        AppStaticStrings.letsGetYouSetUp,
                        variant: TextVariant.titleSmall,
                        color: AppColors.kBlueColor,
                      ),
                      space6H,
                      CustomTextField(
                        title: AppStaticStrings.preferredName,
                        hintText: AppStaticStrings.preferredName,
                        textEditingController: _nameController,
                      ),
                      CustomTextField(
                        title: AppStaticStrings.email,
                        hintText: AppStaticStrings.email,
                        textEditingController: _emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      CustomTextField(
                        title: AppStaticStrings.phoneNumber,
                        hintText: AppStaticStrings.phoneNumber,
                        keyboardType: TextInputType.phone,
                        textEditingController: _phoneController,
                      ),
                      CustomTextField(
                        title: AppStaticStrings.password,
                        hintText: AppStaticStrings.password,
                        isPassword: true,
                        textEditingController: _passwordController,
                      ),
                      CustomTextField(
                        title: AppStaticStrings.confirmPassword,
                        hintText: AppStaticStrings.confirmPassword,
                        isPassword: true,
                        textEditingController: _confirmPasswordController,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: _termsAccepted,
                            onChanged: (value) =>
                                setState(() => _termsAccepted = value ?? false),
                          ),
                          Expanded(
                            child: Wrap(
                              children: [
                                CustomText(AppStaticStrings.iHaveReadAndAgree),
                                ButtonTapWidget(
                                  onTap: () {
                                    // TODO: Navigate to Terms and Conditions
                                  },
                                  child: CustomText(
                                    AppStaticStrings.termsAndConditions,
                                    color: AppColors.kPrimaryColor,
                                  ),
                                ),
                                CustomText(AppStaticStrings.and),
                                ButtonTapWidget(
                                  onTap: () {
                                    // TODO: Navigate to Privacy Policy
                                  },
                                  child: CustomText(
                                    AppStaticStrings.privacyPolicy,
                                    color: AppColors.kPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      CustomButton(
                        text: AppStaticStrings.signUp,
                        isLoading: isLoading,
                        onPressed: () => _onSignUp(context),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
