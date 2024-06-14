import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/ui/profile_flow/subscriptions_screen/subscriptions_screen_view_model.dart';
import 'package:help_my_truck/ui/widgets/custom_button.dart';
import 'package:help_my_truck/ui/widgets/loadable.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/main_navigation_bar.dart';
import 'package:help_my_truck/ui/widgets/round_checkbox.dart';

class SubscriptionsScreen extends StatefulWidget {
  final SubscriptionsScreenViewModel viewModel;

  const SubscriptionsScreen({super.key, required this.viewModel});

  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: MainNavigationBar(
        title: l10n?.subscription,
        context: context,
        styles: styles,
        bgColor: ColorConstants.surfacePrimaryDark,
      ),
      backgroundColor: ColorConstants.surfacePrimaryDark,
      body: StreamBuilder<SubscriptionInfo>(
        stream: widget.viewModel.info,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder<bool>(
              stream: widget.viewModel.isLoading,
              builder: (context, innerSnapshot) {
                return Stack(
                  children: [
                    _body(styles, l10n, snapshot.data!),
                    if (innerSnapshot.data ?? false)
                      Loadable(
                        forceLoad: true,
                        child: Container(),
                      )
                  ],
                );
              },
            );
          } else {
            return Loadable(forceLoad: true, child: Container());
          }
        },
      ),
    );
  }

  Widget _body(
    TextTheme styles,
    AppLocalizations? l10n,
    SubscriptionInfo data,
  ) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _content(styles, l10n, data),
        ),
      ),
    );
  }

  List<Widget> _content(
    TextTheme styles,
    AppLocalizations? l10n,
    SubscriptionInfo data,
  ) {
    return [
      Text(
        widget.viewModel.isSubscribed
            ? l10n?.active_subscription ?? ''
            : l10n?.inactive_subscription ?? '',
        style: styles.bodySmall?.copyWith(
          color: ColorConstants.onSurfaceWhite,
          fontWeight: FontWeight.w400,
        ),
      ),
      const SizedBox(height: 12),
      _table(styles, l10n, data),
      const SizedBox(height: 24),
      _restoreBlock(l10n, styles),
      const SizedBox(height: 24),
      if (!widget.viewModel.isSubscribed) _subscriptionButton(l10n),
    ];
  }

  Widget _table(
    TextTheme styles,
    AppLocalizations? l10n,
    SubscriptionInfo data,
  ) {
    final isFree = !widget.viewModel.isSubscribed;
    final String? currentPeriod;

    switch (data.currentPeriod) {
      case SubscriptionPeriod.annual:
        currentPeriod = l10n?.annual;
      case SubscriptionPeriod.monthly:
        currentPeriod = l10n?.monthly;
      case SubscriptionPeriod.freeTrial:
        currentPeriod = l10n?.free_trial;
      default:
        currentPeriod = null;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: ColorConstants.surfaceSecondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _item(
            styles,
            l10n?.current_period ?? '',
            isFree ? null : currentPeriod,
          ),
          _item(
            styles,
            l10n?.subscribed_since ?? '',
            isFree ? null : data.since,
          ),
          _item(
            styles,
            l10n?.renews_on ?? '',
            isFree ? null : data.renewal,
          ),
        ],
      ),
    );
  }

  Widget _item(TextTheme styles, String title, String? value) {
    return SizedBox(
      height: 48,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            title,
            style: styles.bodyLarge?.copyWith(
              color: ColorConstants.onSurfaceWhite,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            value ?? '-',
            style: styles.bodyLarge?.copyWith(
              color: ColorConstants.onSurfaceWhite,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _restoreBlock(AppLocalizations? l10n, TextTheme styles) {
    return GestureDetector(
      onTap: () {
        widget.viewModel.restore();
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ColorConstants.surfaceSecondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RoundCheckbox(
              isChecked: true,
              onTap: (isChecked) {},
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n?.restore_purchases ?? '',
                    style: styles.bodyLarge
                        ?.copyWith(color: ColorConstants.onSurfaceWhite),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n?.multiple_subscription ?? '',
                    softWrap: true,
                    style: styles.bodySmall
                        ?.copyWith(color: ColorConstants.onSurfaceWhite),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _subscriptionButton(AppLocalizations? l10n) {
    return CustomButton(
      title: CustomButtonTitle(text: l10n?.subscribe ?? ''),
      state: CustomButtonStates.filled,
      mainColor: ColorConstants.surfaceWhite,
      textColor: ColorConstants.onSurfaceHigh,
      height: 40,
      onPressed: () => widget.viewModel.subscribe().then(
            (value) => setState(() {}),
          ),
    );
  }
}
