class CompanyModel {
  String? id,
      address,
      whatsapp_number,
      phone_number,
      company_email,
      stable_version,
      company_account_name,
      company_account_number,
      paystack_api_key,
      bank;
  CompanyModel(
      {this.id,
      this.address,
      this.whatsapp_number,
      this.phone_number,
      this.company_email,
      this.stable_version,
      this.company_account_name,
      this.company_account_number,
      this.paystack_api_key,
      this.bank});
  factory CompanyModel.fromJSON(Map<String, dynamic> company) {
    return CompanyModel(
        id: company['id'],
        address: company['address'],
        whatsapp_number: company['whatsapp_number'],
        phone_number: company['phone_number'],
        company_email: company['company_email'],
        stable_version: company['stable_version'],
        company_account_name: company["company_account_name"],
        company_account_number: company["company_account_number"],
        paystack_api_key: company["paystack_api_key"],
        bank: company['bank']);
  }
}
