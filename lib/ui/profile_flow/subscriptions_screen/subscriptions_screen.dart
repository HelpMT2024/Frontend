import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/ui/profile_flow/subscriptions_screen/subscriptions_screen_view_model.dart';
import 'package:help_my_truck/ui/widgets/custom_button.dart';
import 'package:help_my_truck/ui/widgets/loadable.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/main_navigation_bar.dart';

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
            return _body(styles, l10n, snapshot.data!);
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
      if (!widget.viewModel.isSubscribed) _subscriptionButton(l10n),
    ];
  }

  Widget _table(
    TextTheme styles,
    AppLocalizations? l10n,
    SubscriptionInfo data,
  ) {
    final isFree = !widget.viewModel.isSubscribed;

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
            isFree ? null : data.currentPeriod,
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
