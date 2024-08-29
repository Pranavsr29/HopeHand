import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Add this import
import 'package:charity_app/Controllers/firebase_auth_controller.dart';
import 'package:charity_app/Views/Utils/Components/charity_post.dart';
import 'package:charity_app/Views/Utils/Styles/app_colors.dart';
import 'package:charity_app/Views/Utils/Styles/text_styles.dart';
import 'Notifications.dart';
import 'kyc_page.dart'; // Import the KycPage

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseController firebaseController = Get.put(FirebaseController());
  bool isKycCompleted = false; // Flag to check if KYC is completed

  List<Map<String, String>> charityEvents = [
    {
      'image': 'https://plus.unsplash.com/premium_photo-1681490220097-cf6f188196e4?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'title': 'FutureBright Foundation: Empowering Children\'s Education',
      'id': 'FutureBright Foundation',
      'time': '2024-07-05 - 12:56',
      'feedName': 'Charity Event 1',
      'shortDescription': 'FutureBright Foundation: Illuminating Paths to Education for Every Child.',
      'detailedDescription': 'The FutureBright Foundation is a beacon of hope for children worldwide, committed to unlocking the transformative power of education. With unwavering dedication, we strive to eradicate barriers that hinder learning, ensuring every child has equitable access to quality education. Through innovative programs, collaborative partnerships, and grassroots initiatives, we empower young minds to dream big and achieve their full potential. Our vision extends beyond classrooms, fostering holistic development and equipping future generations with the skills and knowledge to thrive in a rapidly evolving world. Together, we are building a brighter tomorrow where every child can shine, creating lasting impacts that ripple through communities and generations to come.'
    },
    {
      'image': 'https://plus.unsplash.com/premium_photo-1683141170766-017bf7a2ecb4?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8ZG9uYXRpb258ZW58MHx8MHx8fDA%3D',
      'title': 'Unity Volunteers: Connecting Hearts, Changing Lives',
      'id': 'Unity Volunteers',
      'time': '2024-07-06 - 15:30',
      'feedName': 'Charity Event 2',
      'shortDescription': 'Unity Volunteers: Bringing together passionate individuals to make a meaningful difference through collective action.',
      'detailedDescription': '"Unity Volunteers" is a vibrant community-driven charity dedicated to mobilizing individuals who share a passion for making a positive impact. By harnessing the collective power of volunteers, we strive to address diverse social challenges and promote community well-being. Our comprehensive programs offer opportunities for individuals to contribute their time, skills, and compassion towards meaningful causes, from local initiatives to global efforts. Through collaborative partnerships and empowering initiatives, we cultivate a culture of empathy, service, and solidarity, fostering lasting change and creating a brighter, more inclusive world for all. Join us in transforming aspirations into action, as together, we build stronger, more connected communities where everyone thrives.'
    },
    {
      'image': 'https://plus.unsplash.com/premium_photo-1661274147223-116687829d26?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8b2xkJTIwYWdlJTIwaG9tZXxlbnwwfHwwfHx8MA%3D%3D',
      'title': 'Golden Years Haven: Embracing Elders with Dignity',
      'id': 'Golden Years Haven',
      'time': '2024-07-07 - 18:00',
      'feedName': 'Charity Event 3',
      'shortDescription': 'Golden Years Haven provides dignified care and community for elderly residents.',
      'detailedDescription': 'Golden Years Haven is a cherished refuge designed to honor and support the elderly in every aspect of their lives. Nestled within our serene environment, residents experience a blend of attentive care, companionship, and personalized services tailored to their individual needs. Our dedicated team of caregivers, trained in geriatric care and compassion, ensures a nurturing atmosphere where residents feel valued and cherished. We prioritize holistic well-being through enriching activities, health management, and social engagement, fostering a sense of purpose and fulfillment. At Golden Years Haven, we embrace the wisdom and legacy of our residents, creating a vibrant community where each person is celebrated and supported in their journey through life\'s later stages.'
    },
    {
      'image': 'https://plus.unsplash.com/premium_photo-1663127644755-edefeedc2d49?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'title': 'Paws and Hearts Animal Sanctuary',
      'id': 'Paws and Hearts',
      'time': '2024-07-08 - 14:00',
      'feedName': 'Charity Event 4',
      'shortDescription': 'Paws and Hearts Sanctuary: Sheltering animals with care and compassion.',
      'detailedDescription': 'Paws and Hearts Animal Sanctuary stands as a beacon of hope and compassion for animals in challenging circumstances. Our sanctuary serves as a loving refuge where abandoned, abused, and neglected animals receive dedicated care, rehabilitation, and the chance for a new beginning. With a committed team of caregivers and volunteers, we provide tailored support to each resident, focusing on their physical, emotional, and social needs. Through community education, outreach programs, and adoption initiatives, we advocate for responsible pet ownership and foster deep connections between animals and their forever families. At Paws and Hearts, we are driven by a belief in the inherent dignity of every animal and strive to create a brighter future where all creatures are valued, cherished, and respected.'
    },
    {
      'image': 'https://plus.unsplash.com/premium_photo-1661488538787-3028c44f0612?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8c29jaWFsJTIwanVzdGljZSUyMCU1Q3xlbnwwfHwwfHx8MA%3D%3D',
      'title': 'Equal Rights Initiative: Promoting Justice and Fairness for All',
      'id': 'Equal Rights Initiative',
      'time': '2024-07-09 - 10:00',
      'feedName': 'Charity Event 5',
      'shortDescription': 'Equal Rights Initiative advocates for justice and fairness, ensuring equal rights for all individuals.',
      'detailedDescription': 'The Equal Rights Initiative is committed to upholding justice and fairness as fundamental principles in society. We tirelessly advocate for the rights of marginalized and vulnerable communities, working to eliminate discrimination and ensure equal opportunities for all individuals. Through proactive legal advocacy, impactful policy initiatives, and robust community engagement programs, we seek to address systemic inequities and promote a society where everyone can thrive. Our efforts are rooted in the belief that justice should be accessible to all, regardless of race, ethnicity, gender, sexual orientation, or socioeconomic status. Together, we strive to build a more just and inclusive world where every person\'s rights are protected and respected.'
    },
  ];

  Future<void> _refresh() async {
    // Simulate a network request or any other refresh logic
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      // Optionally update your data here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        title: Text(
          'Hope Hand',
          style: CustomTextStyles.appBarWhiteSmallStyle,
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  // Navigate to NotificationsPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NotificationsPage()),
                  );
                },
                icon: Icon(
                  Icons.notifications,
                  color: AppColors.whiteColor,
                ),
              ),
              Positioned(
                right: 11,
                top: 11,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              firebaseController.logOut();
              Get.snackbar('Success', 'User Logout Successfully');
            },
            icon: Icon(
              Icons.logout,
              color: AppColors.whiteColor,
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                _buildStartFundraiserCard(),
                if (isKycCompleted) _buildNewCharityCard(),
                ...charityEvents.map((event) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: CharityPost(
                        imagePath: event['image']!,
                        title: event['title']!,
                        charityID: event['id']!,
                        time: event['time']!,
                        feedName: event['feedName']!,
                        shortDescription: event['shortDescription']!,
                        detailedDescription: event['detailedDescription']!,
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStartFundraiserCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () async {
          // Navigate to KycPage and await the result
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const KycPage()),
          );
          if (result == true) {
            setState(() {
              isKycCompleted = true;
            });
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.add_circle_outline,
                  size: 40,
                  color: AppColors.themeColor,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start Your Own Fundraiser',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.themeColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Create your own fundraiser to support a cause you care about.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewCharityCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          // Show popup for new charity details
          _showNewCharityDialog(context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.edit,
                  size: 40,
                  color: AppColors.themeColor,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'New Charity Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.themeColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Fill in the details about the new charity you want to create.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showNewCharityDialog(BuildContext context) {
  final _charityNameController = TextEditingController();
  final _charityDescriptionController = TextEditingController();
  final _charityImageUrlController = TextEditingController();
  final _charityBeneficiaryController = TextEditingController();
  final _charityGoalAmountController = TextEditingController();
  final _charityContactController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('New Charity Details'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _charityNameController,
                  decoration: InputDecoration(labelText: 'Charity Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the charity name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _charityDescriptionController,
                  decoration: InputDecoration(labelText: 'Charity Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the charity description';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _charityImageUrlController,
                  decoration: InputDecoration(labelText: 'Charity Image URL'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the charity image URL';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _charityBeneficiaryController,
                  decoration: InputDecoration(labelText: 'Beneficiary'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the beneficiary';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _charityGoalAmountController,
                  decoration: InputDecoration(labelText: 'Goal Amount'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the goal amount';
                    }
                    final number = int.tryParse(value);
                    if (number == null || number < 10000) {
                      return 'Goal amount must be above 10,000';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _charityContactController,
                  decoration: InputDecoration(labelText: 'Contact Information'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the contact information';
                    }
                    if (value.length != 10 || int.tryParse(value) == null) {
                      return 'Phone number must be 10 digits';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _submitCharityDetails(
                  name: _charityNameController.text,
                  description: _charityDescriptionController.text,
                  imageUrl: _charityImageUrlController.text,
                  beneficiary: _charityBeneficiaryController.text,
                  goalAmount: _charityGoalAmountController.text,
                  contact: _charityContactController.text,
                );
                Navigator.of(context).pop();
                _showSubmissionConfirmation(context);
              }
            },
            child: Text('Submit'),
          ),
        ],
      );
    },
  );
}

void _submitCharityDetails({
  required String name,
  required String description,
  required String imageUrl,
  required String beneficiary,
  required String goalAmount,
  required String contact,
}) async {
  CollectionReference charities = FirebaseFirestore.instance.collection('charities');
  await charities.add({
    'name': name,
    'description': description,
    'imageUrl': imageUrl,
    'beneficiary': beneficiary,
    'goalAmount': goalAmount,
    'contact': contact,
  });
}

void _showSubmissionConfirmation(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Submission Received'),
        content: Text('Thank you for submitting your fundraiser details. We will review your submission and get back to you shortly.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
}