import 'dart:convert';

XenditCheckPaymentResponse xenditCheckPaymentResponseFromJson(String str) => XenditCheckPaymentResponse.fromJson(json.decode(str));

String xenditCheckPaymentResponseToJson(XenditCheckPaymentResponse data) => json.encode(data.toJson());

class XenditCheckPaymentResponse {
  XenditCheckPaymentResponse({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  int code;
  bool status;
  String message;
  PaymentData data;

  factory XenditCheckPaymentResponse.fromJson(Map<String, dynamic> json) => XenditCheckPaymentResponse(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    data: PaymentData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class PaymentData {
  PaymentData({
    required this.id,
    required this.externalId,
    required this.userId,
    required this.status,
    required this.merchantName,
    required this.merchantProfilePictureUrl,
    required this.amount,
    required this.payerEmail,
    required this.description,
    required this.expiryDate,
    required this.invoiceUrl,
    required this.availableBanks,
    required this.availableRetailOutlets,
    required this.availableEwallets,
    required this.availableQrCodes,
    required this.availableDirectDebits,
    required this.availablePaylaters,
    required this.shouldExcludeCreditCard,
    required this.shouldSendEmail,
    required this.created,
    required this.updated,
    required this.currency,
  });

  String id;
  String externalId;
  String userId;
  String status;
  String merchantName;
  String merchantProfilePictureUrl;
  int amount;
  String payerEmail;
  String description;
  DateTime expiryDate;
  String invoiceUrl;
  List<AvailableBank> availableBanks;
  List<dynamic> availableRetailOutlets;
  List<AvailableEwallet> availableEwallets;
  List<AvailableQrCode> availableQrCodes;
  List<dynamic> availableDirectDebits;
  List<AvailablePaylater> availablePaylaters;
  bool shouldExcludeCreditCard;
  bool shouldSendEmail;
  DateTime created;
  DateTime updated;
  String currency;

  factory PaymentData.fromJson(Map<String, dynamic> json) => PaymentData(
    id: json["id"],
    externalId: json["external_id"],
    userId: json["user_id"],
    status: json["status"],
    merchantName: json["merchant_name"],
    merchantProfilePictureUrl: json["merchant_profile_picture_url"],
    amount: json["amount"],
    payerEmail: json["payer_email"],
    description: json["description"],
    expiryDate: DateTime.parse(json["expiry_date"]),
    invoiceUrl: json["invoice_url"],
    availableBanks: List<AvailableBank>.from(json["available_banks"].map((x) => AvailableBank.fromJson(x))),
    availableRetailOutlets: List<dynamic>.from(json["available_retail_outlets"].map((x) => x)),
    availableEwallets: List<AvailableEwallet>.from(json["available_ewallets"].map((x) => AvailableEwallet.fromJson(x))),
    availableQrCodes: List<AvailableQrCode>.from(json["available_qr_codes"].map((x) => AvailableQrCode.fromJson(x))),
    availableDirectDebits: List<dynamic>.from(json["available_direct_debits"].map((x) => x)),
    availablePaylaters: List<AvailablePaylater>.from(json["available_paylaters"].map((x) => AvailablePaylater.fromJson(x))),
    shouldExcludeCreditCard: json["should_exclude_credit_card"],
    shouldSendEmail: json["should_send_email"],
    created: DateTime.parse(json["created"]),
    updated: DateTime.parse(json["updated"]),
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "external_id": externalId,
    "user_id": userId,
    "status": status,
    "merchant_name": merchantName,
    "merchant_profile_picture_url": merchantProfilePictureUrl,
    "amount": amount,
    "payer_email": payerEmail,
    "description": description,
    "expiry_date": expiryDate.toIso8601String(),
    "invoice_url": invoiceUrl,
    "available_banks": List<dynamic>.from(availableBanks.map((x) => x.toJson())),
    "available_retail_outlets": List<dynamic>.from(availableRetailOutlets.map((x) => x)),
    "available_ewallets": List<dynamic>.from(availableEwallets.map((x) => x.toJson())),
    "available_qr_codes": List<dynamic>.from(availableQrCodes.map((x) => x.toJson())),
    "available_direct_debits": List<dynamic>.from(availableDirectDebits.map((x) => x)),
    "available_paylaters": List<dynamic>.from(availablePaylaters.map((x) => x.toJson())),
    "should_exclude_credit_card": shouldExcludeCreditCard,
    "should_send_email": shouldSendEmail,
    "created": created.toIso8601String(),
    "updated": updated.toIso8601String(),
    "currency": currency,
  };
}

class AvailableBank {
  AvailableBank({
    required this.bankCode,
    required this.collectionType,
    required this.transferAmount,
    required this.bankBranch,
    required this.accountHolderName,
    required this.identityAmount,
  });

  String bankCode;
  String collectionType;
  int transferAmount;
  String bankBranch;
  String accountHolderName;
  int identityAmount;

  factory AvailableBank.fromJson(Map<String, dynamic> json) => AvailableBank(
    bankCode: json["bank_code"],
    collectionType: json["collection_type"],
    transferAmount: json["transfer_amount"],
    bankBranch: json["bank_branch"],
    accountHolderName: json["account_holder_name"],
    identityAmount: json["identity_amount"],
  );

  Map<String, dynamic> toJson() => {
    "bank_code": bankCode,
    "collection_type": collectionType,
    "transfer_amount": transferAmount,
    "bank_branch": bankBranch,
    "account_holder_name": accountHolderName,
    "identity_amount": identityAmount,
  };
}

class AvailableEwallet {
  AvailableEwallet({
    required this.ewalletType,
  });

  String ewalletType;

  factory AvailableEwallet.fromJson(Map<String, dynamic> json) => AvailableEwallet(
    ewalletType: json["ewallet_type"],
  );

  Map<String, dynamic> toJson() => {
    "ewallet_type": ewalletType,
  };
}

class AvailablePaylater {
  AvailablePaylater({
    required this.paylaterType,
  });

  String paylaterType;

  factory AvailablePaylater.fromJson(Map<String, dynamic> json) => AvailablePaylater(
    paylaterType: json["paylater_type"],
  );

  Map<String, dynamic> toJson() => {
    "paylater_type": paylaterType,
  };
}

class AvailableQrCode {
  AvailableQrCode({
    required this.qrCodeType,
  });

  String qrCodeType;

  factory AvailableQrCode.fromJson(Map<String, dynamic> json) => AvailableQrCode(
    qrCodeType: json["qr_code_type"],
  );

  Map<String, dynamic> toJson() => {
    "qr_code_type": qrCodeType,
  };
}
