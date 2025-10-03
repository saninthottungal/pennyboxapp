class TnxQuery {
  TnxQuery._();

  //* GET
  static String get getAccounts => 'SELECT * FROM accounts';
  static String get getTransactionTypes => 'SELECT * FROM transaction_types';
  static String get getParties => 'SELECT * FROM parties WHERE name LIKE ?';

  static String get getAccountBalances {
    return '''

SELECT AC.id, AC.name as account_name, 
coalesce(SUM(CASE WHEN TXNTYPE.kind = 'Income'  
THEN TXN.amount ELSE 0
 END),0) -
coalesce(SUM(CASE WHEN TXNTYPE.kind != 'Income' 
THEN TXN.amount ELSE 0
 END),0) 
 AS balance,

coalesce(SUM(CASE WHEN TXNTYPE.kind = 'Income' 
AND TXN.transaction_at <=strftime('%Y-%m-%dT%H:%M:%fZ', 'now') 
 THEN TXN.amount ELSE 0 END),0) - 
 coalesce(SUM(CASE WHEN TXNTYPE.kind != 'Income' 
 AND TXN.transaction_at <=strftime('%Y-%m-%dT%H:%M:%fZ', 'now') 
 THEN TXN.amount ELSE 0 END),0)
 AS actual_balance

FROM accounts AS AC
LEFT OUTER JOIN
transactions AS TXN
ON AC.id = TXN.account_id
LEFT OUTER JOIN
transaction_types AS TXNTYPE
ON TXNTYPE.id = TXN.transaction_type_id
GROUP BY AC.id;

''';
  }

  static String getTransactions({
    required int? limit,
    required bool isPlanned,
  }) {
    final timeOperatorClause = isPlanned ? '>' : '<=';

    return '''
SELECT * FROM
(
SELECT

T.id AS id,
T.amount AS amount,
T.transaction_at AS transaction_at,
T.description AS description,
AC.id AS account_id,
AC.name AS account_name,
TY.id AS transaction_type_id,
TY.kind AS transaction_type,
P.id AS party_id,
P.name AS party_name,
NULL AS transferred_to_account_id,
NULL AS transferred_to_account_name

FROM transactions AS T
INNER JOIN
accounts AS AC
ON AC.id = T.account_id
INNER JOIN
transaction_types AS TY
ON TY.id = T.transaction_type_id
LEFT OUTER JOIN
parties AS P
ON P.id = T.party_id

WHERE T.transfer_id IS NULL

UNION ALL

SELECT
T.transfer_id AS id,
min(T.amount) AS amount,
min(T.transaction_at) AS transaction_at,
min(T.description) AS description,
min(CASE WHEN TY.kind = 'Expense' THEN AC.id ELSE NULL END) AS account_id,
min(CASE WHEN TY.kind = 'Expense' THEN AC.name ELSE NULL END) AS account_name,

3 AS transaction_type_id,
'Transfer' AS transaction_type,
NULL AS party_id,
NULL AS party_name,
min(CASE WHEN TY.kind = 'Income' THEN AC.id ELSE NULL END) AS transferred_to_account_id,
min(CASE WHEN TY.kind = 'Income' THEN AC.name  ELSE NULL END) AS transferred_to_account_name

FROM transactions AS T
INNER JOIN 
accounts AS AC
ON AC.id = T.account_id
INNER JOIN
transaction_types AS TY
ON TY.id = T.transaction_type_id

WHERE T.transfer_id IS NOT NULL
GROUP BY transfer_id
) 

WHERE transaction_at $timeOperatorClause (strftime('%Y-%m-%dT%H:%M:%f', 'now') || 'Z')
ORDER BY transaction_at DESC
${limitClause(limit)};
''';
  }

  static String get getSingleTransaction {
    return '''
SELECT * FROM
(
SELECT

T.id AS id,
T.amount AS amount,
T.transaction_at AS transaction_at,
T.description AS description,
AC.id AS account_id,
AC.name AS account_name,
TY.id AS transaction_type_id,
TY.kind AS transaction_type,
P.id AS party_id,
P.name AS party_name,
NULL AS transferred_to_account_id,
NULL AS transferred_to_account_name

FROM transactions AS T
INNER JOIN
accounts AS AC
ON AC.id = T.account_id
INNER JOIN
transaction_types AS TY
ON TY.id = T.transaction_type_id
LEFT OUTER JOIN
parties AS P
ON P.id = T.party_id

WHERE T.transfer_id IS NULL

UNION ALL

SELECT
T.transfer_id AS id,
min(T.amount) AS amount,
min(T.transaction_at) AS transaction_at,
min(T.description) AS description,
min(CASE WHEN TY.kind = 'Expense' THEN AC.id ELSE NULL END) AS account_id,
min(CASE WHEN TY.kind = 'Expense' THEN AC.name ELSE NULL END) AS account_name,

3 AS transaction_type_id,
'Transfer' AS transaction_type,
NULL AS party_id,
NULL AS party_name,
min(CASE WHEN TY.kind = 'Income' THEN AC.id ELSE NULL END) AS transferred_to_account_id,
min(CASE WHEN TY.kind = 'Income' THEN AC.name  ELSE NULL END) AS transferred_to_account_name

FROM transactions AS T
INNER JOIN 
accounts AS AC
ON AC.id = T.account_id
INNER JOIN
transaction_types AS TY
ON TY.id = T.transaction_type_id

WHERE T.transfer_id IS NOT NULL
GROUP BY transfer_id
) 

WHERE id = ?
ORDER BY transaction_at DESC

''';
  }

  //* POST
  static String get addAccount => 'INSERT INTO accounts (name) Values (?)';
  static String get deleteAccount => 'DELETE FROM accounts WHERE id = ?';
  static String get addParty => 'INSERT INTO parties (name) VALUES (?)';
  static String get deleteParty => 'DELETE FROM parties WHERE id = ?';
  static String get deleteTnxOnId => 'DELETE FROM transactions WHERE id = ?';
  static String get deleteTnxOnTransferId =>
      'DELETE FROM transactions WHERE transfer_id = ?';

  static String get addTransaction {
    return '''
INSERT INTO transactions 
(
description,
amount,
transaction_at,
account_id, 
transaction_type_id,
party_id,
transfer_id
) 
VALUES 
(
?,
?,
?,
?,
?,
?,
?
);
''';
  }

  //* Helper Methods
  static String limitClause(int? limit) {
    if (limit == null || limit == 0) return '';
    return 'LIMIT $limit';
  }
}
