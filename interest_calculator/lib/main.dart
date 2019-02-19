import "package:flutter/material.dart";

void main() {

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Simple Interest Calculator",
      home: SIForm(),
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
        accentColor: Colors.blueGrey[800],
        brightness: Brightness.dark
      ),
    )
  );

}

class SIForm extends StatefulWidget
{

  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }

}

class _SIFormState extends State<SIForm>
{

  var formKey = GlobalKey<FormState>();

  var currencies = ["RM", "USD", "SGD", "Others"];
  var currentSelectedItem;

  @override
  void initState() {
    super.initState();
    currentSelectedItem = currencies[0];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  var displayResult = "";

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
//      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Interest calculator"),
//        backgroundColor: Colors.blueGrey
      ),

      body: Form(
        key: formKey,
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListView(
              children: <Widget>[

                getAssetImage(),

                Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: principalController, // untuk nk dapat user input
                    validator: (String value) { // kalau user tk letak input
                      if(value.isEmpty)
                        return "Please enter principal amount";
                    },
                    decoration: InputDecoration(
                        labelText: "Principal",
                        hintText: "Enter principle",
                        labelStyle: textStyle,
                        errorStyle: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 15.0
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: roiController,
                    validator: (String value) {
                      if(value.isEmpty)
                        return "Please enter interest";
                    },
                    decoration: InputDecoration(
                        labelText: "Rate of interest",
                        hintText: "In percent",
                        labelStyle: textStyle,
                        errorStyle: TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 15.0
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: Row(
                    children: <Widget>[

                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: textStyle,
                          controller: termController,
                          validator: (String value) {
                            if(value.isEmpty)
                              return "Please enter term";
                          },
                          decoration: InputDecoration(
                              labelText: "Term",
                              hintText: "Time in years",
                              labelStyle: textStyle,
                              errorStyle: TextStyle(
                                  color: Colors.yellowAccent,
                                  fontSize: 15.0
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)
                              )
                          ),
                        ),
                      ),

                      Container(width: 25.0),

                      Expanded(
                        child: DropdownButton<String>(
                          items: currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),

                          value: currentSelectedItem,

                          onChanged: (String newValueSelected) {
                            onDropDownItemSelected(newValueSelected);
                          },

                        ),
                      )

                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: Row(
                    children: <Widget>[

                      Expanded(
                        child: RaisedButton(
                          child: Text("Calculate", textScaleFactor: 1.5,), // 1.5 = 50% increase
                          color: Theme.of(context).accentColor,
                          textColor: Theme.of(context).primaryColorDark,
                          onPressed: () {
                            setState(() {
                              if(formKey.currentState.validate()) {
                                this.displayResult = calculateTotalReturns();
                              }
                            });
                          },
                        ),
                      ),

                      Expanded(
                        child: RaisedButton(
                          child: Text("Reset", textScaleFactor: 1.5,),
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          onPressed: () {
                            setState(() {
                              reset();
                            });
                          },
                        ),
                      )

                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(this.displayResult, style: textStyle,),
                )

              ],
            )
        ),
      ),
    );

  }

  Widget getAssetImage() {

    AssetImage assetImage = AssetImage("images/money.png");
    Image image = Image(image: assetImage, height:  125.0, width: 125.0);

    return Container(child: image, margin: EdgeInsets.all(50.0),);

  }

  void onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this.currentSelectedItem = newValueSelected;
    });
  }

  String calculateTotalReturns() {

    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principal * (principal * roi * term) / 100;

    String result = "After $term years, your investment will be worth $totalAmountPayable $currentSelectedItem";
    return result;
  }

  void reset() {
    debugPrint("masuk reset");
    principalController.text = "";
    roiController.text = "";
    termController.text = "";
    displayResult = "";
    currentSelectedItem = currencies[0];

    debugPrint("displayResult: " + displayResult);
  }

}