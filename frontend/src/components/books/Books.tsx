import React from 'react';
import { Book } from '../../common/types';

const Books: React.FC<{ books: Book[] }> = ({ books }) => {
  return (
    <>
      {books.map((book: Book) => (
        <div>{book.title}</div>
      ))}
    </>
  );
};

export default Books;
