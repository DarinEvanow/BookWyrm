import React from 'react';
import { IBook } from '../../common/types';
import BookList from '../books/BookList';

const Home: React.FC<{ books: IBook[] }> = ({ books }) => {
  return <BookList books={books} />;
};

export default Home;
