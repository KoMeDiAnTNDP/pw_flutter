import 'package:pw_flutter/helper/enums/enums.dart';
import 'package:pw_flutter/helper/models/models.dart';
import 'package:pw_flutter/helper/http/http_client.dart';

const Map<String, String> URLS = {
  'TRANSACTIONS': 'api/protected/transactions',
};

class TransactionsRepository {
  final HttpClient _httpClient = HttpClient();

  Future<Transaction> createTransaction(String name, double amount) async {
    try {
      final transaction = await _httpClient.makeRequest<Transaction>(
        Method.POST,
        URLS['TRANSACTIONS']!,
        body: { 'name': name, 'amount': amount }
      );

      return transaction;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<List<Transaction>> getTransactions() async {
    try {
      final transactions = await _httpClient.makeRequest<List<Transaction>>(
        Method.GET,
        URLS['TRANSACTIONS']!,
      );

      return transactions;
    } catch (error) {
      throw Exception(error);
    }
  }
}
