import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../providers/quiz_provider.dart';

class MascotReaction extends StatelessWidget {
  final QuizState state;

  const MascotReaction({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    // Menentukan status animasi maskot
    String animationUrl = 'https://assets3.lottiefiles.com/packages/lf20_1mqx1hyl.json'; // Default: Kucing Idle / Duduk

    if (state.isAnswerChecked) {
      if (state.isCorrect) {
        // Animasi Kucing Loncat / Happy
        animationUrl = 'https://assets5.lottiefiles.com/packages/lf20_yziud2q4.json'; 
      } else {
        // Animasi Kucing Pusing / Salah
        animationUrl = 'https://assets7.lottiefiles.com/packages/lf20_t2nczd6b.json'; 
      }
    } else if (state.isSecondChance) {
      // Animasi Kucing Bingung (Memberi Hint)
      animationUrl = 'https://assets1.lottiefiles.com/packages/lf20_p1qiua0j.json';
    }

    return SizedBox(
      height: 150,
      // Menggunakan Network Lottie sebagai placeholder (Nanti diganti asset lokal)
      child: Lottie.network(
        animationUrl,
        fit: BoxFit.contain,
        // Jika offline atau error, tampilkan Icon statis
        errorBuilder: (context, error, stackTrace) {
          IconData icon = Icons.pets;
          Color color = Colors.grey;
          
          if (state.isAnswerChecked) {
            if (state.isCorrect) {
              icon = Icons.sentiment_very_satisfied;
              color = Colors.green;
            } else {
              icon = Icons.sentiment_dissatisfied;
              color = Colors.red;
            }
          }
          
          return Center(
            child: Icon(icon, size: 80, color: color),
          );
        },
      ),
    );
  }
}
