import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/const/resource.dart';
import 'package:help_my_truck/services/API/favorites_provider.dart';
import 'package:help_my_truck/ui/favorites_flow/favorites_screen_view_model.dart';
import 'package:help_my_truck/ui/widgets/bookmark_button.dart';
import 'package:help_my_truck/ui/widgets/custom_button.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/main_navigation_bar.dart';
import 'package:help_my_truck/ui/widgets/no_connection_placeholder.dart';
import 'package:paginated_list/paginated_list.dart';

class FavoritesScreen extends StatefulWidget {
  final FavoritesScreenViewModel viewModel;
  const FavoritesScreen({super.key, required this.viewModel});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    widget.viewModel.updateDataStreamController.close();

    super.dispose();
  }

  @override
  void initState() {
    print('INIT STATE');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final styles = Theme.of(context).textTheme;

    return Scaffold(
      appBar: MainNavigationBar(
        bgColor: ColorConstants.surfacePrimaryDark,
        context: context,
        styles: styles,
        title: l10n?.favorites_title ?? '',
      ),
      body: _successBody(),
    );
  }

  Widget _successBody() {
    return Container(
      color: ColorConstants.surfacePrimaryDark,
      padding: const EdgeInsets.only(
        top: 24,
        left: 16,
        right: 16,
      ),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: buttons(),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Expanded(
            child: StreamBuilder<List<FavoritesListItem>>(
              stream: widget.viewModel.updateDataStreamController.stream,
              builder: (context, AsyncSnapshot snapshot) {
                return PaginatedList<FavoritesListItem>(
                    scrollDirection: Axis.vertical,
                    controller: _scrollController,
                    loadingIndicator: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.black),
                      ),
                    ),
                    items: widget.viewModel.fetchedItems,
                    isRecentSearch: false,
                    isLastPage: widget.viewModel.isLastPage,
                    onLoadMore: (index) {
                      widget.viewModel.getPage();
                    },
                    builder: (item, index) => listViewCell(item, index));
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buttons() {
    return FavoriteModelTypes.values.map((type) {
      return Row(
        children: [
          customTabButton(type.title(context), null, true),
          const SizedBox(
            width: 8,
          ),
        ],
      );
    }).toList();
  }

  Widget customTabButton(String title, Function()? onPressed, bool isSelected) {
    return CustomButton(
      height: 28,
      textColor: isSelected
          ? ColorConstants.onSurfaceWhite
          : ColorConstants.surfacePrimaryDark,
      borderColor: ColorConstants.stroke,
      borderRadius: 8,
      title: CustomButtonTitle(
        text: title,
      ),
      state:
          isSelected ? CustomButtonStates.outlined : CustomButtonStates.filled,
      onPressed: onPressed,
    );
  }

  Widget listViewCell(FavoritesListItem model, int index) {
    final styles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          // widget.viewModel.handleClick(model, context);
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: ColorConstants.surfaceSecondary,
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 0, top: 6, bottom: 6),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    model.integrationId,
                    style: styles.titleMedium
                        ?.copyWith(color: ColorConstants.onSurfaceWhite),
                  ),
                ),
                const SizedBox(width: 8),
                BookmarkButton(
                  widget.viewModel.fetchedItems[index].integrationId,
                  widget.viewModel.provider,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget placeholder() {
    final l10n = AppLocalizations.of(context);
    final styles = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.only(left: 65, right: 65),
      color: ColorConstants.surfacePrimaryDark,
      child: Center(
        child: Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                R.ASSETS_BOOKMARK_SVG,
                height: 128,
                width: 128,
              ),
              const SizedBox(
                height: 23,
              ),
              Text(
                l10n?.favorites_placeholder_title ?? '',
                textAlign: TextAlign.center,
                style: styles.titleMedium
                    ?.copyWith(color: ColorConstants.onSurfaceWhite),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                l10n?.favorites_placeholder_description ?? '',
                style: styles.bodyMedium
                    ?.copyWith(color: ColorConstants.onSurfaceWhite80),
              )
            ],
          ),
        ),
      ),
    );
  }
}
