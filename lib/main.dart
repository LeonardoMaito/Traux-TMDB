import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'views/home.dart';

void main(){
    runApp( const MaterialApp(
      debugShowCheckedModeBanner: false,
        home:  ProviderScope(child: Home())
     )
    );
}





