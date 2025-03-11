import 'package:flutter/material.dart';
import 'package:flutter_training/model/popular_movies.dart';
import 'package:flutter_training/provider/search_provider.dart';
import 'package:flutter_training/utils/app_fonts.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SearchProvider>().getPopularMovies(1);
    });

    return Consumer<SearchProvider>(
      builder:
          ((context, provider, child) =>
              provider.isPopularMoviesLoading
                  ? Scaffold(
                    appBar: AppBar(title: Text("Popular Movies")),
                    body: Center(child: CircularProgressIndicator()),
                  )
                  : Scaffold(
                    appBar: AppBar(title: Text("Popular Movies")),
                    body: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return ItemPopularMovies(
                            popularMoviesResult:
                                provider.popularMovies!.results![index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 10);
                        },
                        itemCount: provider.popularMovies!.results!.length,
                      ),
                    ),
                  )),
    );
  }
}

class ItemPopularMovies extends StatelessWidget {
  final Results popularMoviesResult;

  const ItemPopularMovies({super.key, required this.popularMoviesResult});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    softWrap: true,
                    "${popularMoviesResult.title}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeights.boldFontWeight,
                      color: Colors.black,
                    ),
                  ),
                ),

                SizedBox(width: 5,),
                Text(
                  "${popularMoviesResult.releaseDate}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeights.semiBoldFontWeight,
                    color: Colors.black,
                  ),
                ),
              ],
            ),

            SizedBox(height: 10,),

            Text(
              "${popularMoviesResult.overview}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeights.mediumFontWeight,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
