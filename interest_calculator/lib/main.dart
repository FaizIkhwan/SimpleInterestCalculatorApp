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

  var currencies = ["RM", "USD", "SGD", "Others"];

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
//      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Interest calculator"),
//        backgroundColor: Colors.blueGrey
      ),

      body: Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[

            getAssetImage(),

            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: TextField(
                keyboardType: TextInputType.number,
                style: textStyle,
                decoration: InputDecoration(
                    labelText: "Principal",
                    hintText: "Enter principle",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: TextField(
                keyboardType: TextInputType.number,
                style: textStyle,
                decoration: InputDecoration(
                    labelText: "Rate of interest",
                    hintText: "In percent",
                    labelStyle: textStyle,
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
                    child: TextField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      decoration: InputDecoration(
                          labelText: "Term",
                          hintText: "Time in years",
                          labelStyle: textStyle,
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

                      value: currencies[0],

                      onChanged: (String newValueSelected) {
                        // CODE
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
                        // CODE
                      },
                    ),
                  ),

                  Expanded(
                    child: RaisedButton(
                      child: Text("Reset", textScaleFactor: 1.5,),
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      onPressed: () {
                        // CODE
                      },
                    ),
                  )

                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Todo text", style: textStyle,),
            )

          ],
        ),
      ),

    );

  }

  Widget getAssetImage() {

    AssetImage assetImage = AssetImage("images/money.png");
    Image image = Image(image: assetImage, height:  125.0, width: 125.0);

    return Container(child: image, margin: EdgeInsets.all(50.0),);

  }

}