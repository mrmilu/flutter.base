import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/domain/interfaces/i_token_repository.dart';
import '../../../shared/data/services/http_client.dart';
import '../../../shared/presentation/utils/styles/colors/colors_context.dart';
import '../../../shared/presentation/widgets/common/image_asset_widget.dart';
import '../../../shared/presentation/widgets/common/image_network_widget.dart';
import '../../../shared/presentation/widgets/custom_app_bar_widget.dart';
import '../../data/repositories/main_home_repository_impl.dart';
import '../../domain/interfaces/i_main_home_repository.dart';
import '../providers/main_home_cubit.dart';
import '../widgets/main_home_welcome_widget.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final httpClient = getMyHttpClient(context.read<ITokenRepository>());

    return RepositoryProvider<IMainHomeRepository>(
      create: (_) => MainHomeRepositoryImpl(httpClient: httpClient),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MainHomeCubit(
              repository: context.read<IMainHomeRepository>(),
            )..init(),
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<MainHomeCubit, MainHomeState>(
              listener: (context, state) {
                if (state.resourceGetProducts.isSuccess) {
                  // Do something
                }
              },
            ),
          ],
          child: const MainHomeView(),
        ),
      ),
    );
  }
}

class MainHomeView extends StatefulWidget {
  const MainHomeView({super.key});

  @override
  State<MainHomeView> createState() => _MainHomeViewState();
}

class _MainHomeViewState extends State<MainHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            const CustomAppBarWidget(),
            SliverToBoxAdapter(
              child: Stack(
                fit: StackFit.loose,
                children: [
                  const Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      height: 181,
                      width: double.infinity,
                      child: ImageAssetWidget(
                        path: 'assets/images/ente_partial.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: MainHomeWelcomeWidget(),
                      ),
                    ],
                  ),
                  Container(
                    height: 200,
                    width: 300,
                    color: context.colors.primary,
                    child: const Center(
                      child: ImageNetworkWidget(
                        imageUrl: null,
                        height: 150,
                        width: 100,
                        placeholderSvg: RMImagePlaceholders.minimal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: BlocBuilder<MainHomeCubit, MainHomeState>(
                  builder: (context, state) {
                    return state.resourceGetProducts.map(
                      isNone: () => const Text('No products found'),
                      isLoading: () =>
                          const Center(child: CircularProgressIndicator()),
                      isFailure: (error) => Text('Error: $error'),
                      isSuccess: (products) => ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ListTile(
                            title: Text(product),
                            subtitle: Text('\$$product $index'),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
