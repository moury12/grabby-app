class BankDetailsModel {
  final String? bankName;
  final String? routingNumber;
  final String? accountNumberLast4;
  final String? accountHolderName;
  final String? currency;

  BankDetailsModel({
    this.bankName,
    this.routingNumber,
    this.accountNumberLast4,
    this.accountHolderName,
    this.currency,
  });

  factory BankDetailsModel.fromJson(Map<String, dynamic> json) {
    return BankDetailsModel(
      bankName: json['bankName'] as String?,
      routingNumber: json['routingNumber'] as String?,
      accountNumberLast4: json['accountNumberLast4'] as String?,
      accountHolderName: json['accountHolderName'] as String?,
      currency: json['currency'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bankName': bankName,
      'routingNumber': routingNumber,
      'accountNumberLast4': accountNumberLast4,
      'accountHolderName': accountHolderName,
      'currency': currency,
    };
  }
}

class StripeConnectStatusModel {
  final String? stripeAccountId;
  final bool stripeAccountConnected;
  final String? stripeAccountStatus;
  final BankDetailsModel? bankDetails;

  StripeConnectStatusModel({
    this.stripeAccountId,
    required this.stripeAccountConnected,
    this.stripeAccountStatus,
    this.bankDetails,
  });

  factory StripeConnectStatusModel.fromJson(Map<String, dynamic> json) {
    return StripeConnectStatusModel(
      stripeAccountId: json['stripeAccountId'] as String?,
      stripeAccountConnected: json['stripeAccountConnected'] as bool? ?? false,
      stripeAccountStatus: json['stripeAccountStatus'] as String?,
      bankDetails: json['bankDetails'] != null
          ? BankDetailsModel.fromJson(
              json['bankDetails'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stripeAccountId': stripeAccountId,
      'stripeAccountConnected': stripeAccountConnected,
      'stripeAccountStatus': stripeAccountStatus,
      'bankDetails': bankDetails?.toJson(),
    };
  }
}

class StripeOnboardingLinkModel {
  final String url;
  final String? stripeAccountId;
  final bool stripeAccountConnected;
  final String? stripeAccountStatus;

  StripeOnboardingLinkModel({
    required this.url,
    this.stripeAccountId,
    required this.stripeAccountConnected,
    this.stripeAccountStatus,
  });

  factory StripeOnboardingLinkModel.fromJson(Map<String, dynamic> json) {
    return StripeOnboardingLinkModel(
      url: json['url'] as String? ?? '',
      stripeAccountId: json['stripeAccountId'] as String?,
      stripeAccountConnected: json['stripeAccountConnected'] as bool? ?? false,
      stripeAccountStatus: json['stripeAccountStatus'] as String?,
    );
  }
}
