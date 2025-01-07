import 'package:get/get.dart';

import '../views/pages/accepted_interest_page.dart';
import '../views/pages/expressed_interest_page.dart';
import '../views/pages/newly_joined_page.dart';
import '../views/pages/viewed_profile_page.dart';

List<String> bannerUrl = [
  "https://i.pinimg.com/736x/0f/a5/19/0fa51923bbdf89d77f030e496d586837.jpg",
  "https://dnyandeepvadhuvar.com/images/gunmilap.png",
  "https://www.pothunalam.com/wp-content/uploads/2023/04/thirumanam-patriya-kanavu-palangal-in-tamil-1.jpg",
  "https://media.dailythanthi.com/h-upload/2024/05/07/1620568-chennai-02.webp",
  "https://enewz.in/wp-content/uploads/2023/02/FEA-47-1.jpg",
  "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiBxp2FgIzjn6MAKp0R84elvy7SuOE2faIonsD7fYUXw2urFAmI-AAHmZbgZKrphzGN1dy7vGDjVnSXLYmffmjotuJB7D0xrz1AZ186C6nc2Kqd36Dyz3i7CfNdXiyxywuGf1Evr2W5nAL3/s1600/1608743438232372-0.png",
];

List categoryData = [
  {
    "image": "assets/category1.png",
    "name": "My\n Interests",
    "onTap": () => Get.to(() => const AcceptedInterestPage())
  },
  {
    "image": "assets/category2.png",
    "name": "Expressed \ntheir Interest",
    "onTap": () => Get.to(() => ExpressedInterestPage())
  },
  {
    "image": "assets/category3.png",
    "name": "Viewed \nyour Profile",
    "onTap": () => Get.to(() => const ViewedProfilePage())
  },
  {
    "image": "assets/category4.png",
    "name": "Newly \nJoined",
    "onTap": () => Get.to(() => const NewlyJoinedPage())
  },
];
