import 'package:flutter/material.dart';
import 'package:persons/UI/views/detay_sayfa.dart';
import 'package:persons/UI/views/kayit_sayfa.dart';
import 'package:persons/data/entity/kisiler.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  bool aramaYapiliyorMu = false;

  Future<void> ara(String aramaKelimesi) async {
    print("Kişi Ara: $aramaKelimesi");
  }

  Future<List<Kisiler>> kisileriYukle() async {
    var kisilerListesi = <Kisiler>[];
    var k1 = Kisiler(kisi_id: 1, kisi_ad: "Arda", kisi_tel: "1111");
    var k2 = Kisiler(kisi_id: 2, kisi_ad: "Zeynep", kisi_tel: "2222");
    var k3 = Kisiler(kisi_id: 3, kisi_ad: "Beyza", kisi_tel: "3333");
    kisilerListesi.add(k1);
    kisilerListesi.add(k2);
    kisilerListesi.add(k3);
    return kisilerListesi;
  }

  Future<void> sil(int kisi_id) async {
    print("Kişi Sil: $kisi_id");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar
        (title: aramaYapiliyorMu ?
        TextField(decoration: const InputDecoration(hintText: "Ara"),
          onChanged: (aramaSonucu) {
          ara(aramaSonucu);
          },
        ) :
        const Text("Kişiler"),
        actions: [
          aramaYapiliyorMu ?
          IconButton(onPressed: () {

            setState(() {
              aramaYapiliyorMu = false;
            });

          }, icon: const Icon(Icons.clear)) :
          IconButton(onPressed: () {
            setState(() {
              aramaYapiliyorMu = true;
            });
          }, icon: const Icon(Icons.search),)
        ],
        ),
      body: FutureBuilder<List<Kisiler>>(
        future: kisileriYukle(),
        builder: (context, snapshot){
          if( snapshot.hasData){
            var kisilerListesi = snapshot.data;
            return ListView.builder(
              itemCount: kisilerListesi!.length,
              itemBuilder: (context, indeks) {
                var kisi = kisilerListesi[indeks];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  DetaySayfa(kisi: kisi)))
                        .then((value){
                      print("Anasayfaya dönüldü");
                    });                  },
                  child: Card(
                    child: SizedBox(height: 100,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(kisi.kisi_ad, style: TextStyle(fontSize: 22),),
                                Text(kisi.kisi_tel, style: TextStyle(fontSize: 22),),
                              ],
                            ),
                          ) ,
                          const Spacer(),
                          IconButton(onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${kisi.kisi_ad} silinsin mi?"),
                            action: SnackBarAction(
                              label: "Evet",
                              onPressed: () {
                                sil(kisi.kisi_id);
                              },
                            ),)
                            );
                          }, icon: const Icon(Icons.clear, color: Colors.black54,),)
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          else{
            return const Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const KayitSayfa()))
              .then((value){
            print("Anasayfaya dönüldü");
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
