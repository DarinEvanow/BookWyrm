import React from 'react';
import gql from 'graphql-tag';
import { Query } from 'react-apollo';

const GET_BOOKS_QUERY = gql`
  query GetBooks {
    books {
      title
    }
  }
`;

interface Data {
  books: Array<{ title: string }>;
}

const Loading: React.FC = () => {
  return <div>Loading</div>;
};

const Error: React.FC = () => {
  return <div>Error</div>;
};

const Result: React.FC<{ books: any }> = ({ books }) => {
  return books.map((book: any) => <div>{book.title}</div>);
};

const Home: React.FC = () => {
  return (
    <Query<Data> query={GET_BOOKS_QUERY}>
      {({ data, loading, error }) => {
        if (loading) return <Loading />;
        if (error) {
          console.log(error);
          return <Error />;
        }
        return <Result books={data?.books} />;
      }}
    </Query>
  );
};

export default Home;
