import React from 'react';
import { IBook } from '../../common/types';
import Book from './Book';
import * as SC from './styles';

const Books: React.FC<{ listTitle: string; books: IBook[] }> = ({
  listTitle,
  books,
}) => {
  return (
    <SC.BookListContainer>
      <SC.BookListTitle>{listTitle}</SC.BookListTitle>
      <SC.BookList>
        {books.map((book: IBook) => (
          <Book id={book.id} title={book.title} authors={book.authors} />
        ))}
      </SC.BookList>
    </SC.BookListContainer>
  );
};

export default Books;
