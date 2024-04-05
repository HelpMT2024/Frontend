printf "Fetching... \n"

dart run l10n_fetcher.dart >/dev/null 2>&1
fvm dart run l10n_fetcher.dart >/dev/null 2>&1
flutter gen-l10n >/dev/null 2>&1
fvm flutter gen-l10n >/dev/null 2>&1

printf "Done. Output is mutted, so please, check if all files are rightly updated. \n"
