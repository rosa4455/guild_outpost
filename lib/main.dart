import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

int _targetGold = 1000000; // 우리 길드의 최종 목표!

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
class LedgerMainPage extends StatefulWidget {
  const LedgerMainPage({super.key});

  @override
  State<LedgerMainPage> createState() => _LedgerMainPageState();
}

class _LedgerMainPageState extends State<LedgerMainPage>{
  // 1. 숫자를 담아둘 '비서(컨트롤러)' 상자를 만듭니다.
  final TextEditingController _moneyController = TextEditingController();

  // 1-1. 초기 예산 상자를 만듭니다. ( 우리 남은 예산 380,000원!)
  int _currentBudget = 243163;

  // 1-2.기록들을 담아둘 마법의 보관함(리스트)을 만듭니다.
  List<String> _history =[];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('예술적 기록의 시작'),
        backgroundColor: const Color(0xFFFFD400),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // 화면 가장자리 여백
        child: Column(
          children: [
            // 2.남은 예산을 화면에 멋지게 표시합니다.
            Text(
                '남은 예산: $_currentBudget원',
                style: const TextStyle(fontSize:25, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
            const SizedBox(height: 20),

            // 글자를 입력받는 창
            TextField(
              // 2-1. 입력창과 비서를 연결합니다! 이제 이 창에 쓰는 건 비서가 다 기억해요.
              controller: _moneyController,
              decoration: const InputDecoration(
                labelText: '금액 입력',
                border: OutlineInputBorder()),
              keyboardType: TextInputType.number, // 숫자 키보드가 바로 뜨게!

              // 숫자만 입력하게 하기.
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 20),

            // 3. 비서가 잘 기억하고 있는지 확인하는 버튼!
            ElevatedButton(
              onPressed: (){
                // [핵심 마법] 글자를 숫자로 바꿔서 예산에서 뺍니다!
                setState(() {
                  //입력된 글자를 숫자로 변환 (없으면 0으로 처리)
                  int spend = int.tryParse(_moneyController.text) ?? 0;
                  if (spend > 0) {
                    _currentBudget -= spend; // 예산 차감

                    // 기록 보관함에 새 기록 추가
                    _history.insert(0, "-$spend원 사용됨");
                    _moneyController.clear();
                  }
                  });
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF333333)),
              child: const Text('소비 기록하기', style: TextStyle(color: Colors.white)),
            ),
            const Divider(height:40), // 구분선
            const Text('--- 최근 소비 내역 ---', style: TextStyle(color: Colors.grey)),
            // 보관함에 있는 기록들을 화면에 뿌려줍니다.
            Expanded(
              child: ListView.builder(
                  itemCount: _history.length,
              itemBuilder: (context, index){
                    return ListTile(
                      leading: const Icon(Icons.remove_circle_outline, color: Colors.redAccent),
                    title: Text(_history[index],style: const TextStyle(fontSize:18)),
                    );
              },
              ),
            ),
          ],
        ),
      ),
    );
  }
}