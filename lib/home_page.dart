import 'dart:io' show Directory, Platform;
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:geradorversiculos/versiculos.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';



class Versiculos extends StatefulWidget {
  const Versiculos({Key? key,}) : super(key: key);
  
  @override
  State<Versiculos> createState() => _VersiculosState();
}

class _VersiculosState extends State<Versiculos> {

  final controller = ScreenshotController();
    
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
              image: AssetImage("assets/fundo3.png"), // <-- BACKGROUND IMAGE
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent, // <-- SCAFFOLD WITH TRANSPARENT BG
          appBar: AppBar(
            actions: [
              IconButton(onPressed: ()async {
                /*_shareScreenshot(
                  context: context,
                  shareWidget:  
                  
                  Container(
                    width: double.infinity,
                    height: double.infinity,

                  ));*/

                /*
                if(versiculo.isNotEmpty ||  titulo.isNotEmpty){
                  await Share.share("versiculo: ${versiculo} :${titulo}");
                }*/
                
              }, icon: const Icon(Icons.share))
            ],
            elevation: 3.0,
          backgroundColor: Colors.grey.shade900,
          //PROPAGANDA admob
          title: isLoaded ? 
          SizedBox(
                  height: 62,
                  width: 350,
                  child: AdWidget(
                    ad: bannerAd!,
                  ),
                )
              :
           Text(
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
        child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0,45.0,8.0,8.0),
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
                          style: GoogleFonts.oswald(
                            color: Colors.grey.shade900,
                            fontSize: 35,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          titulo,
                          style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ), 
                      ],
                    ),
                  ), 
                ),
                ),
                /*onTap: (){
                  setVersiculo();
                },*/
                height: double.infinity,
              ),
            ),
            onTap: (){
                setVersiculo();
              },
      ),
        ),
      ],
      
    )
    
    );

  }

 /* Future<void> _shareScreenshot({
    required BuildContext context,
    required Widget shareWidget

    }) async {

      final box = context.findRenderObject() as RenderBox?;

      ScreenshotController()
      .captureFromWidget(shareWidget)
      .then((Uint8List bytes) async{
        final Directory dir = await getApplicationSupportDirectory();
        final String ts = DateTime.now().millisecondsSinceEpoch.toString();

        final String filePath = '${dir.path}/$ts.png';
        XFile.fromData(bytes).saveTo(filePath);

        await Share.shareXFiles(
          [XFile(filePath)],
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
        );


      });

    }*/
  
}
