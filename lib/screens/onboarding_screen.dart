// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onboard/utilities/styles.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;

//* пишем сюда кол-во страничек, инициализируем переменную приватную, их 3 будет
//* final чисто для объявления

  final PageController _pageController = PageController(
      initialPage: 0); //*специально от флаттера штука для контроля страниц

  int _currentPage = 0; //* первая страница, значит 0 по счету

  List<Widget> _buildPageIndicator() {
    //* here я делаю массив индикаторов для отображения, на какой страничке находимся
    List<Widget> list = []; //* тот самый массив, куда вставляются индикаторы
    for (int i = 0; i < _numPages; i++) {
      //* цикл фо, от первой до последней по одной прибавляется точечка
      list.add(i == _currentPage
          ? _indicator(true)
          : _indicator(
              false)); //* если currentPage, то индикатор состояния True (вкл, т.е)
    }
    return list; //* в конце запускается лист наш;));)
  }

  Widget _indicator(bool isActive) {
    //*виджет индикатора,
    return AnimatedContainer(
      //* Animated Container
      duration:
          const Duration(milliseconds: 150), //*перемещения время при свайпе
      margin: const EdgeInsets.symmetric(
          horizontal: 8.0), //* расстояние между индикаторами с помощью марджина
      height: 8.0, //* высота индикатора

      width: isActive ? 24.0 : 16.0, //* высота индикатора
      decoration: BoxDecoration(
        //* ? белого цвета : фиолетовый при трогании
        color: isActive ? Colors.white : const Color(0xFF7B51D3),
        borderRadius:
            const BorderRadius.all(Radius.circular(12)), //* точно круглые будут
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle
            .light, //* SystemUiOverlayStyle - над экраном иконки меняют свет
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Color(0xFF3594DD),
                Color(0xFF4563DB),
                Color(0xFF5036D5),
                Color(0xFF5B16D0),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 10.0), //*вертикальный отступ
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 600.0, //* padding from the top of the screen
                  child: PageView(
                    //* pageView
                    physics:
                        const ClampingScrollPhysics(), //* то, с какой физикой оно свайпается
                    controller: _pageController, //* контролирует странички
                    onPageChanged: (int page) {
                      //* тоже штука от ПейджВью для отображения страниц
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, //* в самом начале ставится виджет
                          children: const <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/onboarding0.png',
                                ),
                                height: 300.0,
                                width: 300.0,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              'Connect people\naround the world',
                              style: kTitleStyle,
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Share your unique interests and stories with new friends from around the world. Go get it you always wanted to have!',
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/onboarding1.png',
                                ),
                                height: 300.0,
                                width: 300.0,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              'Live your life smarter\nwith us!',
                              style: kTitleStyle,
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'We provide a safe environment for people to share their interests in a more meaningful way with our members.',
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/onboarding2.png',
                                ),
                                height: 300.0,
                                width: 300.0,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              'Attain a new experience',
                              style: kTitleStyle,
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'We’re here to help people rediscover the joy of thoughtful communication and genuine friendships.',
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  //* Здесь мы делаем эти индикаторы в Роу, я попробовал в Колонке, такое себе... и align по центру
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                //! уравнение,
                _currentPage != _numPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: TextButton(
                            //? ниже будет интерпретация кнопки перехода и анимации перехода на другую страницу
                            onPressed: () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 350),
                                curve: Curves.linearToEaseOut,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              //* mainaxis это то, сколько пространства занимать будет виджет
                              mainAxisSize: MainAxisSize.min,
                              children: const <Widget>[
                                Text(
                                  'Next',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: 80.0,
              width: double.infinity,
              color: Colors.white,
              child: GestureDetector(
                onTap: () => print('Get started'),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30.0, top: 30),
                    child: Text(
                      'Get started',
                      style: TextStyle(
                        color: Color(0xFF5B16D0),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : const Text(''),
    );
  }
}
