import 'package:fillogo/views/rotas_view/components/rotasCard.dart';

import '../../export.dart';

class RotasView extends StatelessWidget {
  const RotasView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGenel(
        title: Text(
          'Benim Rotalarım',
          style: TextStyle(
              fontFamily: 'Sfsemibold',
              color: AppConstants().ltLogoGrey,
              fontSize: 28),
        ),
        leading: const SizedBox(),
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.4), BlendMode.dstATop),
              image: const AssetImage(
                'assets/images/world-bg-1.png',
              ),
              fit: BoxFit.fitHeight),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const DummyBox15(),
              const DummyBox15(),
              SizedBox(
                height: Get.height,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () =>
                          Get.toNamed(NavigationConstants.previousRotas),
                      child: Column(
                        children: [
                          RotasCard(
                            isActive: true,
                            onPress: () {},
                            name: 'Ankara - Samsun',
                            km: '409 km',
                          ),
                          RotasCard(
                            isActive: false,
                            onPress: () {},
                            name: 'İstanbul - Ankara',
                            km: '450 km',
                          ),
                          RotasCard(
                            isActive: false,
                            onPress: () {},
                            name: 'İstanbul - Samsun',
                            km: '656 km',
                          ),
                          RotasCard(
                            isActive: false,
                            onPress: () {},
                            name: 'İzmir - Ankara',
                            km: '755 km',
                          ),
                          RotasCard(
                            isActive: false,
                            onPress: () {},
                            name: 'Antalya - Yozgat',
                            km: '236 km',
                          ),
                          RotasCard(
                            isActive: false,
                            onPress: () {},
                            name: 'Erzurum - Çankırı',
                            km: '752 km',
                          ),
                          RotasCard(
                            isActive: false,
                            onPress: () {},
                            name: 'Çanakkale - İzmir',
                            km: '320 km',
                          ),
                          RotasCard(
                            isActive: false,
                            onPress: () {},
                            name: 'Balıkesir - Malatya',
                            km: '432 km',
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
