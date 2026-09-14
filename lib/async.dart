Future<String> checkSpiderManStatus() async {
  
  await Future.delayed(Duration(seconds: 2));
  
  return "Ready to save New York!";
}

void main() async {
  print("1. Contacting Peter Parker...");
  
  String status = await checkSpiderManStatus();
  
  print("2. Spider-Man is: $status");
}

Future <String> SpidermanAarahai() async{
    try{
        print("\n spiderman aapki seva mei haazir hai !");

        String spidey = await SpidermanAarahai();
        print("aagay:$spidey");


    }
    catch (error){
        
    }

}