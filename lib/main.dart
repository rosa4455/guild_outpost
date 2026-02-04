import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
  home: OutpostPage(), // 처음 시작은 전초기지 페이지
));

// 1번 방: 전초기지 (OutpostPage)
class OutpostPage extends StatelessWidget{
  const OutpostPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFFFFD400),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Icon(Icons.star_rate_rounded, size:80, color: Colors.white),
            const SizedBox(height:20),
            const Text(
              'Mori Guld Outpost',
              style: TextStyle(fontSize:40, fontWeight: FontWeight.bold, color: Color(0xff333333)),
            ),
            const SizedBox(height:50),

            // 마법의 버튼
            ElevatedButton(
              onPressed: () {
                // 순간이동 마법
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LedgerMainPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF333333),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal:40, vertical:15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(34)),
              ),
              child: const Text('입장하기',style: TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

// 2번 방 : 가계부 메인 (LedgerMainPage)
class LedgerMainPage extends StatelessWidget{
  const LedgerMainPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('나의 예술 가계부'),
        backgroundColor: const Color(0xFFFFD400),
      ),
      body: const Center(
        child: Text(
          '본격적인 기록이 시작되는 곳!',
          style: TextStyle(fontSize:24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}