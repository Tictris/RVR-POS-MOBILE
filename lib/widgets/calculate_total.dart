import 'package:flutter/material.dart';
import 'calculate/rates.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _controllerAdult = TextEditingController();
  final TextEditingController _controllerSenior = TextEditingController();
  final TextEditingController _controllerChild = TextEditingController();

  final TextEditingController _controllerUmbrella = TextEditingController();
  final TextEditingController _controllerCottage = TextEditingController();
  final TextEditingController _controllerTent = TextEditingController();

  double _total = 0;
  double _adultCost = 0;
  double _seniorCost = 0;
  double _childCost = 0;
  
  int _umbrellaCost = 0;
  int _cottageCost = 0;
  int _tentCost = 0;

  Future<void> calculateSum() async {

    int adultCount = int.tryParse(_controllerAdult.text) ?? 0;
    int seniorCount = int.tryParse(_controllerSenior.text) ?? 0;
    int childCount = int.tryParse(_controllerChild.text) ?? 0;
    int umbrellaCount = int.tryParse(_controllerUmbrella.text) ?? 0;
    int cottageCount = int.tryParse(_controllerCottage.text) ?? 0;
    int tentCount = int.tryParse(_controllerTent.text) ?? 0;
      try {
    final rateFetcher = RateFetcher();
    final rateData = await rateFetcher.fetchRates();
    final cottageRateFetcher = CottageRateFetcher();
    final cottageRateData = await cottageRateFetcher.fetchRates();

    // Access the rates
    double adultRate = rateData.adultRate;
    double childRate = rateData.childRate;
    double seniorRate = rateData.seniorRate;

    //Access cottage rates
    int tent = cottageRateData.tent;
    int cottage = cottageRateData.cottage;
    int umbrella = cottageRateData.umbrella;

  setState(() {
      _adultCost = adultCount * adultRate;
      _seniorCost = seniorCount * seniorRate;
      _childCost = childCount * childRate;
      _umbrellaCost = umbrellaCount * umbrella;
      _cottageCost = cottageCount * cottage;
      _tentCost = tentCount * tent;
      _total = _adultCost +
          _seniorCost +
          _childCost +
          _umbrellaCost +
          _cottageCost +
          _tentCost;
      debugPrint("it works");
    });
  } catch (e) {
    debugPrint('Error fetching rates: $e');
  }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(40, 20, 0, 0),
              child: SizedBox(
                  width: 300,
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(labelText: "Name"),
                  )),
            ),
          ],
        ),
        const Row(
          children: [
            SizedBox(
              width: 230,
            ),
            Text(
              "Sub Total",
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
        Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
              child: Column(
                children: [
                  const Text(
                    "Adult",
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: TextField(
                      controller: _controllerAdult,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        calculateSum();
                      },
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 80,
            ),
            Text(
              "$_adultCost",
              style: const TextStyle(fontSize: 40),
            )
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
              child: Column(
                children: [
                  const Text(
                    "Senior",
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: TextField(
                      controller: _controllerSenior,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        calculateSum();
                      },
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 80,
            ),
            Text(
              "$_seniorCost",
              style: const TextStyle(fontSize: 40),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
              child: Column(
                children: [
                  const Text(
                    "Children",
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: TextField(
                      controller: _controllerChild,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        calculateSum();
                      },
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 80,
            ),
            Text(
              "$_childCost",
              style: const TextStyle(fontSize: 40),
            )
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Column(
                children: [
                  const Text(
                    "Umbrella",
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: TextField(
                      controller: _controllerUmbrella,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        calculateSum();
                      },
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Column(
              children: [
                const Text(
                  "Cottage",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  width: 40,
                  height: 40,
                  child: TextField(
                    controller: _controllerCottage,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      calculateSum();
                    },
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                )
              ],
            ),
            const SizedBox(
              width: 40,
            ),
            Column(
              children: [
                const Text(
                  "Tent",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  width: 40,
                  height: 40,
                  child: TextField(
                    controller: _controllerTent,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      calculateSum();
                    },
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                )
              ],
            ),
          ],
        ),
        const Text(
          "Total",
          style: TextStyle(fontSize: 40),
        ),
        Text(
          "$_total",
          style: const TextStyle(fontSize: 40),
        ),
            ],
          )
        ),
      ],
    ),
    );
  }
}
