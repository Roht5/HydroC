import 'package:ambulance_tracker/Components/title_description_richtext.dart';
import 'package:ambulance_tracker/screens/driver/driver_information.dart';
import 'package:ambulance_tracker/screens/driver/driver_page.dart';
import 'package:flutter/material.dart';

class CurrentPatientWorking extends StatefulWidget {
  const CurrentPatientWorking({Key? key}) : super(key: key);

  @override
  State<CurrentPatientWorking> createState() => _CurrentPatientWorkingState();
}

class _CurrentPatientWorkingState extends State<CurrentPatientWorking> {
  bool isAvailable = false;
  bool isFree = false;
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 4),
    () => 'Data Loaded',
  );
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displayMedium!,
      textAlign: TextAlign.center,
      child: FutureBuilder<String>(
        future: _calculation, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              isWorking
                  ? Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color:
                                      const Color.fromARGB(255, 241, 236, 212)),
                              child: const Text(
                                "Working: ",
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color:
                                      const Color.fromARGB(255, 241, 232, 232)),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TitleDescriptionRichText('Current Patent: ',
                                        patientName.toString()),
                                    Image.network(
                                        "https://www.zyrgon.com/wp-content/uploads/2019/06/googlemaps-Zyrgon.jpg"),
                                    TitleDescriptionRichText(
                                        'Address: ', patientAddress.toString())
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : Image.network(
                      "https://img.freepik.com/free-vector/lazy-raccoon-sleeping-cartoon_125446-631.jpg?size=338&ext=jpg")
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              ),
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }
}

class CurrentPatient extends StatelessWidget {
  const CurrentPatient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isWorking
        ? Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: const Color.fromARGB(255, 241, 236, 212)),
                    child: const Text(
                      "Working: ",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: const Color.fromARGB(255, 241, 232, 232)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TitleDescriptionRichText(
                              'Current Patent:', "Siddhi Ambavnne"),
                          Image.network(
                              "https://www.zyrgon.com/wp-content/uploads/2019/06/googlemaps-Zyrgon.jpg"),
                          TitleDescriptionRichText('Address: ', "Address")
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        : Image.network(
            "https://img.freepik.com/free-vector/lazy-raccoon-sleeping-cartoon_125446-631.jpg?size=338&ext=jpg");
  }
}
