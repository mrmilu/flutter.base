import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../shared/presentation/helpers/toasts.dart';
import '../../../shared/presentation/providers/global_loader/global_loader_cubit.dart';
import '../../../shared/presentation/router/app_router.dart';
import '../../../shared/presentation/router/page_names.dart';
import '../../domain/failures/oauth_sign_in_failure.dart';
import '../../domain/interfaces/i_auth_repository.dart';
import '../extensions/oauth_sign_in_failure_extension.dart';
import '../providers/signin_social/signin_social_cubit.dart';
import '../widgets/social_card.dart';
import 'providers/signin_cubit.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SigninCubit(
            authRepository: context.read<IAuthRepository>(),
            globalLoaderCubit: context.read<GlobalLoaderCubit>(),
          ),
        ),
        BlocProvider(
          create: (context) => SigninSocialCubit(
            authRepository: context.read<IAuthRepository>(),
          ),
        ),
      ],
      child: const SignInView(),
    );
  }
}

class SignInView extends StatelessWidget {
  const SignInView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return BlocListener<SigninSocialCubit, SigninSocialState>(
              listener: (context, state) {
                state.resultOr.whenIsFailure(
                  (e) {
                    if (e is! OAuthSignInFailureCancel) {
                      showError(context, message: e.toTranslate(context));
                    }
                  },
                );
              },
              child: BlocConsumer<SigninCubit, SigninState>(
                listener: (context, state) {
                  state.resultOr.whenIsFailure(
                    (failure) {},
                  );
                },
                builder: (context, stateSignIn) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        SizedBox(height: constraints.maxHeight * 0.1),
                        Image.network(
                          "https://i.postimg.cc/nz0YBQcH/Logo-light.png",
                          height: 100,
                        ),
                        SizedBox(height: constraints.maxHeight * 0.1),
                        Text(
                          "Sign In",
                          style: Theme.of(context).textTheme.headlineSmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: constraints.maxHeight * 0.05),
                        Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Phone',
                                filled: true,
                                fillColor: Color(0xFFF5FCF9),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.0 * 1.5,
                                  vertical: 16.0,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.phone,
                              onSaved: (phone) {
                                // Save it
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16.0,
                              ),
                              child: TextFormField(
                                obscureText: true,
                                decoration: const InputDecoration(
                                  hintText: 'Password',
                                  filled: true,
                                  fillColor: Color(0xFFF5FCF9),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0 * 1.5,
                                    vertical: 16.0,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  ),
                                ),
                                onSaved: (passaword) {
                                  // Save it
                                },
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: const Color(0xFF00BF6D),
                                foregroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 48),
                                shape: const StadiumBorder(),
                              ),
                              child: const Text("Sign in"),
                            ),
                            const SizedBox(height: 16.0),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forgot Password?',
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color!
                                          .withAlpha((0.64 * 255).toInt()),
                                    ),
                              ),
                            ),
                            TextButton(
                              onPressed: () =>
                                  routerApp.pushNamed(PageNames.signUp),
                              child: Text.rich(
                                const TextSpan(
                                  text: "Don’t have an account? ",
                                  children: [
                                    TextSpan(
                                      text: "Sign Up",
                                      style: TextStyle(
                                        color: Color(0xFF00BF6D),
                                      ),
                                    ),
                                  ],
                                ),
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color!
                                          .withAlpha((0.64 * 255).toInt()),
                                    ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SocalCard(
                              icon: SvgPicture.string(googleIcon),
                              press: () => context
                                  .read<SigninSocialCubit>()
                                  .signInWithGoogle(),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: SocalCard(
                                icon: SvgPicture.string(facebookIcon),
                                press: () => context
                                    .read<SigninSocialCubit>()
                                    .signInWithApple(),
                              ),
                            ),
                            SocalCard(
                              icon: SvgPicture.string(twitterIcon),
                              press: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

const mailIcon =
    '''<svg width="18" height="13" viewBox="0 0 18 13" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M15.3576 3.39368C15.5215 3.62375 15.4697 3.94447 15.2404 4.10954L9.80876 8.03862C9.57272 8.21053 9.29421 8.29605 9.01656 8.29605C8.7406 8.29605 8.4638 8.21138 8.22775 8.04204L2.76041 4.11039C2.53201 3.94618 2.47851 3.62546 2.64154 3.39454C2.80542 3.16362 3.12383 3.10974 3.35223 3.27566L8.81872 7.20645C8.93674 7.29112 9.09552 7.29197 9.2144 7.20559L14.6469 3.27651C14.8753 3.10974 15.1937 3.16447 15.3576 3.39368ZM16.9819 10.7763C16.9819 11.4366 16.4479 11.9745 15.7932 11.9745H2.20765C1.55215 11.9745 1.01892 11.4366 1.01892 10.7763V2.22368C1.01892 1.56342 1.55215 1.02632 2.20765 1.02632H15.7932C16.4479 1.02632 16.9819 1.56342 16.9819 2.22368V10.7763ZM15.7932 0H2.20765C0.990047 0 0 0.998092 0 2.22368V10.7763C0 12.0028 0.990047 13 2.20765 13H15.7932C17.01 13 18 12.0028 18 10.7763V2.22368C18 0.998092 17.01 0 15.7932 0Z" fill="#757575"/>
</svg>''';

const lockIcon =
    '''<svg width="15" height="18" viewBox="0 0 15 18" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M9.24419 11.5472C9.24419 12.4845 8.46279 13.2453 7.5 13.2453C6.53721 13.2453 5.75581 12.4845 5.75581 11.5472C5.75581 10.6098 6.53721 9.84906 7.5 9.84906C8.46279 9.84906 9.24419 10.6098 9.24419 11.5472ZM13.9535 14.0943C13.9535 15.6863 12.6235 16.9811 10.9884 16.9811H4.01163C2.37645 16.9811 1.04651 15.6863 1.04651 14.0943V9C1.04651 7.40802 2.37645 6.11321 4.01163 6.11321H10.9884C12.6235 6.11321 13.9535 7.40802 13.9535 9V14.0943ZM4.53488 3.90566C4.53488 2.31368 5.86483 1.01887 7.5 1.01887C8.28488 1.01887 9.03139 1.31943 9.59477 1.86028C10.1564 2.41387 10.4651 3.14066 10.4651 3.90566V5.09434H4.53488V3.90566ZM11.5116 5.12745V3.90566C11.5116 2.87151 11.0956 1.89085 10.3352 1.14028C9.5686 0.405 8.56221 0 7.5 0C5.2875 0 3.48837 1.7516 3.48837 3.90566V5.12745C1.52267 5.37792 0 7.01915 0 9V14.0943C0 16.2484 1.79913 18 4.01163 18H10.9884C13.2 18 15 16.2484 15 14.0943V9C15 7.01915 13.4773 5.37792 11.5116 5.12745Z" fill="#757575"/>
</svg>''';

const googleIcon =
    '''<svg width="16" height="17" viewBox="0 0 16 17" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M15.9988 8.3441C15.9988 7.67295 15.9443 7.18319 15.8265 6.67529H8.1626V9.70453H12.6611C12.5705 10.4573 12.0807 11.5911 10.9923 12.3529L10.9771 12.4543L13.4002 14.3315L13.5681 14.3482C15.1099 12.9243 15.9988 10.8292 15.9988 8.3441Z" fill="#4285F4"/>
<path d="M8.16265 16.3254C10.3666 16.3254 12.2168 15.5998 13.5682 14.3482L10.9924 12.3528C10.3031 12.8335 9.37796 13.1691 8.16265 13.1691C6.00408 13.1691 4.17202 11.7452 3.51894 9.7771L3.42321 9.78523L0.903556 11.7352L0.870605 11.8268C2.2129 14.4933 4.9701 16.3254 8.16265 16.3254Z" fill="#34A853"/>
<path d="M3.519 9.77716C3.34668 9.26927 3.24695 8.72505 3.24695 8.16275C3.24695 7.6004 3.34668 7.05624 3.50994 6.54834L3.50537 6.44017L0.954141 4.45886L0.870669 4.49857C0.317442 5.60508 0 6.84765 0 8.16275C0 9.47785 0.317442 10.7204 0.870669 11.8269L3.519 9.77716Z" fill="#FBBC05"/>
<path d="M8.16265 3.15623C9.69541 3.15623 10.7293 3.81831 11.3189 4.3716L13.6226 2.12231C12.2077 0.807206 10.3666 0 8.16265 0C4.9701 0 2.2129 1.83206 0.870605 4.49853L3.50987 6.54831C4.17202 4.58019 6.00408 3.15623 8.16265 3.15623Z" fill="#EB4335"/>
</svg>''';

const facebookIcon =
    '''<svg width="8" height="15" viewBox="0 0 8 15" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M5.02224 14.8963V8.10133H7.30305L7.64452 5.45323H5.02224V3.7625C5.02224 2.99583 5.23517 2.4733 6.33467 2.4733L7.73695 2.47265V0.104232C7.49432 0.0720777 6.66197 0 5.6936 0C3.67183 0 2.28768 1.23402 2.28768 3.50037V5.4533H0.000976562V8.1014H2.28761V14.8963L5.02224 14.8963Z" fill="#3C5A9A"/>
</svg>''';

const twitterIcon =
    '''<svg width="16" height="14" viewBox="0 0 16 14" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M15.9821 1.5867C15.3952 1.84714 14.7648 2.0232 14.102 2.10234C14.7785 1.69727 15.2967 1.05538 15.5414 0.291424C14.8988 0.673076 14.1955 0.941758 13.4622 1.0858C12.8654 0.449657 12.0143 0.0524902 11.0728 0.0524902C9.26556 0.0524902 7.79989 1.51757 7.79989 3.32586C7.79989 3.58208 7.82875 3.83204 7.88423 4.07203C5.16367 3.9353 2.75173 2.63213 1.13729 0.651959C0.855385 1.13557 0.694025 1.69786 0.694025 2.29779C0.694025 3.43331 1.27199 4.43519 2.15019 5.02206C1.63031 5.00595 1.12184 4.86563 0.66728 4.61281V4.65418C0.66728 6.24031 1.79545 7.56287 3.29302 7.86367C3.01792 7.93904 2.72921 7.97842 2.43053 7.97842C2.21936 7.97842 2.01448 7.95844 1.81433 7.92079C2.23089 9.22084 3.4398 10.1671 4.8718 10.1939C3.75149 11.0721 2.33986 11.5956 0.806669 11.5956C0.542595 11.5956 0.281606 11.5798 0.0253906 11.549C1.47425 12.478 3.19453 13.0203 5.04317 13.0203C11.0639 13.0203 14.3567 8.03242 14.3567 3.70685C14.3567 3.56484 14.3535 3.42389 14.3467 3.28344C14.9882 2.81942 15.542 2.24487 15.9821 1.5867Z" fill="#2DAAE1"/>
</svg>''';
