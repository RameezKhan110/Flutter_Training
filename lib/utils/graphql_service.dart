import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {

  late final GraphQLClient client;
  final HttpLink httpLink = HttpLink(
    'https://379923-7e.myshopify.com/api/2024-10/graphql.json',
    defaultHeaders: {
      'X-Shopify-Storefront-Access-Token': 'd885c1c7722a638ec9c2703288b0c90f',
      'Content-Type': 'application/json',
    },
  );

  final Policies defaultPolicies = Policies(
    cacheReread: CacheRereadPolicy.ignoreAll,
    fetch: FetchPolicy.cacheFirst,
  );

  GraphQLService() {
    client = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
      defaultPolicies: DefaultPolicies(
        query: defaultPolicies,
      ),
    );
  }

  Future<QueryResult> query(String query) async {
    QueryOptions options = QueryOptions(
      document: gql(query),
      fetchPolicy: FetchPolicy.networkOnly,
      pollInterval: Duration(minutes: 1),
    );

    try {
      var result = await client.query(options);
      return result;
    } catch (e) {
      print('error : ${e.toString()}');
      rethrow;
    }
  }
}