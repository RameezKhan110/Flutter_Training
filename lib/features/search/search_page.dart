import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training/model/popular_movies.dart';
import 'package:flutter_training/provider/search_cubit.dart';
import 'package:flutter_training/utils/app_fonts.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {

    final cubit = context.read<SearchCubit>();
    if (cubit.state is SearchApiInitial) {
      cubit.getPopularMovies(1);
    }
    
    return Scaffold(
      appBar: AppBar(title: Text("Popular Movies")),
      body: BlocBuilder<SearchCubit, SearchApiState>(
        builder: (context, state) {
          if (state is SearchApiLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SearchApiSuccess) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ItemPopularMovies(
                    popularMoviesResult: state.data.results![index],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemCount: state.data.results!.length,
              ),
            );
          } else {
            return Container();
          }
        },
      ),
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

                SizedBox(width: 5),
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

            SizedBox(height: 10),

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
