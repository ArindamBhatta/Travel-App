import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/common/utils/google_login_provider.dart';
import 'package:travel_app/features/user_contribution_page/specific_user_read_contribution.dart';
import 'contribution_from.dart';

class UserContributionPage extends StatefulWidget {
  @override
  State<UserContributionPage> createState() => _UserContributionPageState();
}

class _UserContributionPageState extends State<UserContributionPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? location;
  String? state;
  String? country;
  String? imageUrl;
  String? description;
  String? userUid;
  CollectionReference? collectionRefOfContributor;
  CollectionReference? userContributionPath;
  DocumentReference? userNewDocumentReference;
  DocumentReference? referenceOfaParticularUser;

  //* Loading UI
  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text(
                  'Submission in progress. Please wait...',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // upload data in fireStore onTap
  void submitFormAndUploadDataInFireStore() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      _showLoadingDialog(); //* Show the loading dialog

      try {
        referenceOfaParticularUser =
            FirebaseFirestore.instance.collection('users').doc(userUid);

        collectionRefOfContributor = FirebaseFirestore.instance
            .collection('/destinations/contributor/data');

        collectionRefOfContributor?.add(
          {
            'id': collectionRefOfContributor?.id,
            'location': location,
            'state': state,
            'country': country,
            'imageUri': imageUrl,
            'description': description,
            'userRef': referenceOfaParticularUser,
          },
        );

        userNewDocumentReference = await FirebaseFirestore.instance
            .collection('users/$userUid/contributions')
            .add(
          {
            'myContribution': collectionRefOfContributor,
          },
        );

        Navigator.of(context).pop();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Form submitted successfully!',
            ),
          ),
        );

        formKey.currentState!.reset();
      } catch (error) {
        print('error is coming from firebase $error');
        Navigator.of(context).pop(); //* Close the loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to submit form: $error',
            ),
          ),
        );
      }
    }
  }

  void bottomSheetForPostDetails() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, //* Allows the modal to take more space
      builder: (modalBottomSheetContext) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.60,
          maxChildSize: 0.60,
          minChildSize: 0.60,
          builder: (context, scrollController) {
            //* User Post method is trigger from hear
            return ContributionForm(
              globalKey: formKey,
              onTapToSaveFormData: (
                String? location,
                String? state,
                String? country,
                String? imageUrl,
                String? description,
              ) {
                this.location = location;
                this.state = state;
                this.country = country;
                this.imageUrl = imageUrl;
                this.description = this.description;
                submitFormAndUploadDataInFireStore();
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    userUid = context.watch<GoogleLoginProvider>().userAccessToken;
    userContributionPath =
        FirebaseFirestore.instance.collection('users/$userUid/contributions');
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'My Contribution',
          ),
        ),
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: userContributionPath?.snapshots(),
              builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'unable to fetch data right now, try again later .',
                    ),
                  );
                } else if (snapshot.hasData) {
                  final List<QueryDocumentSnapshot> allPostReference =
                      snapshot.data!.docs;

                  return Expanded(
                    child: ListView.builder(
                      itemCount: allPostReference.length,
                      itemBuilder: (context, index) {
                        final individualPostReference =
                            allPostReference[index].data();
                        if (individualPostReference != null) {
                          Map<String, dynamic> jsonData =
                              individualPostReference as Map<String, dynamic>;
                          final reference = jsonData['myContribution'];
                          DocumentReference path =
                              reference as DocumentReference;

                          return SpecificUserReadContribution(
                            userSpecificPost: path,
                          );
                        }
                        return null;
                      },
                    ),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('No user  upload their views'),
                  );
                } else {
                  return Center(
                    child: Text("something Happen"),
                  );
                }
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 20.0,
        onPressed: () {
          bottomSheetForPostDetails();
        },
        child: Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
