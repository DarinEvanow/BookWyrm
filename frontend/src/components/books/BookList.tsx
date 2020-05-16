import React from 'react';
import { IBook } from '../../common/types';
import Book from './Book';
import * as SC from './styles';

const Books: React.FC<{ books: IBook[] }> = ({ books }) => {
  console.log(books);

  return (
    <SC.BookList>
      {books.map((book: IBook) => (
        <Book id={book.id} title={book.title} authors={book.authors} />
      ))}
    </SC.BookList>
  );
};

export default Books;
