import 'package:flutter/material.dart';
import '../../HexColor/hexColor.dart' show HexColor;

class BillSplitter extends StatefulWidget {
  const BillSplitter({Key? key}) : super(key: key);

  @override
  State<BillSplitter> createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  // Create variable
  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmount = 0.0;
  final Color _purple = HexColor('#6908D6'); // color code pass
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(20.5),
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  color: _purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Total Per Person',
                        style: TextStyle(
                            color: _purple,
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal)),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                          '\$${calculateTotalPerPerson(_billAmount, _personCounter, _tipPercentage)}',
                          style: TextStyle(
                              color: _purple,
                              fontSize: 34.9,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                    color: Colors.grey.shade100, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                children: [
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 17.9,
                        fontWeight: FontWeight.w500),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.attach_money),
                        prefixText: ('Bill Amount : ')),
                    onChanged: (String value) {
                      try {
                        _billAmount = double.parse(value);
                      } catch (exception) {
                        _billAmount = 0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Split',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_personCounter > 1) {
                                  _personCounter--;
                                } else {}
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: _purple.withOpacity(0.1),
                              ),
                              child: Center(
                                child: Text(
                                  '-',
                                  style: TextStyle(
                                      color: _purple,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            '$_personCounter',
                            style: TextStyle(
                                color: _purple,
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _personCounter++;
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: _purple.withOpacity(0.1),
                              ),
                              child: Center(
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                      color: _purple,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tip',
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold)),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                            '\$${calculateTotalTip(_billAmount, _personCounter, _tipPercentage)}',
                            style: TextStyle(
                                color: _purple,
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text('$_tipPercentage%',
                          style: TextStyle(
                              color: _purple,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold)),
                      Slider(
                          max: 100,
                          min: 0,
                          activeColor: _purple,
                          inactiveColor: Colors.grey,
                          divisions: 10,
                          value: _tipPercentage.toDouble(),
                          onChanged: (double newValue) {
                            setState(() {
                              _tipPercentage = newValue.round();
                            });
                          })
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

// this is calculate program methods this method received required four parameters
  calculateTotalTip(double billAmount, int person, int totaltip) {
    double totalResult = 0.0;
    if (billAmount < 0 || billAmount.toString().isEmpty || billAmount == 0) {
    } else {
      totalResult = (billAmount * totaltip) / 100;
    }
    return totalResult.toStringAsFixed(2);
  }

  calculateTotalPerPerson(double billAmount, int person, int totaltip) {
    double result =
        double.parse(calculateTotalTip(billAmount, person, totaltip)) +
            billAmount / person;
    return result.toStringAsFixed(2);
  }
}
