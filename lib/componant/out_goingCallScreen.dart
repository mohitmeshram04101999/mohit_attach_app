import 'package:flutter/material.dart';

class OutGoingCallScreen extends StatefulWidget {
  const OutGoingCallScreen({super.key});

  @override
  State<OutGoingCallScreen> createState() => _OutGoingCallScreenState();
}

class _OutGoingCallScreenState extends State<OutGoingCallScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/roshni.jpg', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),

          // Blurred background overlay (optional)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                // Top Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back, color: Colors.white),
                      const Spacer(),
                      // Optionally add timer or other elements
                    ],
                  ),
                ),
                const SizedBox(height: 50),

                // Circular Avatar
                Center(
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      image: const DecorationImage(
                        image: AssetImage('assets/roshni.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Name and Status
                const Text(
                  'Roshni Thakur',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Calling...',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),

                const Spacer(),

                // Bottom Button Row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildIconButton(Icons.volume_up),
                      _buildIconButton(Icons.mic),
                      _buildIconButton(Icons.call_end, color: Colors.red),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, {Color color = Colors.white}) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color),
    );
  }
}
