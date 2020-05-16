import React from 'react';
import gql from 'graphql-tag';
import { Query } from 'react-apollo';
import { Book } from '../../common/types';

import Home from './Home';
import Error from '../error/Error';
import Loading from '../loading/Loading';

export const GET_BOOKS_QUERY = gql`
  query GetBooks {
    books {
      id
      title
    }
  }
`;

const HomeContainer: React.FC = () => {
  return (
    <Query<{ books: Book[] }> query={GET_BOOKS_QUERY}>
      {({ data, loading, error }) => {
        if (loading) return <Loading />;
        if (error) return <Error error={error} />;
        return <Home books={data?.books} />;
      }}
    </Query>
  );
};

export default HomeContainer;
