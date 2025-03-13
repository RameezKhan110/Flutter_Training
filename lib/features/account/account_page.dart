import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training/provider/account_cubit.dart';

import '../../model/TopRatedMovies.dart';
import '../../utils/app_fonts.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {

    final cubit = context.read<AccountCubit>();
    if (cubit.state is AccountApiInitial) {
      cubit.getTopRatedMovies(1);
    }
    return Scaffold(
      appBar: AppBar(title: Text("Top Rated Movies")),
      body: BlocBuilder<AccountCubit, AccountApiState>(
        builder: (context, state) {
          if (state is AccountApiLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is AccountApiSuccess) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ItemTopRatedMovies(
                    topRatedMoviesResult:
                        state.data.results![index],
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

class ItemTopRatedMovies extends StatelessWidget {
  final Results topRatedMoviesResult;

  const ItemTopRatedMovies({super.key, required this.topRatedMoviesResult});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      color: Colors.white,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl:
                  "https://image.tmdb.org/t/p/w500${topRatedMoviesResult.posterPath}",
              placeholder: (context, url) => Container(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        softWrap: true,
                        "${topRatedMoviesResult.title}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeights.boldFontWeight,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    SizedBox(width: 5),
                    Text(
                      "${topRatedMoviesResult.releaseDate}",
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
                  "${topRatedMoviesResult.overview}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeights.mediumFontWeight,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
