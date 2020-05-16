import React from 'react';
import { IBook } from '../../common/types';
import BookImage from './BookImage';
import * as SC from './styles';
import aWildSheepChase from '../../assets/book_covers/murakami/a_wild_sheep_chase.jpg';

const Book: React.FC<IBook> = ({ title, authors }) => {
  console.log(authors);

  return (
    <SC.Book>
      <BookImage src={aWildSheepChase} />
      <p>{title}</p>
      <p>by Haruki Murakami</p>
    </SC.Book>
  );
};

export default Book;
