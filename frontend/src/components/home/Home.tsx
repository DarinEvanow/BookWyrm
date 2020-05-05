import React from 'react';
import gql from 'graphql-tag';
import { Query } from 'react-apollo';
import { Book } from '../../common/types';

import Books from '../books/Books';
import Error from '../error/Error';
import Loading from '../loading/Loading';

const GET_BOOKS_QUERY = gql`
  query GetBooks {
    books {
      title
    }
  }
`;

const Home: React.FC = () => {
  return (
    <Query<{ books: Book[] }> query={GET_BOOKS_QUERY}>
      {({ data, loading, error }) => {
        if (loading) return <Loading />;
        if (error) return <Error error={error} />;
        return (
          <div>
            {data?.books.map((book: any) => (
              <div>{book.title}</div>
            ))}
          </div>
        );
      }}
    </Query>
  );
};

export default Home;
