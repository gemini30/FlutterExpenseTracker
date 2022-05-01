// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './models/palette.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // MaterialColor createMaterialColor(Color color) {
  //   List strengths = <double>[.05];
  //   Map<int, Color> swatch = {};
  //   final int r = color.red, g = color.green, b = color.blue;

  //   for (int i = 1; i < 10; i++) {
  //     strengths.add(0.1 * i);
  //   }
  //   for (var strength in strengths) {
  //     final double ds = 0.5 - strength;
  //     swatch[(strength * 1000).round()] = Color.fromRGBO(
  //       r + ((ds < 0 ? r : (255 - r)) * ds).round(),
  //       g + ((ds < 0 ? g : (255 - g)) * ds).round(),
  //       b + ((ds < 0 ? b : (255 - b)) * ds).round(),
  //       1,
  //     );
  //   }
  //   return MaterialColor(color.value, swatch);
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: createMaterialColor(Color(0xFF174378)),
          // primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 17,
              )),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                      headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String titleInput;

  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 5999.00,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Grocery',
    //   amount: 345.89,
    //   date: DateTime.now(),
    // )
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: [
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
