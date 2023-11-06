import 'package:flutter/material.dart';
import 'package:app_infants/data/mock_data.dart';
import 'package:app_infants/screens/product_details.dart';
import 'package:app_infants/screens/profile_screen.dart';

class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({Key? key}) : super(key: key);

  @override
  _ProductsListScreenState createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: MockData.mockProducts.length,
      vsync: this,
    );
  }

  void searchProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredProducts = [];
      } else {
        filteredProducts = MockData.mockProducts
            .map((category) {
          final categoryProducts = category['products'] as List<Map<String, dynamic>>;
          return categoryProducts
              .where((product) {
            final productName = product['name'].toString().toLowerCase();
            return productName.contains(query);
          })
              .toList();
        })
            .expand((products) => products)
            .toList();
      }
    });
  }

  void showProductDetails(Map<String, dynamic> product, String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(
          product: product,
          imageAsset: getCategoryImage(product['name']),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: MockData.mockProducts.length,
      child: Scaffold(
      appBar: AppBar(
      title: Row(
      children: [
      Image.asset(
      'assets/logo.png',
      height: 40,
    ),
    const Expanded(
    flex: 1,
    child: Text("BORCELLE KIDS STORE"),
    ),
    ],
    ),
    backgroundColor: Colors.pink,
    actions: [
    IconButton(
    icon: const Icon(Icons.notifications),
    onPressed: () {
    // Handle notification button tap
    },
    ),
    IconButton(
    icon: const Icon(Icons.shopping_cart),
    onPressed: () {
    // Handle shopping cart button tap
    },
    ),
    ],
    bottom: PreferredSize(
    preferredSize: const Size.fromHeight(56.0),
    child: Container(
    margin: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8.0),
    ),
    child: TextField(
    controller: _searchController,
    onChanged: (value) {
    searchProducts();
    },
    style: const TextStyle(color: Colors.black),
    decoration: const InputDecoration(
    hintText: 'Search Products',
    hintStyle: TextStyle(
    color: Colors.black,
    fontSize: 16.0,
    ),
    prefixIcon: Icon(Icons.search, color: Colors.black),
    border: InputBorder.none,
    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
    ),
    ),
    ),
    ),
    ),
    body: Column(
    children: <Widget>[
    Container(
    color: Colors.white10,
    child: TabBar(
    controller: _tabController,
    isScrollable: true,
    indicator: const UnderlineTabIndicator(
    borderSide: BorderSide(width: 3, color: Colors.black),
    ),
    labelColor: Colors.black,
    tabs: MockData.mockProducts
        .map((category) => Container(
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8.0),
    color: Colors.pinkAccent,
    ),
    child: Tab(
    child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
    category['category'] as String,
    style: const TextStyle(color: Colors.white),
    ),
    ),
    ),
    ))
        .toList(),
    ),
    ),
    Expanded(
    child: TabBarView(
    controller: _tabController,
    children: filteredProducts.isEmpty
    ? MockData.mockProducts.map((category) {
    final categoryName = category['category'] as String;
    final categoryProducts =
    category['products'] as List<Map<String, dynamic>>;
    final imageAsset = getCategoryImage(categoryName);

    // Sort products alphabetically by name
    categoryProducts.sort((a, b) => a['name'].compareTo(b['name']));

    return SingleChildScrollView(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
    categoryName,
    style: const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    fontFamily: 'ChildishFont',
    color: Colors.black38,
    ),
    ),
    ),
    GridView.builder(
    shrinkWrap: true,
    physics:
    const NeverScrollableScrollPhysics(),
    gridDelegate:
    const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 0.55,
    ),
    itemCount: categoryProducts.length,
    itemBuilder: (BuildContext context, int index) {
    final product = categoryProducts[index];
    final productName = product['name'] as String;
    final productPrice = product['price'] as double;

    return FadeInAnimation(
    child: GestureDetector(
    onTap: () {
    showProductDetails(product, categoryName);
    },
    child: Card(
    elevation: 4,
    color: Colors.white,
    child: Column(
    crossAxisAlignment:
    CrossAxisAlignment.start,
    children: <Widget>[
    AspectRatio(
    aspectRatio: 1,
    child: Image(
    image: getCategoryImage(productName),
    fit: BoxFit.cover,
    ),
    ),
    Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
    crossAxisAlignment:
    CrossAxisAlignment.start,
    children: [
    Text(
    productName,
    style: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    fontFamily: 'ChildishFont',
    color: Colors.pink,
    ),
    ),
    Row(
    mainAxisAlignment:
    MainAxisAlignment
        .spaceBetween,
    children: [
    Text(
    '\$$productPrice',
    style: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    fontFamily: 'ChildishFont',
    color: Colors.pink,
    ),
    ),
    const Icon(
    Icons.add,
    color: Colors.pink,
    ),
    const Icon(
    Icons.favorite_border,
    ),
    ],
    ),
    ],
    ),
    ),
    ],
    ),
    ),
    ),
    );
    },
    ),
    ],
    ),
    );
  }).toList()
      : const <Widget>[
  Center(
  child: Text(
  'No Results Found',
  style: TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: Colors.red,
  ),
  ),
  ),
  ],
  ),
  ),
  ],
  ),
  bottomNavigationBar: BottomAppBar(
  color: Colors.pink,
  child: Row(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: [
  Column(
  mainAxisSize: MainAxisSize.min,
  children: [
  IconButton(
  icon: const Icon(Icons.store),
  onPressed: () {
  // Handle store button tap
  },
  ),
  const Text('Store'),
  ],
  ),
  Column(
  mainAxisSize: MainAxisSize.min,
  children: [
  IconButton(
  icon: const Icon(Icons.shopping_cart),
  onPressed: () {
  // Handle cart button tap
  },
  ),
  const Text('Cart'),
  ],
  ),
  Column(
  mainAxisSize: MainAxisSize.min,
  children: [
  IconButton(
  icon: const Icon(Icons.favorite),
  onPressed: () {
  // Handle favorite button tap
  },
  ),
  const Text('Favorite'),
  ],
  ),
  Column(
  mainAxisSize: MainAxisSize.min,
  children: [
  IconButton(
  icon: const Icon(Icons.account_circle),
  onPressed: () {
  // Handle profile button tap
  Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const UserProfileScreen()),
  );
  },
  ),
  const Text('Profile'),
  ],
  ),
  ],
  ),
  ),
  ),
  );
}

AssetImage getCategoryImage(String productName) {
  // Replace with your logic to map product names to images
  // You can use a map or any other method to map product names to image paths
  Map<String, String> productImages = {
    "High Chair Tray Cover": "assets/high_chair_tray_cover.jpg",
    "Diaper Rash Cream":"assets/Diaper_Rash_Cream.jpg",
    "Diaper Bags": "assets/3_in_1_Baby_Stroller_and_Troller_Set.webp",
    "Disposable Diaper Liners": "assets/5_in_1_Unique_Baby_body_Suits.webp",
    "Diaper Pails": "assets/5Pcs_Baby_weaning_Spoons.jpg",
    "Diaper Changing Pads": "assets/98-degree-digital-bottle-warmer.jpg",
    "Diaper Caddies": "assets/100_cotton_toddler_bedding_set.webp",
    "Swim Diapers": "assets/Adjustable_Nursing_pillow.webp",
    "Diaper Fasteners": "assets/anging_swing_dor_toddlers.jpg",
    "Rattles": "assets/Animal_Soft_Building_Blocks.webp",
    "Stuffed Animals": "assets/Anti_kick_newborn_Swaddle_Blanket.jpg",
    "Building Blocks": "assets/asda_little_angels_baby_lotion.jpg",
    "Musical Mobiles": "assets/Austrailian_Native_Animal_Wall_Decal_Set.jpeg",
    "Baby Teethers": "assets/Automatic_Electric_Breast_pumps.jpeg",
    "Activity Gyms": "assets/Babies_Nursing_Pillows.jpeg",
    "Soft Plush Toys": "assets/Baby's_Year.jpg",
    "Educational Toys": "assets/bath_thermometer.jpg",
    "Sensory Toys": "assets/Baby_bottle_Drying_rack.jpeg",
    "Baby Mirrors": "assets/Baby_brush_and_comb_set.jpeg",
    "Baby Bottles": "assets/Baby_Dog_print_pyjama_set.webp",
    "Bottle Warmers": "assets/Baby_Einstein_Discovery_Play_Development_Gift_Set.jpg",
    "Breast Pumps": "assets/Baby_Feeding_Plate_set.webp",
    "Bottle Sterilizers": "assets/Baby_Girl_Swimwear.jpg",
    "Baby Bibs": "assets/Baby_Girls_Tights.jpg",
    "Bottle Brushes": "assets/Baby_Handprint_Kit.jpg",
    "Nursing Pillow": "assets/Baby_Lamb_Stuffed_Animal.jpeg",
    "Baby Feeding Spoons": "assets/Baby_Nasal_Aspirator_with_3_level_suction_and_music.jpeg",
    "Formula Dispensers": "assets/Baby_Nursing_Cover_and_Nursing_Poncho.jpg",
    "Sippy Cups": "assets/Baby_sensory_toys_gift_box.png",
    //NEW START
    // Images for Clothes category
    "Onesies": "assets/Baby_Shoulder_Carrier_Baby_Hiking_Backpack_Carrier_with_Rain_Cover.jpeg",
    "Baby Socks": "assets/Baby_Toddler_Snack_Catcher_Double_Handle.jpeg",
    "Baby Hats": "assets/Baby_Wrap_Carrier_and_Ring_Sling.jpeg",
    "Baby Shoes": "assets/Backseat_Baby_Mirror_for_Rear-Facing_Child.jpeg",
    "Baby Pajamas": "assets/Bamboo_Toodler_Bowls.jpeg",
    "Baby Mittens": "assets/Bany_chubby_Super_Soft_Cat_Soft_Toy_Big_Eyes_Doll.jpeg",
    "Baby Bodysuits": "assets/Baybee_Baby_Rocker_and_Bouncer_with_Soothing_Vibrations.webp",
    "Baby Rompers": "assets/Baybee_Stainless_Steel_Baby_Spoon_set.jpeg",
    "Baby Leggings": "assets/beachfront-baby-water-ring-sling-white-wavewater-carrier.jpg",
    "Baby Outerwear": "assets/Beco_Soleil_Soft_Structured_Baby_Carrier.jpeg",

    // Images for Bath and Skin Care category
    "Baby Shampoo": "assets/blue-charms-organic-baby-bibs-set-of-3.jpg",
    "Baby Wash": "assets/BOBBY-Automated-Baby-Bouncer-For-Modern-Parents.webp",
    "Baby Towels": "assets/Bright_Starts_Comfy_Baby_Bouncer_Soothing_Vibration_Infant_Seat.jpg",
    "Baby Lotion": "assets/Carters_cotton_sateen_fitted_crib_sheets.jpeg",
    "Baby Bath Tubs": "assets/Casual_Wear_Set_Of_24_Piecies_Cute_Baby_Sunglasses.webp",
    "Baby Bath Thermometers": "assets/Cool_touch_Waterproof_Mattresas_and_Pillow.jpeg",
    "Baby Bath Robes": "assets/copper-pearl-grace-change-pad-cover.jpg",
    "Baby Nail Clippers": "assets/Cot_Musical_Mobile.jpeg",
    "Baby Washcloths": "assets/Cotton_Newborn_Bany_Hats_Socks_And_Mittensset.webp",
    "Baby Bath Seats": "assets/Cute_Bear_Night_Light_for_kids.webp",

    // Images for Safety Equipment category
    "Baby Safety Gates": "assets/Cute_Wall_Clock_Non_Ticking_Living_Room_Decor.jpeg",
    "Outlet Covers": "assets/Daiper_changing_pads.jpg",
    "Cabinet Locks": "assets/Daipers_caddies.jpg",
    "Corner Protectors": "assets/Daipers_fasteners.webp",
    "Baby Monitors with Camera": "assets/Deluxe_Portable_Baby_Swing.jpeg",
    "Childproofing Kits": "assets/Deuter_Kid_Comfort_baby_carrier_for_hiking.jpg",
    "Stove Knob Covers": "assets/Double_Ends_Feeding_Bottle_Brush.webp",
    "Baby Proofing Locks": "assets/Double_Wearable_Hands-Free_Breast_Pump.webp",
    "Baby Safety Harnesses": "assets/Dove_Baby_Head_To_Toe_Body_Wash.jpg",
    "Anti-Tip Furniture Straps": "assets/Dowell_Baby_Bottle_Sterillizer.jpeg",

    // Images for Travel Gear category
    "Baby Strollers": "assets/Bottle_Sterilizers.jpg",
    "Baby Car Seats": "assets/Dr.Brown's_Infant_to_toddler_Training_Toothbrush_set.jpeg",
    "Baby Carriers": "assets/Duo_Newborn_Baby_Bottle_Gift_Set.jpg",
    "Portable Cribs": "assets/Electric_Baby_Food_Milk_Bottle_Warmer.jpeg",
    "Travel Diaper Bags": "assets/Electric_Baby_Nail_trimmer.jpeg",
    "Stroller Organizers": "assets/Engraved_Wooden_Keepsake_Box.jpg",
    "Car Seat Travel Bags": "assets/Ergonomic_baby_carrier_with_hip_seat.webp",
    "Baby Travel High Chairs": "assets/Evenflo_2_in_1_Baby_Bottle_Brush_With_Nipple_Brush.jpeg",
    "Travel Playards": "assets/Express_Electric_Steam_Sterilizer.webp",
    "Diaper Changing Kits": "assets/fleece_Warm_Cotton_Baby_Winter_Coat.jpeg",

    // Images for Healthcare category
    "Baby Thermometers": "assets/Foldable_Baby_BatHtub_With_Thermometer_And_Bath_Cushion.webp",
    "Nasal Aspirators": "assets/Baby_Milk.jpg",
    "Baby Medicine Dispensers": "assets/Generic_Coral_FleeceSuper_Soft_Baby_Bath_Towel.jpeg",
    "Baby First Aid Kits": "assets/Generic_DividedPlate_For_Kids.jpeg",
    "Teething Gel": "assets/Generic_Electric_Baby_Bouncer_Seat_Pad.jpg",
    "Baby Vaporizers": "assets/Generic_Marble_Run_Building_Blocks.jpeg",
    "Baby Gripe Water": "assets/Portable_Insulated_Baby_bottle_Bag.jpg",
    "Baby Cold Packs": "assets/Generic_spelling_game_Toy.jpg",
    "Baby Humidifiers": "assets/Baby_Bed.jpg",
    "Baby Nail Files": "assets/Giraffe_shaped_Wicker_Basket.jpeg",

    // Images for Pacifiers and Teethers category
    "Silicone Pacifier Set": "assets/Girl_Boss_Happy_Sippy_Cup.png",
    "Teething Rings with Various Textures": "assets/goodnight-moon_3_piece_Celestial_Nusery_Baby_Crib_Bedding_Set.webp",
    "Orthodontic Pacifiers": "assets/Graco_Glider_Elite_2_in_1_Gliding_Swing.jpg",
    "Teething Mitten": "assets/Growth_Chart_Ruler_Decal_Kit.jpg",
    "Natural Rubber Teether": "assets/high_tray_cover.jpeg",
    "Pacifier Clips": "assets/Jam_Session_Jummping_Activity_Center.jpeg",
    "Fruit Teethers": "assets/Johnson's_Baby_Lotion.jpg",
    "Teethers with Cooling Gel": "assets/Johnson's_Baby_no_more_Tangles_Detagling_Spray.jpe"
        "g",
    "Pacifier Case Holder": "assets/Johnson's_Baby_Shampoo_Wash_with_Gentle_Tear.jpeg",
    "Animal-shaped Teething Toys": "assets/Lansinoh_Disposable_Nursing_Pads.jpeg",

    // Images for Baby Books category
    "Board Books for Infants": "assets/Lansinoh_Nipple_Cream.jpg",
    "Cloth Books with Crinkle Pages": "assets/Liodux_baby_swings_for_infants.jpg",
    "Interactive Touch and Feel Books": "assets/Little's_Junior_Rings_For_Babies.jpeg",
    "Classic Bedtime Storybooks": "assets/Longrich_2_in_1_Baby_Shampoo_and_Baby_Wash.jpg",
    "Picture Books with Large Images": "assets/luxury-baby-musical-playmat-safari-play-gym.webp",
    "ABC and Counting Books": "assets/LX_Swing_with_Portable_Bouncer.jpeg",
    "Soft Books for Tummy Time": "assets/Medela_Breast_Milk_Storage_Bags.jpg",
    "Baby's First Words Books": "assets/Mei_Tai_Baby_Carrier.jpeg",
    "Sensory Books with Mirrors": "assets/Multicolor_Water_Failled_Toy_Teethers.webp",
    "Nursery Rhyme Collections": "assets/Multicolored_Baby_Socks_(Pack_of_four).jpg",

    // Images for Bedding category
    "Crib Bedding Set": "assets/Munchkin_Formula_Dispenser_Combo_Pack.jpeg",
    "Baby Blankets": "assets/Munchkin_Spotless_Silicone_Toddler_Placemats.webp",
    "Fitted Crib Sheets": "assets/Munchkin_ToddlerFork_and_Spoon_Set.jpeg",
    "Swaddle Blankets": "assets/Musical_mobile.jpg",
    "Sleeping Bags": "assets/New_born_baby_bath_support.jpg",
    "Crib Bumpers": "assets/New_Warm_Heavy_Baby_Romper.jpeg",
    "Changing Pad Covers": "assets/Nuby_3_pack_baby_Washclothes.jpeg",
    "Toddler Bedding Sets": "assets/Nursery_Decor_Wall_Shelves.jpg",
    "Nursery Curtains": "assets/Nusery_Wall_Art_Print_Set.jpg",
    "Waterproof Mattress Protectors": "assets/Organic_Cotton_Bunny_Baby_Hat.jpeg",

    // Images for Baby Care Products category
    "Diapers (Various Sizes)": "assets/Organic_Natural_Oatmeal_Heirloom_Baby_Blanket.jpeg",
    "Baby Wipes": "assets/pails.jpeg",
    "Baby Shampoo and Wash": "assets/Pineapple_Baby_sun_hat.webp",
    "Baby Oil": "assets/Plastic_Baby_Rattle.webp",
    "Baby Powder": "assets/POrtable_Playpen_With_Carrying_Case_For_Infants_And_Babies.webp",
    "Baby Hairbrush and Comb Set": "assets/Qilay_Wooden_Baby.jpeg",
    "Nail Clippers for Babies": "assets/Rattles.jpg",
    "Digital Baby Thermometer": "assets/Richgv_Soft_Cloth_Baby_Book.jpg",

    // Images for Maternity Gear category
    "Maternity Clothing": "assets/Roud_Electric_Baby_Nail_Trimmer.jpeg",
    "Maternity Support Belt": "assets/Safari_Animal_Nusery_Curtains.webp",
    "Maternity Pillow": "assets/Safari_Animals_Personalised_Baby_Milestone_Cards.webp",
    "Nursing Bras": "assets/Set-of-3-Absorbent-Cotton-Hooded-Baby-Towels-.webp",
    "Nursing Pads": "assets/Nursing_Pads.jpg",
    "Belly Bands": "assets/Soft_Kids_Room_Nursery_Rug.jpg",
    "Maternity Jeans": "assets/Soft_newborn_baby_wrap_blankets.jpg",
    "Pregnancy Wedge Pillow": "assets/Soft_Sole_Cribe_Shoes.jpg",
    "Maternity Swimwear": "assets/Soft_Tip_Baby_Feeding_Spoons.jpeg",
    "Maternity Support Pantyhose": "assets/Solly_Baby_Wrap_Carrier.jpeg",
    // Add more product names and their corresponding image paths here

    // Images for Learning and Activity Toys category
    "Activity Gym Playmat": "assets/Stoie's_Kids_Musical_Instruments_Set.jpeg",
    "Baby Rattles": "assets/Sunba_Youth_Baby_Beach_Tent.jpeg",
    "Stacking Rings": "assets/Suveno_Baby_Hipseat_carrier.jpg",
    "Soft Building Blocks": "assets/Swaddle_Blanket,_Adjustable_Infant_Baby_Wrap.jpeg",
    "Musical Toys": "assets/swim_daipers.jpeg",
    "Shape Sorters": "assets/The_weego_twin_baby_carrier.webp",
    "Activity Cubes": "assets/toy.jpg",
    "Interactive Baby Books": "assets/Ultra_Quiet_Cordless_Electric_Hair_Trimmer.jpg",
    "Play and Learn Activity Centers": "assets/user_profile_image.jpg",
    "Baby Einstein Discovery Toys": "assets/White_cotton_sleeve_onesie.jpeg",

    "Baby Food Jars": "active.jpg",
    "Baby Food Pouches": "assets/audio_baby_monitor.jpg",
    "Baby Food Makers": "assets/baby_breathing_monitor.jpg",
    "Baby Food Storage Containers": "assets/baby_monitor_with_temperature.jpg",
    "Baby Food Spoons": "assets/Baby-Water-Play-Mat-Main.jpg",
    "Baby Food Freezer Trays": "assets/digital_audio_baby_monitor.jpg",
    "Baby Food Grinders": "assets/kisspng-ks-kids-love-circle-baby-activity-centre-child-in-kampx6-s-kids-5be26c3f83f654.5921889515415655035405.png",
    "Baby Food Cookbooks": "assets/long range monitor.jpg",
    "Baby Feeding Sets": "assets/night vision baby camera.jpg",
    "Baby Food Warmers": "assets/pngwing.com.png",

    // Add more product names and their corresponding image paths here
  };


  // Check if the product name is in the map, if not, use a default image
  if (productImages.containsKey(productName)) {
    return AssetImage(productImages[productName]!);
  } else {
    return const AssetImage('assets/default-img.jpg');
  }
}
}

class FadeInAnimation extends StatefulWidget {
  final Widget child;

  FadeInAnimation({required this.child});

  @override
  _FadeInAnimationState createState() => _FadeInAnimationState();
}

class _FadeInAnimationState extends State<FadeInAnimation> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 500),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
