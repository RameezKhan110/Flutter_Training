const String collectionsQuery = r'''
  query CollectionsQuery {
    collections(first: 1) {
        collections_list: edges {
            collection_details: node {
                id
                handle
                title
                image {
                    originalSrc
                }
                products(first: 10) {
                    productsList: edges {
                        cursor
                        product: node {
                            id
                            title
                            vendor
                            availableForSale
                            priceRange {
                                maxVariantPrice {
                                    amount
                                    currencyCode
                                }
                                minVariantPrice {
                                    amount
                                    currencyCode
                                }
                            }
                            images(first: 100) {
                                nodes {
                                    originalSrc
                                }
                            }
                        }
                    }
                }
            }
        }
    }
  }
''';
