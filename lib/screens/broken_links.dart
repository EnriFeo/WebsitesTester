import 'package:flutter/material.dart';
import 'package:website_tester/models/models.dart';
import 'package:website_tester/utils/utils.dart';
import 'package:website_tester/widgets/app_bar.dart';

class BrokenLinks extends StatefulWidget {
  String _url = "";
  bool _isLoading = false;
  bool _isError = false;

  List<UrlOk> _results = [];

  String? _noBrokenLinks;

  BrokenLinks({super.key});

  @override
  State<BrokenLinks> createState() => _BrokenLinksState();
}

class _BrokenLinksState extends State<BrokenLinks> {
  void setUrl(final String newurl) {
    setState(() {
      widget._url = newurl;
    });
  }

  void setLoading() {
    setState(() {
      widget._isLoading = !widget._isLoading;
    });
  }

  void setResults(List<UrlOk> results) {
    setState(() {
      widget._results = results;
    });
  }

  void setError() {
    setState(() {
      widget._isError = !widget._isError;
    });
  }

  void setNoBrokenLinks(String? url) {
    setState(() {
      widget._noBrokenLinks = url;
    });
  }

  void goButtonOnPressed() async {
    if (widget._url.isNotEmpty) {
      if (widget._noBrokenLinks != null) {
        setNoBrokenLinks(null);
      }
      print(widget._url);
      setLoading();
      try {
        setResults(await Requests.getBrokenLinks(widget._url));
        if (widget._results.isEmpty) {
          setNoBrokenLinks(widget._url);
        }
      } catch (e) {
        setError();
      }
      setLoading();
      print("fatto");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.5, horizontal: 30.2),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomWidget(isListEmpty: widget._results.isEmpty, children: [
                SizedBox(
                  width: 1000.0,
                  child: TextFormField(
                    initialValue: widget._url,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter url',
                    ),
                    onChanged: (e) => setUrl(e.characters.string),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: widget._isLoading
                      ? const /*Image(
                          image: AssetImage('assets/images/loading.gif'),
                          width: 35.0,
                        )*/
                          CircularProgressIndicator()
                      : TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                          ),
                          onPressed: () async => goButtonOnPressed(),
                          child: const Text('vai'),
                        ),
                )
              ]),
              widget._results.isNotEmpty && !widget._isError
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: widget._results.length,
                          itemBuilder: (context, index) => ListTile(
                            title: Text(widget._results[index].url),
                            subtitle: Text(
                                widget._results[index].statusCode.toString()),
                            onTap: () {
                              print("tappato");
                            },
                          ),
                        ),
                      ),
                    )
                  : Container(
                      child:
                          widget._isError ? const Text("Errore") : Container(),
                    ),
              (widget._noBrokenLinks != null)
                  ? Text(
                      "il sito ${widget._noBrokenLinks} non contiene link rotti!")
                  : (widget._results.isNotEmpty)
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            onPressed: () async {
                              setUrl(
                                await GenerateReport.run(
                                    widget._url, widget._results),
                              );
                            },
                            child: const Text("Generate Report"),
                          ),
                        )
                      : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomWidget extends StatelessWidget {
  final bool isListEmpty;
  final List<Widget> children;

  const CustomWidget(
      {required this.isListEmpty, required this.children, super.key});

  @override
  Widget build(BuildContext context) {
    return isListEmpty
        ? Column(
            children: [...children],
          )
        : Row(
            children: [...children],
          );
  }
}
