import 'package:flutter/material.dart';
import 'package:myfluffy/screen/FindPage.dart';

class Reel extends StatefulWidget {
  final name;
  final description;
  final location;
  final image;
  final reward;

  const Reel(
      {Key? key,
      this.name,
      this.description,
      this.location,
      this.image,
      this.reward})
      : super(key: key);

  @override
  State<Reel> createState() => _ReelState();
}

class _ReelState extends State<Reel> {
  String? currentImage;
  bool _isTapped = false;

  @override
  void initState() {
    super.initState();
    currentImage = widget.image;
  }

  void changeImage(String newImage) {
    setState(() {
      currentImage = newImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffFDFDFD),
            Color(0xfffdfdfd),
            Color(0xffE4E4E4),
          ],
        ),
      ),
      child: Stack(
        children: <Widget>[
          // The image covering the entire screen
          Positioned.fill(
            child: Image.asset(
              '$currentImage',
              fit: BoxFit.cover, // Ensures the image covers the whole screen
            ),
          ),
          // Semi-transparent overlay if tapped
          if (_isTapped)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          // Other components are placed on top of the image
          Column(
            children: [
              SizedBox(height: 44),
              Center(
                child: Text('${widget.name}',
                    style: TextStyle(
                         color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w500)),
              ),
              SizedBox(height: 14),
              if (_isTapped)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Icon(Icons.location_on, color: Colors.white, size: 25),
                      SizedBox(width: 5),
                      Column(
                        children: [
                          Text('${widget.location}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w300)),
                        ],
                      ),
                      Spacer(),
                      Container(
                        height: 61,
                        child: VerticalDivider(
                          color: Color(0xffB2B2B2),
                          thickness: 1,
                          width: 1,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.attach_money, color: Colors.white, size: 25),
                      SizedBox(width: 5),
                      Column(
                        children: [
                          Text('${widget.reward}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w300)),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),

              SizedBox(height: 16),
              SizedBox(height: 16),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 24,
            child: Column(
              children: [
                Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                   size: 32,
                ),
                Text('12.5k',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                SizedBox(height: 24),
                Icon(
                  Icons.share,
                   color: Colors.white,
                  size: 32.0,
                ),
                Text('12.5k',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                SizedBox(height: 24),
                Icon(Icons.more_horiz,color: Colors.white, size: 32),
                SizedBox(height: 24),
              ],
            ),
          ),
          Positioned(
            left: 24,
            bottom: _isTapped ? 120 : 24,
            child: Container(
              width: 283,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.account_circle,
                          color: Colors.white, size: 32),
                      SizedBox(width: 8),
                      Text('John Doe',
                          style: TextStyle(
                              color: _isTapped
                                  ? Colors.white
                                  : Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      Container(
                        width: 283,
                        height: 43,
                        decoration: BoxDecoration(
                          color: Color(0xffFFFFFF),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      //navigate to FindPage
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const FindPage()),
                                      );
                                  },
                                    child: Text(
                                      'more details',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(Icons.arrow_forward_ios,
                                      size: 16, color: Colors.black),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 3),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isTapped = !_isTapped;
                          });
                        },
                        child: Container(
                          height: 30,
                          child: Text(
                            '${widget.description}',
                            style: TextStyle(
                              fontSize: 12,
                              color: _isTapped
                                  ? Colors.white
                                  : Colors.white,
                            ),
                            maxLines: _isTapped ? 10 : 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
