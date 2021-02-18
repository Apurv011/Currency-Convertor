import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'networking.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

final fixedUrl = 'ttps://free.currconv.com/api/v7/convert';

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency1 = 'USD';
  String selectedCurrency2 = 'INR';
  String conversion = '?';
  bool showSpinner = false;

  List<DropdownMenuItem> getCurrencyList() {
    List<DropdownMenuItem<String>> ls = [];

    for (String currency in currenciesList) {
      var curr = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      ls.add(curr);
    }
    return ls;
  }

  Future<void> updateUI() async {
    NetworkHelper networkHelper = NetworkHelper(
        '$fixedUrl?q=${selectedCurrency1}_$selectedCurrency2&compact=ultra&apiKey=9eef8a74ce38e0e80496');
    var data = await networkHelper.getData();
    double doubleConversion = data['${selectedCurrency1}_$selectedCurrency2'];
    setState(() {
      conversion = doubleConversion.toStringAsFixed(1);
      showSpinner = false;
    });
  }

  @override
  void initState() {
    super.initState();
    updateUI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
        backgroundColor: Color(0xFF323348),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Color(0xFF323348),
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 $selectedCurrency1 = $conversion $selectedCurrency2',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 150.0,
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 30.0),
                color: Color(0xFF323348),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton<String>(
                      value: selectedCurrency1,
                      items: getCurrencyList(),
                      dropdownColor: Color(0xFF323348),
                      onChanged: (value) {
                        setState(() {
                          selectedCurrency1 = value;
                        });
                      },
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    DropdownButton<String>(
                      value: selectedCurrency2,
                      items: getCurrencyList(),
                      dropdownColor: Color(0xFF323348),
                      onChanged: (value) {
                        setState(() {
                          selectedCurrency2 = value;
                          showSpinner = true;
                          updateUI();
                        });
                      },
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
