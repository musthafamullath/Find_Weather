import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/constents.dart';
import '../data/image_path.dart';
import '../services/location_provider.dart';
import '../services/weather_service_provider.dart';
import '../utils/apptext.dart';
import '../utils/custom_divider_page.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  @override
  void initState() {
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    locationProvider.determinePosition().then((_) {
      if (locationProvider.currentLocationName != null) {
        var city = locationProvider.currentLocationName!.locality;
        if (city != null) {
          Provider.of<WeatherServiceProvider>(context, listen: false)
              .fetchWeatherDataByCity(city.toString());
        }
      }
    });

    super.initState();
  }

  final TextEditingController _cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // Get the weather data from the WeatherServiceProvider
    final weatherProvider = Provider.of<WeatherServiceProvider>(context);
// Inside the build method of your _HomePageState class

// Get the sunrise timestamp from the API response
    int sunriseTimestamp = weatherProvider.weather?.sys?.sunrise ??
        0; // Replace 0 with a default timestamp if needed
    int sunsetTimestamp = weatherProvider.weather?.sys?.sunset ??
        0; // Replace 0 with a default timestamp if needed

// Convert the timestamp to a DateTime object
    DateTime sunriseDateTime =
        DateTime.fromMillisecondsSinceEpoch(sunriseTimestamp * 1000);
    DateTime sunsetDateTime =
        DateTime.fromMillisecondsSinceEpoch(sunsetTimestamp * 1000);

// Format the sunrise time as a string
    String formattedSunrise = DateFormat.jm().format(sunriseDateTime);
    String formattedSunset = DateFormat.jm().format(sunsetDateTime);
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding:
              const EdgeInsets.only(top: 65, left: 20, right: 20, bottom: 20),
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    background[
                            weatherProvider.weather?.weather![0].main ?? "N/A"] ??
                        "assets/img/default.png",
                  ))),
          child: Stack(
            children: [
              SizedBox(
                height: 50,
                child: Consumer<LocationProvider>(
                    builder: (context, locationProvider, child) {
                  if (locationProvider.currentLocationName != null) {
                  } else {
                    
                  }
        
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.location_pin,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                data: weatherProvider.weather?.name ?? "N/A",
                                color: Colors.white,
                                fw: FontWeight.w700,
                                size: 18,
                              ),
                              AppText(
                                data: "Your searched place weather is: 👇",
                                color: Colors.white,
                                fw: FontWeight.bold,
                                size: 16,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                }),
              ),
              Positioned(
                top: 90,
                left: 70,
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        imagePath[weatherProvider.weather?.weather![0].main ??
                                "N/A"] ??
                            "assets/img/default.png",
                        height: 150,
                        width: 200,
                        // Adjust the height as needed
                      ),
                      AppText(
                        data:
                            "weather: ${weatherProvider.weather?.weather![0].main ?? "N/A"}",
                        color: Colors.white,
                        fw: FontWeight.bold,
                        size: 32,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0, 0),
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withOpacity(0.4)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppText(
                                data:
                                    "Temp: ${weatherProvider.weather?.main?.temp?.toStringAsFixed(0) ?? "N/A"} \u00B0C", // Display temperature
                                color: Colors.white,
                                fw: FontWeight.bold,
                                size: 13,
                              ),
                              kHeight5,
                              AppText(
                                data:
                                    "weather: ${weatherProvider.weather?.weather![0].main ?? "N/A"}",
                                color: Colors.white,
                                fw: FontWeight.w600,
                                size: 13,
                              ),
                              kHeight5,
                              AppText(
                                data:
                                    DateFormat("hh:mm a").format(DateTime.now()),
                                color: Colors.white,
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppText(
                                data:
                                    "FeelsLike: ${weatherProvider.weather?.main?.feelsLike?.toStringAsFixed(0) ?? "N/A"} \u00B0C", // Display temperature
                                color: Colors.white,
                                fw: FontWeight.bold,
                                size: 13,
                              ),
                              kHeight5,
                              AppText(
                                data:
                                    "Pressure: ${weatherProvider.weather?.main?.pressure.toString() ?? "N/A"} \u00B0C",
                                color: Colors.white,
                                fw: FontWeight.w600,
                                size: 13,
                              ),
                              kHeight5,
                              AppText(
                                data:
                                    "Humidity: ${weatherProvider.weather?.main?.humidity.toString() ?? "N/A"} \u00B0C",
                                color: Colors.white,
                                fw: FontWeight.w600,
                                size: 13,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppText(
                                data:
                                    "Wind deg: ${weatherProvider.weather?.wind?.deg}",
                                color: Colors.white,
                                fw: FontWeight.w600,
                                size: 13,
                              ),
                              kHeight5,
                              AppText(
                                data:
                                    "W/Speed: ${weatherProvider.weather?.wind?.speed} km", // Display temperature
                                color: Colors.white,
                                fw: FontWeight.bold,
                                size: 13,
                              ),
                              kHeight5,
                              AppText(
                                data: DateFormat('dd MMM yyyy')
                                    .format(DateTime.now()),
                                color: Colors.white,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.0, 0.75),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withOpacity(0.4)),
                  height: 180,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/img/temperature-high.png',
                                height: 55,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    data: "Temp Max",
                                    color: Colors.white,
                                    size: 14,
                                    fw: FontWeight.w600,
                                  ),
                                  AppText(
                                    data:
                                        "${weatherProvider.weather?.main!.tempMax!.toStringAsFixed(0)} \u00B0C",
                                    color: Colors.white,
                                    size: 14,
                                    fw: FontWeight.w600,
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/img/temperature-low.png',
                                height: 55,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    data: "Temp Min",
                                    color: Colors.white,
                                    size: 14,
                                    fw: FontWeight.w600,
                                  ),
                                  AppText(
                                    data:
                                        "${weatherProvider.weather?.main!.tempMin!.toStringAsFixed(0)} \u00B0C",
                                    color: Colors.white,
                                    size: 14,
                                    fw: FontWeight.w600,
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      const CustomDivider(
                        startIndent: 20,
                        endIndent: 20,
                        color: Colors.white,
                        thickness: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/img/sun.png',
                                height: 55,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    data: "Sunrise",
                                    color: Colors.white,
                                    size: 14,
                                    fw: FontWeight.w600,
                                  ),
                                  AppText(
                                    data: formattedSunrise,
                                    color: Colors.white,
                                    size: 14,
                                    fw: FontWeight.w600,
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/img/moon.png',
                                height: 55,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    data: "Sunset",
                                    color: Colors.white,
                                    size: 14,
                                    fw: FontWeight.w600,
                                  ),
                                  AppText(
                                    data: formattedSunset,
                                    color: Colors.white,
                                    size: 14,
                                    fw: FontWeight.w600,
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 50,
                left: 20,
                right: 20,
                child: SizedBox(
                  height: 45,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: const TextStyle(color: Colors.white),
                          controller: _cityController,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Provider.of<WeatherServiceProvider>(context,
                                    listen: false)
                                .fetchWeatherDataByCity(
                                    _cityController.text.toString());
                          },
                          icon: const Icon(
                            Icons.search,
                            size: 30,
                            color: Colors.red,
                          ))
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
}
