import React from 'react';
import { Book } from '../../common/types';

const Home: React.FC<{ books: Book[] | undefined }> = ({ books }) => {
  return (
    <div>
      {books?.map((book: any) => (
        <React.Fragment key={book.id}>
          <div>{book.title}</div>
        </React.Fragment>
      ))}
    </div>
  );
};

export default Home;
