import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/quet_controller.dart';

class ResP extends StatelessWidget {
  const ResP({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.blueGrey,
        child: Consumer<QuoteCntroller>(builder: (context, pro, child) {
          return pro.preferredQuotes.isNotEmpty
              ? CarouselSlider.builder(
                  itemCount: pro.preferredQuotes.length,
                  itemBuilder: (context, index, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 26),
                          child: Text(
                            pro.preferredQuotes[index]['content'],
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 12.0,
                          ),
                          child: Text(
                            '~${pro.preferredQuotes[index]['author']}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    );
                  },
                  options: CarouselOptions(
                      scrollDirection: Axis.vertical,
                      pageSnapping: true,
                      initialPage: 0,
                      enlargeCenterPage: true,
                      onPageChanged: (index, value) {
                        // log('${windex}');
                      }),
                )
              : CarouselSlider.builder(
                  itemCount: pro.quotes.length,
                  itemBuilder: (context, index, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 26),
                          child: Text(
                            pro.quotes[index]['content'],
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 12.0,
                          ),
                          child: Text(
                            '~${pro.quotes[index]['author']}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    );
                  },
                  options: CarouselOptions(
                      scrollDirection: Axis.vertical,
                      pageSnapping: true,
                      initialPage: 0,
                      enlargeCenterPage: true,
                      onPageChanged: (index, value) {
                        // log('${windex}');
                      }),
                );
        }),
      ),
    );
  }
}
// class ResP extends StatelessWidget {
//   const ResP({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         color: Colors.blueGrey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("Response"),
//             Consumer<PixaController>(builder: (context, pixa, child) {
//               return Expanded(
//                 child: ListView.builder(
//                     itemCount: pixa.abstract.length,
//                     itemBuilder: (context, index) {
//                       return ClipRRect(
//                         borderRadius: BorderRadius.circular(16),
//                         child: StreamBuilder<
//                                 DocumentSnapshot<Map<String, dynamic>>>(
//                             stream: FBSHelper.fbsHelper.fetchPurchesed(),
//                             builder: (context, snapshot) {
//                               List background =
//                                   snapshot.data?.data()?['images'] ?? [];
//                               return GestureDetector(
//                                 onLongPress: () async {
//                                   print('starting.....');
//                                   await FBSHelper.fbsHelper.updatePurchesed(
//                                       imageUrl: pixa.abstract[index]
//                                           ['largeImageURL']);
//                                   AwesomeDialog(
//                                     context: context,
//                                     autoHide: const Duration(seconds: 2),
//                                     dialogType: DialogType.success,
//                                     animType: AnimType.scale,
//                                     title: 'Success',
//                                     body: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Column(
//                                         children: [
//                                           ClipRRect(
//                                             borderRadius:
//                                                 BorderRadius.circular(16),
//                                             child: Container(
//                                               width: size.width * 0.35,
//                                               child: Image.network(
//                                                 '${pixa.abstract[index]['largeImageURL']}',
//                                                 fit: BoxFit.cover,
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(height: size.height * 0.020),
//                                           const Text('Background Added'),
//                                         ],
//                                       ),
//                                     ),
//                                   ).show();
//                                 },
//                                 child: Image.network(
//                                   '${pixa.abstract[index]['largeImageURL']}',
//                                   fit: BoxFit.cover,
//                                 ),
//                               );
//                             }),
//                       );
//                     }),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }
