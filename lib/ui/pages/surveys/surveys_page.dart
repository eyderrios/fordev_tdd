// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fordev_tdd/ui/components/components.dart';
import 'package:fordev_tdd/ui/pages/surveys/surveys.dart';

import '../../helpers/i18n/i18n.dart';

class SurveysPage extends StatelessWidget {
  final SurveysPresenter presenter;

  // ignore: use_key_in_widget_constructors
  const SurveysPage(
    this.presenter,
  );

  @override
  Widget build(BuildContext context) {
    presenter.loadData();

    return Scaffold(
      appBar: AppBar(title: Text(R.strings.surveys)),
      body: Builder(builder: (context) {
        presenter.isLoadingStream.listen((isLoading) {
          if (isLoading) {
            showLoadingSpinner(context);
          } else {
            hideLoadingSpinner(context);
          }
        });

        return StreamBuilder<List<SurveyViewModel>>(
            stream: presenter.surveysStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Container(
                  padding: const EdgeInsets.all(20.0),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        snapshot.error as String,
                        style: const TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.center,
                      ),
                      ElevatedButton(
                        onPressed: presenter.loadData,
                        child: Text(R.strings.reload),
                      ),
                    ],
                  ),
                );
              }

              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      aspectRatio: 1,
                    ),
                    items: snapshot.data!
                        .map((viewModel) => SurveyItem(viewModel: viewModel))
                        .toList(),
                  ),
                );
              }

              return const SizedBox();
            });
      }),
    );
  }
}
