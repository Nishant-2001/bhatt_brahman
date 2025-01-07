import 'package:Bhatt_Brahman_Var_Vadhu/constants/instance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_constant.dart';
import '../../constants/dimensions.dart';
import '../../constants/text_style.dart';
import '../../controller/recent_join_controller.dart';
import '../../model/recent_join_model.dart';
import 'newly_joined_detail_page.dart';

class NewlyJoinedPage extends StatefulWidget {
  const NewlyJoinedPage({super.key});

  @override
  State<NewlyJoinedPage> createState() => _NewlyJoinedPageState();
}

class _NewlyJoinedPageState extends State<NewlyJoinedPage> {
  final RecentJoinController _controller = RecentJoinController();
  late Future<RecentJoinResponse?> _recentJoinsFuture;

  @override
  void initState() {
    super.initState();
    _recentJoinsFuture = _controller.fetchRecentJoins();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.appMainColor,
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        iconTheme: const IconThemeData(color: Color(0xffffffff)),
        title: Padding(
          padding: const EdgeInsets.only(top: 7.0),
          child: Text(
            "Newly Joined",
            style: customTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xffffffff)),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/Vector.png',
              height: 24,
              width: 24,
            ),
          ),
          const Icon(
            Icons.notifications_outlined,
            size: 28,
          ),
          width(15),
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              width: Get.width * 0.9,
              height: Get.height * 0.015,
              decoration: BoxDecoration(
                color: const Color(0xffffffff).withOpacity(.50),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: Get.width,
              decoration: const BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: FutureBuilder<RecentJoinResponse?>(
                future: _recentJoinsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
                    return const Center(
                        child: Text('No newly joined profiles.'));
                  }

                  final users = snapshot.data!.data;

                  return ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];

                      return GestureDetector(
                        onTap: () {
                          viewProfileController.openProfilePage(user.id);
                          Get.to(() => NewlyJoinedDetailPage(user: user));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff9C9C9C)),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: user.profileImg != null
                                  ? NetworkImage(user.profileImg!)
                                  : AssetImage(user.userType == "Groom"
                                      ? 'assets/groom.jpg'
                                      : 'assets/bride.jpg') as ImageProvider,
                            ),
                            title: Text(
                              "${user.firstName} ${user.lastName}" ?? 'No Name',
                              style: customTextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${user.dob != null ? _calculateAge(user.dob!) : 'N/A'} Yrs | ${user.height ?? 'N/A'} cm",
                                  style: customTextStyle(
                                      color: const Color(0xff686D76)),
                                ),
                                width(3),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.work_outline_outlined,
                                      color: Color(0xffE8461C),
                                      size: 18,
                                    ),
                                    width(3),
                                    Text(
                                      user.profession != null
                                          ? "${user.profession!.split(' ').first}..."
                                          : 'N/A',
                                      style: customTextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xff686D76),
                                      ),
                                    ),
                                  ],
                                ),
                                width(3),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      color: Color(0xffE8461C),
                                      size: 18,
                                    ),
                                    width(4),
                                    Text(
                                      "${user.nativePlace?.split(' ').first}..." ??
                                          'N/A',
                                      style: customTextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xff686D76),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _calculateAge(String dob) {
    final birthDate = DateTime.parse(dob);
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age.toString();
  }
}
