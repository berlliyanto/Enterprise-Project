// ignore_for_file: camel_case_types, must_be_immutable

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_admin_ena/Services/machine_service.dart';
import 'package:flutter_admin_ena/Services/produksi_service.dart';
import 'package:flutter_admin_ena/Services/raw_service.dart';
import 'package:flutter_admin_ena/Widgets/machine.dart';
import 'package:flutter_admin_ena/models/machine_model.dart';
import 'package:flutter_admin_ena/models/produksi_model.dart';
import 'package:flutter_admin_ena/models/raw_model.dart';

class machinePage extends StatefulWidget {
  BoxConstraints constraints;
  machinePage({required this.constraints, super.key});

  @override
  State<machinePage> createState() => _machinePageState();
}

class _machinePageState extends State<machinePage> {
  int pageState = 0;
  bool mixerState = false;
  bool pembagiState = false;
  bool prooferState = false;
  bool ovenState = false;
  late Timer timer;
  int suhuProofer = 0;
  int humidityProofer = 0;
  int suhuOven = 0;
  int humidityOven = 0;

  StreamController streamMachine = StreamController.broadcast();
  List<MachineModel> listMachine = [];
  GetMachineState getMachine = GetMachineState();
  Future<void> machineData() async {
    listMachine = await getMachine.getMachine();
    streamMachine.add(listMachine);
  }
  StreamController streamRaw = StreamController.broadcast();
  List<RawModel> listRaw = [];
  GetRawMaterial getRaw = GetRawMaterial();
  Future<void> rawData()async{
    listRaw = await getRaw.getRaw();
    streamRaw.add(listRaw);
  }

  StreamController streamProduksi = StreamController.broadcast();
  List<ProduksiModel> listProduksi = [];
  GetProduksiData getProduk = GetProduksiData();
  Future<void> produksiData() async {
    listProduksi = await getProduk.getProduksi();
    streamProduksi.add(listProduksi);
  }

  void randomSuhU() {
    var randomSuhuProofer = Random().nextInt(101);
    var randomSuhuOven = Random().nextInt(101);
    var randomHumidityProofer = Random().nextInt(101);
    var randomHumidityOven = Random().nextInt(101);
    setState(() {
      suhuProofer = randomSuhuProofer;
      suhuOven = randomSuhuOven;
      humidityOven = randomHumidityOven;
      humidityProofer = randomHumidityProofer;
    });
  }

  @override
  void initState() {
    produksiData();
    rawData();
    machineData();
    randomSuhU();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      rawData();
      machineData();
      produksiData();
      randomSuhU();
    });
    super.initState();
  }

  @override
  void dispose() {
    if (timer.isActive) timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double blockHorizontal = widget.constraints.maxWidth / 100;
    double blockVertical = widget.constraints.maxHeight / 100;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  pageState=0;
                });
              },
              child: Padding(
                padding: EdgeInsets.only(
                    left: blockHorizontal * 2, top: blockVertical * 2),
                child: Text(
                  "Machine",
                  style:
                      TextStyle(color: (pageState==0)?Colors.blue:Colors.black54, fontSize: blockVertical * 4),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  pageState=1;
                });
              },
              child: Padding(
                padding: EdgeInsets.only(
                    left: blockHorizontal * 2, top: blockVertical * 2),
                child: Text(
                  "Warehouse",
                  style:
                      TextStyle(color: (pageState==1)?Colors.blue:Colors.black54, fontSize: blockVertical * 4),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  pageState=2;
                });
              },
              child: Padding(
                padding: EdgeInsets.only(
                    left: blockHorizontal * 2, top: blockVertical * 2),
                child: Text(
                  "Production",
                  style:
                      TextStyle(color: (pageState==2)?Colors.blue:Colors.black54, fontSize: blockVertical * 4),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: blockVertical*2,
        ),
        SizedBox(
          height: blockVertical * 88,
          width: blockHorizontal * 100,
          child: (pageState==0)?StreamBuilder(
              stream: streamMachine.stream,
              builder: (context, snapshot) {
                return Row(
                  children: listMachine.map((e) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Machine(
                            blockHorizontal,
                            blockVertical,
                            "Mixer",
                            "mixer",
                            (e.mixer!) ? "Ada" : "Tidak Ada",
                            "Ultrasonik : ",
                            " ",
                            (e.mixer!) ? "Aktif" : "Tidak Aktif",
                            " ",
                            "Motor",
                            (e.mixer!) ? "Aktif" : "Tidak Aktif",
                            (e.mixer!) ? Colors.green : Colors.red,
                            (e.mixer!) ? Colors.green : Colors.red, () {
                          setState(() {
                            mixerState = !mixerState;
                          });
                          if(mixerState==true){
                            UpdateMachine.updateMachineMixer(true);
                          }else{
                            UpdateMachine.updateMachineMixer(false);
                          }
                        }, (e.mixer!) ? true : false),
                        Machine(
                            blockHorizontal,
                            blockVertical,
                            "Pembagi Adonan",
                            "pembagi",
                            (e.pembagi!) ? "Ada" : "Tidak Ada",
                            "Proximity : ",
                            " ",
                            (e.pembagi!) ? "Aktif" : "Tidak Aktif",
                            " ",
                            "Motor",
                            (e.pembagi!) ? "Aktif" : "Tidak Aktif",
                            (e.pembagi!) ? Colors.green : Colors.red,
                            (e.pembagi!) ? Colors.green : Colors.red, () {
                          setState(() {
                            pembagiState = !pembagiState;
                          });
                          if(pembagiState==true){
                            UpdateMachine.updateMachinepembagi(true);
                          }else{
                            UpdateMachine.updateMachinepembagi(false);
                          }
                        }, (e.pembagi!) ? true : false),
                        Machine(
                            blockHorizontal,
                            blockVertical,
                            "Proofer",
                            "proofer",
                            (e.proofer!) ? "Ada" : "Tidak Ada",
                            "Suhu : ",
                            "Humidity : ",
                            (e.proofer!) ? "$suhuProofer" : "0",
                            (e.proofer!) ? "  $humidityProofer" : "   0",
                            "Heater",
                            (e.proofer!) ? "Aktif" : "Tidak Aktif",
                            Colors.white,
                            (e.proofer!) ? Colors.green : Colors.red, () {
                          setState(() {
                            prooferState = !prooferState;
                          });
                          if(prooferState==true){
                            UpdateMachine.updateMachineproofer(true);
                          }else{
                            UpdateMachine.updateMachineproofer(false);
                          }
                        }, (e.proofer!) ? true : false),
                        Machine(
                            blockHorizontal,
                            blockVertical,
                            "Oven",
                            "oven",
                            (e.oven!) ? "Ada" : "Tidak Ada",
                            "Suhu : ",
                            "Humidity : ",
                            (e.oven!) ? "$suhuOven" : "0",
                            (e.oven!) ? "  $humidityOven" : "   0",
                            "Heater",
                            (e.oven!) ? "Aktif" : "Tidak Aktif",
                            Colors.white,
                            (e.oven!) ? Colors.green : Colors.red, () {
                          setState(() {
                            ovenState = !ovenState;
                          });
                          if(ovenState==true){
                            UpdateMachine.updateMachineoven(true);
                          }else{
                            UpdateMachine.updateMachineoven(false);
                          }
                        }, (e.oven!) ? true : false),
                      ],
                    );
                  }).toList(),
                );
              }):(pageState==1)?StreamBuilder(
                stream: streamRaw.stream,
                builder: (context, snapshot) {
                  return Column(
                    children: listRaw.map((e) {
                      return rak(blockHorizontal, blockVertical,"${e.gula} KG","${e.coklat} KG","${e.keju} KG","${e.terigu} KG","${e.stroberi} KG","${e.telur} KG", ovenState);
                    }).toList()
                  );
                }
              ):StreamBuilder(
                stream: streamProduksi.stream,
                builder: (context, snapshot) {
                  return Column(
                    children: listProduksi.map((e) => produksi(blockHorizontal, blockVertical, "${e.rotikeju}", "${e.roticoklat}", "${e.rotistroberi}"),).toList() 
                  );
                }
              ),
        ),
      ],
    );
  }
  Widget rak(double blockHorizontal, double blockVertical, String gula, String coklat, String keju, String terigu, String stroberi, String telur, bool ovenState){
    return Container(
      height: blockVertical*88,
      width: blockHorizontal*100,
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            top: blockHorizontal*2,
            child: Container(
              alignment: Alignment.centerLeft,
              height: blockVertical*40,
              width: blockHorizontal*100,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/Rakk.jpg"))
              ),
            ),
          ),
          Positioned(
            top: blockVertical*1,
            left: blockHorizontal*8,
            child: Text("Karakuri Bahan Baku Roti",style: TextStyle(fontSize: blockVertical*4, color: Colors.black54, fontWeight: FontWeight.bold) )),
          Positioned(
            top: blockVertical*15,
            left: blockHorizontal*23,
            child: Text(gula, style: TextStyle(fontSize: blockVertical*5, color: Colors.white, fontWeight: FontWeight.bold),)),
          Positioned(
            top: blockVertical*32,
            left: blockHorizontal*23,
            child: Text(terigu, style: TextStyle(fontSize: blockVertical*5, color: Colors.white, fontWeight: FontWeight.bold),)),
          Positioned(
            top: blockVertical*15,
            left: blockHorizontal*51,
            child: Text(coklat, style: TextStyle(fontSize: blockVertical*5, color: Colors.white, fontWeight: FontWeight.bold),)),
          Positioned(
            top: blockVertical*32,
            left: blockHorizontal*51,
            child: Text(stroberi, style: TextStyle(fontSize: blockVertical*5, color: Colors.white, fontWeight: FontWeight.bold),)),
          Positioned(
            top: blockVertical*15,
            left: blockHorizontal*79,
            child: Text(keju, style: TextStyle(fontSize: blockVertical*5, color: Colors.white, fontWeight: FontWeight.bold),)),
          Positioned(
            top: blockVertical*32,
            left: blockHorizontal*79,
            child: Text(telur, style: TextStyle(fontSize: blockVertical*5, color: Colors.white, fontWeight: FontWeight.bold),)),
          Positioned(
            top: blockVertical*45,
            left: blockHorizontal*8,
            child: Text((ovenState)?"AGV: AKTIF":"AGV: TIDAK AKTIF", style: TextStyle(fontSize: blockVertical*5, color: Colors.black54, fontWeight: FontWeight.bold),)),
          Positioned(
            top: blockVertical*55,
            left: blockHorizontal*8,
            child: Text((ovenState)?"HANDLING STATION: AKTIF":"HANDLING STATION: TIDAK AKTIF", style: TextStyle(fontSize: blockVertical*5, color: Colors.black54, fontWeight: FontWeight.bold),)),
          Positioned(
            top: blockVertical*65,
            left: blockHorizontal*8,
            child: Text((ovenState)?"PICK AND PLACE STATION: AKTIF":"PICK AND PLACE STATION: TIDAK AKTIF", style: TextStyle(fontSize: blockVertical*5, color: Colors.black54, fontWeight: FontWeight.bold),)),
        ],
      ),
    );
  }

  Widget produksi (double blockHorizontal, double blockVertical, String rKeju, String rCoklat, String rStroberi,){
    return Container(
      height: blockVertical*88,
      width: blockHorizontal*100,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: blockVertical*80,
                width: blockHorizontal*30,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Roti Coklat", style: TextStyle(fontSize: blockVertical*8, color: Colors.black54),),
                    SizedBox(height: blockVertical*3,),
                    Text("$rCoklat pcs", style: TextStyle(fontSize: blockVertical*12, color: Colors.black54),)
                  ],
                ),
              ),
              Container(
                height: blockVertical*80,
                width: blockHorizontal*30,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Roti Keju", style: TextStyle(fontSize: blockVertical*8, color: Colors.black54),),
                    SizedBox(height: blockVertical*3,),
                    Text("$rKeju pcs", style: TextStyle(fontSize: blockVertical*12, color: Colors.black54),)
                  ],
                ),
              ),
              Container(
                height: blockVertical*80,
                width: blockHorizontal*30,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Roti Stroberi", style: TextStyle(fontSize: blockVertical*8, color: Colors.black54),),
                    SizedBox(height: blockVertical*3,),
                    Text("$rStroberi pcs", style: TextStyle(fontSize: blockVertical*12, color: Colors.black54),)
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: blockVertical*2,),
          Center(
            child: OutlinedButton(onPressed: (){
              ResetProduksiData.resetProduksi();
            }, child: Text("RESET", style: TextStyle(color: Colors.red, fontSize: blockVertical*4),)),
          )
        ],
      )
    );
  }
}
