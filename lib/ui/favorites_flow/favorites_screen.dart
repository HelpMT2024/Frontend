import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/const/resource.dart';
import 'package:help_my_truck/data/models/favorite_model_type.dart';
import 'package:help_my_truck/services/API/favorites_provider.dart';
import 'package:help_my_truck/ui/favorites_flow/favorites_screen_view_model.dart';
import 'package:help_my_truck/ui/widgets/bookmark_button.dart';
import 'package:help_my_truck/ui/widgets/filter_tab_bar.dart';
import 'package:help_my_truck/ui/widgets/loadable.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/main_navigation_bar.dart';
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

    super.dispose();
  }

  @override
  void initState() {
    widget.viewModel.selectedFilter = FavoriteModelType.unit;
    widget.viewModel.resetData();

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
      body: _commonBody(),
    );
  }

  Widget _commonBody() {
    final titles =
        FavoriteModelType.values.map((e) => e.title(context)).toList();

    return Container(
      color: ColorConstants.surfacePrimaryDark,
      padding: const EdgeInsets.only(
        top: 24,
        left: 16,
        right: 16,
      ),
      child: Column(
        children: [
          FilterTabBar(
            titles: titles,
            outputSelectionCallback: handleTabButtonClick,
            initSelectionIndex: 0,
          ),
          const SizedBox(
            height: 24,
          ),
          StreamBuilder<List<FavoritesListItem>>(
              stream: widget.viewModel.updateDataStreamController.stream,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Expanded(
                    child: Loadable(
                      forceLoad: true,
                      child: SizedBox(
                        height: 40,
                        width: 40,
                      ),
                    ),
                  );
                } else if (snapshot.data?.length == 0) {
                  return _placeholder();
                } else if (snapshot.hasData) {
                  return _successBody();
                } else if (snapshot.hasError) {
                  return Text('Error ${snapshot.hasData}');
                } else {
                  return Container();
                }
              }),
        ],
      ),
    );
  }

  void handleTabButtonClick(int index) {
    widget.viewModel.handleTabButtonClick(index);
    setState(() { });
  }

  Widget _successBody() {
    return Flexible(
      child: PaginatedList<FavoritesListItem>(
        scrollDirection: Axis.vertical,
        controller: _scrollController,
        loadingIndicator: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(child: Loadable(forceLoad: true, child: Container())),
        ),
        items: widget.viewModel.fetchedItems,
        isRecentSearch: false,
        isLastPage: widget.viewModel.isLastPage,
        onLoadMore: (index) {
          widget.viewModel.getPage();
        },
        builder: (item, index) => listViewCell(item, index),
      ),
    );
  }

  Widget listViewCell(FavoritesListItem model, int index) {
    final styles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          widget.viewModel.handleClick(model, context);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: ColorConstants.surfaceSecondary,
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 0, top: 6, bottom: 6),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    model.name ?? '',
                    overflow: TextOverflow.visible,
                    style: styles.titleMedium
                        ?.copyWith(color: ColorConstants.onSurfaceWhite),
                  ),
                ),
                const SizedBox(width: 8),
                BookmarkButton(
                  20,
                  widget.viewModel.fetchedItems[index].integrationId,
                  null,
                  widget.viewModel.provider,
                  null,
                  false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _placeholder() {
    final l10n = AppLocalizations.of(context);
    final styles = Theme.of(context).textTheme;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(left: 65, right: 65),
        color: ColorConstants.surfacePrimaryDark,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 86,),
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
    );
  }
}
