import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  String alinanVeri = "";
  var tfController = TextEditingController();//textfield controller
  String resimAdi = "hentagon.png";
  bool switchKontrol = false;
  bool checkBoxKontrol = false;
  int radioDeger = 0;
  bool progressKontrol = true;
  double ilerlemeMiktari = 50.0;

  var tfControllerSaat = TextEditingController();
  var tfControllerTarih = TextEditingController();

  var ulkelerListesi = <String>[];
  String secilenUlke = "Turkey";

  void initState(){
    super.initState();
    ulkelerListesi.add("Turkey");
    ulkelerListesi.add("Italy");
    ulkelerListesi.add("Germany");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Widget Kullanımı"),),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(alinanVeri),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: tfController,
                  decoration: const InputDecoration(hintText: "Veri"),
                  keyboardType: TextInputType.number,
                  obscureText: true, //şifreler için nokta oluşturuz
                ),
              ), //editText, plainText bu işte
              ElevatedButton(onPressed: (){
                setState((){alinanVeri = tfController.text;});

              }, child: Text("Veriyi Al")),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: (){
                    setState(()
                    {resimAdi = "square.png";}
                    );
                  }, child: Text("Resim 1")),
                  SizedBox(
                      width: 48.0,
                      height: 48.0,
                      child: Image.asset("resimler/${resimAdi}")),
                  
                  ElevatedButton(onPressed: (){
                    setState(()
                    {resimAdi = "hentagon.png";}
                    );
                  }, child: Text("Resim 2")),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Switch(
                      value: switchKontrol,
                      onChanged: (veri){
                        setState(()
                        {switchKontrol = veri;});
                        print("Switch : ${veri}");
                      }),

                  SizedBox(width: 200,
                    child: CheckboxListTile(title: const Text("Flutter"),
                        controlAffinity: ListTileControlAffinity.leading,
                        value: checkBoxKontrol, onChanged: (bool? veri)
                    {
                      setState(()
                      {checkBoxKontrol = veri!;});
                      print("CheckBox : ${veri}");
                    }),
                  ),
                ],
              ),

              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 150,
                    child: RadioListTile(title: const Text("BC"),
                        value: 1, groupValue: radioDeger, onChanged: (int? veri){
                          setState((){ radioDeger = veri!; });
                        }),
                  ),

                  SizedBox(width: 150,
                    child: RadioListTile(title: const Text("RM"),
                        value: 2, groupValue: radioDeger, onChanged: (int? veri){
                          setState((){ radioDeger = veri!; });
                        }),
                  ),
                ],
              ),

              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: (){
                    setState(()
                    {progressKontrol = true;}
                    );
                  }, child: Text("Başla")),
                  Visibility(visible: progressKontrol,child: CircularProgressIndicator()),
                  ElevatedButton(onPressed: (){
                    setState(()
                    {progressKontrol = false;}
                    );
                  }, child: Text("Dur")),
                ],
              ),

              Text("${ilerlemeMiktari.toInt()}"),
              Slider(max: 100.0, min: 0.0,
                  value: ilerlemeMiktari, onChanged: (veri){
                setState((){ilerlemeMiktari = veri; });
                  }),

              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 100,
                    child: TextField(controller: tfControllerSaat,
                    decoration: InputDecoration(hintText: "Saat"),
                    ),
                  ),
                  IconButton(onPressed: (){
                    showTimePicker(context: context,
                        initialTime: TimeOfDay.fromDateTime(DateTime.now())
                    ).then((value) {
                      tfControllerSaat.text = "${value!.hour} : ${value.minute}";
                    });
                  }, icon: Icon(Icons.access_time)),

                  SizedBox(width: 100,
                    child: TextField(controller: tfControllerTarih,
                      decoration: InputDecoration(hintText: "Tarih"),
                    ),
                  ),
                  IconButton(onPressed: (){
                    showDatePicker(context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2030)
                    ).then((value){
                      tfControllerTarih.text = "${value!.day} / ${value.month} / ${value.year}";
                    });
                  }, icon: Icon(Icons.date_range_sharp)),
                ],
              ),

              SizedBox(width: 100,
                child: DropdownButton(value: secilenUlke,
                    icon: const Icon(Icons.arrow_drop_down),
                    items: ulkelerListesi.map<DropdownMenuItem<String>>((value){
                      return DropdownMenuItem(value: value,child: Text(value));
                    }).toList(),
                    onChanged: (String? secilenVeri){
                  setState(() {secilenUlke = secilenVeri!;});
                    }),
              ),

              GestureDetector(
                  onTap: (){
                    print("Container tek tıklandı");
                  },
                  onDoubleTap: (){
                    print("Container çift tıklandı");
                  },
                  onLongPress: (){
                    print("Container uzun basıldı");
                  },
                  child: Container(width: 200, height: 500,color: Colors.red)),

              ElevatedButton(onPressed: (){
                print("Switch En Son Durum : $switchKontrol");
                print("CheckBox En Son Durum : $checkBoxKontrol");
                print("Slider En Son Durum : ${ilerlemeMiktari}" );
              }, child: Text("Göster")),
            ],
          ),
        ),
      ),
    );
  }
}


//internetten veri çekme ile ilgili bir kısım anlattı orayı not alamadım!
//Onu videodan izle!

/*
Checkbox(
                    value: checkBoxKontrol,
                    onChanged: (bool? veri){
                      setState(()
                      {checkBoxKontrol = veri!;});
                      print("CheckBox : ${veri}");
                    }),
 */

/*

Sadece Toplama işlemi yapan bir hesap makinesi yap!
Tuş takımı olacak, butonlarla yani bunu sağlayacaksın
girişlerin hepsi tuş ile olacak!
ve sıfırlama tuşu olacak

 */