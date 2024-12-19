import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:piwotapp/responses/Stall_Response.dart';
import '../../repository/api_repo.dart';

class StallPage extends StatefulWidget {
  const StallPage({super.key});

  @override
  _StallPageState createState() => _StallPageState();
}

class _StallPageState extends State<StallPage> {
  List<Data> stallList = [];
  List<Data> filteredStalls = [];  // This will hold the filtered list
  TextEditingController _controller = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchStallList();
  }



  fetchStallList() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No internet connection')),
      );
    } else {
      setState(() {
        isLoading = true;
      });
      await Future.delayed(Duration(seconds: 2)); // Simulating delay
      var response = await ApiRepo().getStallListResponse();

      setState(() {
        isLoading = false;
        stallList = response.data ?? [];  // Ensure this is populated
        filteredStalls = List.from(stallList);  // Initially, the filtered list is the same as the full list
      });

      // Debugging output to check if the data is correct
      print("Stall List: ${stallList.map((e) => e.stallNo).toList()}");  // Check stallNo values
    }
  }

  // Method to filter the list based on the search query
  void _filterStalls(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredStalls = List.from(stallList);  // Reset to full list if query is empty
      });
    } else {
      setState(() {
        filteredStalls = stallList.where((stall) {
          // Check if the stallNo or stallName contains the query (case-insensitive)
          return stall.stallNo!.toLowerCase().contains(query.toLowerCase()) ||
              stall.stallName!.toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 16),
              child: TextField(
                controller: _controller,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Search Stall Number',
                  prefixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                    borderSide: BorderSide(
                      color: Colors.grey, // Color of the border
                      width: 1,           // Border width
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                    borderSide: BorderSide(
                      color: Colors.grey, // Border color when the TextField is enabled
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                    borderSide: BorderSide(
                      color: Colors.blue, // Border color when the TextField is focused
                      width: 1,
                    ),
                  ),
                ),
                onChanged: (value) {
                  _filterStalls(value);  // Filter the stalls as the user types
                },
              ),
            ),


            isLoading
                ? Center(child: CircularProgressIndicator()) // Loading indicator
                : filteredStalls.isEmpty
                ? Center(child: Text('No stalls available')) // Empty data
                : Expanded(
              child: Column(
                children: [
                  // Top row for Stall No and Stall Name headers
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      padding: EdgeInsets.all(12.0),  // Padding inside the container for spacing
                      decoration: const BoxDecoration(
                        color: Color(0xFF1B1464),  // Background color for the header
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Stall No text
                          Text(
                            'Stall No',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,  // Text color matching the border
                            ),
                          ),
                          SizedBox(width: 38),  // Space between Stall No and Stall Name
                          // Stall Name text
                          Align(
                            alignment: Alignment.centerLeft, // Aligns the text to the left
                            child: Text(
                              'Stall Name',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,  // Text color matching the border
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  // ListView for displaying stalls
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredStalls.length,
                      itemBuilder: (context, index) {
                        final stall = filteredStalls[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Column(
                            children: [
                              // Stall No and Stall Name Row with Start Margin
                              Padding(
                                padding: const EdgeInsets.only(left: 39.0), // Adding left margin
                                child: Row(
                                  children: [
                                    // Stall No
                                    Text(
                                      stall.stallNo ?? 'N/A',  // Display 'N/A' if null
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    SizedBox(width: 60), // Space between Stall No and Stall Name
                                    // Stall Name
                                    Expanded(
                                      child :Align(
                                        alignment: Alignment.centerLeft, // Aligns the text to the left
                                        child: Text(
                                        stall.stallName ?? 'N/A',  // Display 'N/A' if null
                                        style: TextStyle(fontSize: 14),
                                        overflow: TextOverflow.ellipsis, // Handle long names
                                      ),
                                    ),),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,  // Divider thickness
                                color: Colors.black,  // Divider color
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),



          ],
        ),
      ),
    );
  }
}

