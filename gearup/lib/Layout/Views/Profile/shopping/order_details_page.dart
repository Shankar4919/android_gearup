import 'package:e_commers/Models/Response/response_order_details.dart';
import 'package:e_commers/Service/product_services.dart';
import 'package:e_commers/service/urls.dart';
import 'package:e_commers/Layout/widgets/shimmer_gearup.dart';
import 'package:e_commers/Layout/widgets/widgets.dart';
import 'package:flutter/material.dart';

class OrderDetailsPage extends StatelessWidget {
  final String uidOrder;

  const OrderDetailsPage({Key? key, required this.uidOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const TextGearUp(
            text: 'Order Detail',
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          splashRadius: 20,
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<List<OrderDetail>>(
            future: productServices.getOrderDetails(uidOrder),
            builder: (context, snapshot) => !snapshot.hasData
                ? const ShimmerGearUp()
                : _ListOrderDetails(orderDetails: snapshot.data!)),
      ),
    );
  }
}

class _ListOrderDetails extends StatelessWidget {
  final List<OrderDetail> orderDetails;

  const _ListOrderDetails({Key? key, required this.orderDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.builder(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            itemCount: orderDetails.length,
            itemBuilder: (context, i) => Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        child: TextGearUp(
                            text: orderDetails[i].nameProduct.toUpperCase(),
                            fontSize: 19,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 15.0),
                    Row(
                      children: [
                        SizedBox(
                            height: 90,
                            width: 90,
                            child: Image.network(
                                URLS.baseUrl + orderDetails[i].picture)),
                        const SizedBox(width: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextGearUp(
                              text: 'Price: \Rs. ${orderDetails[i].price}',
                              fontSize: 20,
                            ),
                            const SizedBox(height: 5.0),
                            TextGearUp(
                                text: 'Quantity: ${orderDetails[i].quantity}',
                                fontSize: 20),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
