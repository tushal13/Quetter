import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
  AdHelper._();

  static final AdHelper adHelper = AdHelper._();

  late RewardedAd rewardedAd;

  late String rewardedAdUnitId = "ca-app-pub-3940256099942544/5224354917";

  Future<void> initializeAd() async {
    await loadRewardedAd();
  }

  Future<void> loadRewardedAd() async {
    RewardedAd.load(
        adUnitId: rewardedAdUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            rewardedAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error.');
          },
        ));
  }
}
