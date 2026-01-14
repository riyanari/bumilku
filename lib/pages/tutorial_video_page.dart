import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../theme/theme.dart';

class TutorialVideoPage extends StatefulWidget {
  const TutorialVideoPage({super.key});

  @override
  State<TutorialVideoPage> createState() => _TutorialVideoPageState();
}

class _TutorialVideoPageState extends State<TutorialVideoPage> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;
  double _progress = 0.0;
  bool _isLoading = true;
  bool _isExpanded = false; // State untuk expanded mode

  // Video ID dari URL: https://youtu.be/rqInLGiWO60?si=ETQ4JQnMt4VJPlhv
  static const String _videoId = 'rqInLGiWO60';

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _initializePlayer() {
    // Extract video ID dari URL
    final videoId = YoutubePlayer.convertUrlToId(
      'https://youtu.be/rqInLGiWO60?si=ETQ4JQnMt4VJPlhv',
    ) ?? _videoId;

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: false,
        hideControls: false,
        controlsVisibleAtStart: true,
        hideThumbnail: false,
        isLive: false,
        loop: false,
        forceHD: false,
        disableDragSeek: false,
      ),
    )..addListener(_playerListener);

    // Simulasi loading
    _simulateLoading();
  }

  void _playerListener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {});
    }
  }

  void _simulateLoading() async {
    for (int i = 0; i <= 100; i += 10) {
      await Future.delayed(const Duration(milliseconds: 100));
      if (mounted) {
        setState(() {
          _progress = i / 100;
        });
      }
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _goLogin() {
    Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          // Background dengan gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  kPrimaryColor.withValues(alpha:0.1),
                  kBackgroundColor.withValues(alpha:0.3),
                  kBackgroundColor,
                ],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Custom AppBar
                _buildCustomAppBar(),

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        // Video Player Section
                        _buildVideoSection(),

                        // Expand/Collapse Button
                        _buildExpandButton(),

                        // const SizedBox(height: 12),

                        // Tutorial Steps (tampilkan hanya jika tidak expanded)
                        if (!_isExpanded) ...[
                          _buildTutorialSteps(),
                          const SizedBox(height: 30),

                          // Action Button
                          _buildActionButton(),
                          const SizedBox(height: 30),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomAppBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: kPrimaryColor.withValues(alpha:0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: kPrimaryColor,
                size: 20,
              ),
              padding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tutorial Aplikasi',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Pelajari cara penggunaan',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _goLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              elevation: 0,
            ),
            child: const Text(
              'Skip',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoSection() {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = 80.0;
    final topPadding = 20.0;

    // Hitung height dinamis berdasarkan state expanded
    double videoHeight = _isExpanded
        ? screenHeight - appBarHeight - topPadding - 120 // Tinggi maksimal
        : 280; // Tinggi default

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _isExpanded ? 0 : 16,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: _isExpanded
              ? BorderRadius.zero
              : BorderRadius.circular(20),
          boxShadow: _isExpanded
              ? []
              : [
            BoxShadow(
              color: kPrimaryColor.withValues(alpha:0.2),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: _isExpanded
              ? BorderRadius.zero
              : BorderRadius.circular(20),
          child: Container(
            color: Colors.black,
            height: videoHeight,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // YouTube Player
                if (!_isLoading)
                  YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: kPrimaryColor,
                    progressColors: ProgressBarColors(
                      playedColor: kPrimaryColor,
                      handleColor: kPrimaryColor,
                      backgroundColor: Colors.grey[300]!,
                      bufferedColor: Colors.grey[200]!,
                    ),
                    onReady: () {
                      setState(() {
                        _isPlayerReady = true;
                      });
                    },
                    bottomActions: [
                      CurrentPosition(),
                      const ProgressBar(isExpanded: true),
                      RemainingDuration(),
                      const PlaybackSpeedButton(),
                      FullScreenButton(),
                    ],
                  ),

                // Loading Overlay
                if (_isLoading)
                  Container(
                    color: Colors.black,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: CircularProgressIndicator(
                                  value: _progress,
                                  strokeWidth: 4,
                                  valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                                  backgroundColor: Colors.white.withValues(alpha:0.1),
                                ),
                              ),
                              Icon(
                                Icons.play_circle_filled,
                                color: kPrimaryColor,
                                size: 40,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '${(_progress * 100).toInt()}%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Menyiapkan tutorial...',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha:0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              onPressed: _toggleExpand,
              icon: Icon(
                _isExpanded ? Icons.expand_less : Icons.expand_more,
                color: kPrimaryColor,
                size: 28,
              ),
              tooltip: _isExpanded ? 'Perkecil Video' : 'Perbesar Video',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTutorialSteps() {
    final List<Map<String, dynamic>> steps = [
      {
        'icon': Icons.play_circle_fill,
        'title': 'Tonton Video',
        'description': 'Simak video tutorial sampai selesai',
        'color': kPrimaryColor,
      },
      {
        'icon': Icons.account_circle,
        'title': 'Buat Akun',
        'description': 'Daftar dengan data diri yang valid',
        'color': Colors.blue,
      },
      {
        'icon': Icons.explore,
        'title': 'Jelajahi Fitur',
        'description': 'Temukan semua fitur menarik aplikasi',
        'color': Colors.green,
      },
      {
        'icon': Icons.star,
        'title': 'Nikmati Pengalaman',
        'description': 'Gunakan aplikasi dengan maksimal',
        'color': Colors.orange,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8, bottom: 12),
            child: Text(
              'Langkah-langkah:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          ...steps.map((step) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha:0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: (step['color'] as Color).withValues(alpha:0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      step['icon'] as IconData,
                      color: step['color'] as Color,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step['title'] as String,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          step['description'] as String,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.check_circle,
                    color: step['color'] as Color,
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: _goLogin,
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 5,
            shadowColor: kPrimaryColor.withValues(alpha:0.3),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Mulai Sekarang',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha:0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}