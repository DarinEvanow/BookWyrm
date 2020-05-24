import React from 'react';
import * as SC from './styles';

const BookImage: React.FC<{ src: any }> = ({ src }) => {
  return <SC.BookImage src={src} />;
};

export default BookImage;
