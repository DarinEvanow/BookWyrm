import React from 'react';
import { IBook } from '../../common/types';
import BookList from '../books/BookList';

const Home: React.FC<{ books: IBook[] }> = ({ books }) => {
  return (
    <>
      <BookList listTitle="Currently reading" books={books} />
      <BookList listTitle="Want to read" books={books} />
    </>
  );
};

export default Home;
