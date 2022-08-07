import 'dart:io' show Platform;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geradorversiculos/versiculos.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';

class Versiculos extends StatefulWidget {
  const Versiculos({Key? key,}) : super(key: key);
  
  @override
  State<Versiculos> createState() => _VersiculosState();
}

class _VersiculosState extends State<Versiculos> {
    
    AdRequest? adRequest;
    BannerAd? bannerAd;
    bool isLoaded = false;

    var versiculo = "";
    var titulo = "";
    

    
    setVersiculo(){
      var randomNumber = Random().nextInt(versiculos.length);
      setState(() {
       versiculo = versiculos[randomNumber]["versiculo"]!;
       titulo = versiculos[randomNumber]["titulo"]!;
      });
    }

    @override
  void initState() {
    setVersiculo();
    super.initState();
    String bannerId = Platform.isAndroid
        ? "ca-app-pub-2028996810271423/2144469885"
        : "ca-app-pub-3940256099942544/2934735716";

    adRequest = const AdRequest(
      nonPersonalizedAds: false,
    );

    BannerAdListener bannerAdListener = BannerAdListener(
      onAdLoaded: (ad) {
        setState(() {
          isLoaded = true;
        });
      },
      onAdClosed: (ad) {
        bannerAd!.load();
      },
      onAdFailedToLoad: (ad, error) {
        bannerAd!.load();
      },
    );
    bannerAd = BannerAd(
      size: AdSize.leaderboard,
      adUnitId: bannerId,
      listener: bannerAdListener,
      request: adRequest!,
    );
    bannerAd!.load();
  }

  @override
  void dispose() {
    bannerAd!.dispose();
    super.dispose();
  }

  compartilharVersiculo(){
    final versi = versiculo;
    final tit = titulo; 

    
  }

  @override
  Widget build(BuildContext context) {

    setVersiculo();
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack( // <-- STACK AS THE SCAFFOLD PARENT
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/fundo.png"), // <-- BACKGROUND IMAGE
              fit: BoxFit.cover,
            ),
          ),
        ),
        GestureDetector(
          child: Scaffold(
            backgroundColor: Colors.transparent, // <-- SCAFFOLD WITH TRANSPARENT BG
            appBar: AppBar(
              actions: [
                IconButton(onPressed: ()async {
                  if(versiculo.isNotEmpty ||  titulo.isNotEmpty){
                    await Share.share("versiculo: ${versiculo} :${titulo}");
                  }
                  
                }, icon: const Icon(Icons.share))
              ],
              elevation: 3.0,
            backgroundColor: Colors.grey.shade900,
            title: Text(
              "Gerador de Versículos",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade100,
              ),
            ), // <-- ELEVATION ZEROED
            ),
            body: GestureDetector(
              child: Container(
                child: SingleChildScrollView(
                 child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          versiculo,
                          style: GoogleFonts.roboto(
                            color: Colors.grey.shade900,
                            fontSize: 35,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          titulo,
                          style: GoogleFonts.openSans(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ), 
                      ],
                    ),
                  ), 
                ),
              ),
              ),
              onTap: (){
                setVersiculo();
              },
            ),
            
            /*bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            elevation: 0,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 80,
                child: Column(
                  children: [
                    Center(
                      child: TextButton(
                        child: Image.asset(
                          'assets/shuffle.png',
                          width: 80,
                          height: 60,
                          fit: BoxFit.contain,
                        ),
                        onPressed: setVersiculo,
                      ),
                    ),
                  ],
                  
                ),
                
              ),
              
              
            ),
            
          ),*/
          floatingActionButton: isLoaded
                ? SizedBox(
                    height: 62,
                    width: 350,
                    child: AdWidget(
                      ad: bannerAd!,
                    ),
                  )
                : const SizedBox(),
            ),
            onTap: (){
                setVersiculo();
              },
        ),
          
      ],
      
    )
    
    );

  }
}