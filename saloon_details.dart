import 'package:flutter/material.dart';
import 'package:pet_plus_new/model/grooming_model.dart';

class SalonDetailScreen extends StatelessWidget {
  final GroomingSalon salon;

  const SalonDetailScreen({Key? key, required this.salon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(salon.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSlider(),
            _buildInfoSection(),
            _buildServicesSection(),
            _buildGroomersSection(),
            _buildReviewsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSlider() {
    return Container(
      height: 200,
      child: PageView.builder(
        itemCount: salon.photos.length,
        itemBuilder: (context, index) {
          return Image.asset(
            salon.photos[index],
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }

  Widget _buildInfoSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Information',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Address: ${salon.address}'),
          Text('Phone: ${salon.phone}'),
          Text('Website: ${salon.website}'),
        ],
      ),
    );
  }

  Widget _buildServicesSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Services & Pricing',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ...salon.services.entries.map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(e.key),
                  Text('Rs ${(e.value * 290).toStringAsFixed(2)}'), // Assuming 1 USD = 82.5 INR
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroomersSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Our Groomers',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: salon.groomers.length,
            itemBuilder: (context, index) {
              final groomer = salon.groomers[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(groomer.image),
                ),
                title: Text(groomer.name),
                subtitle: Text(groomer.specialization),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reviews',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: salon.reviews.length,
            itemBuilder: (context, index) {
              final review = salon.reviews[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            review.userName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 8),
                          Row(
                            children: List.generate(
                              5,
                              (index) => Icon(
                                Icons.star,
                                size: 16,
                                color: index < review.rating
                                    ? Colors.amber
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(review.comment),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}